#import "URLTools.h"

@implementation URLTools

/**
 * Returns a case insensitive regexp selector that will match the specified anchor string.
 * (wilcards are not allowed)
 * (example input: @"#anyBytes...")
 * (example output: [NSRegularExpression
 *   regularExpressionWithPattern:@"#anyBytes\\.\\.\\."
 *   options:NSRegularExpressionCaseInsensitive]
 *   error:nil)]
 */
+(NSRegularExpression *)anchorSpecifierToRegexpIgnoreCase:(NSString *)anchorSpecifier {
  NSRegularExpression * regexp = [NSRegularExpression
    regularExpressionWithPattern:@"[.?[\\]{}()*\\\\|]"
    options:NSRegularExpressionCaseInsensitive
    error:nil];
  anchorSpecifier = [regexp
    stringByReplacingMatchesInString:anchorSpecifier  
    options:0
    range:NSMakeRange(0, [anchorSpecifier length])
    withTemplate:@"\\$1"];
  return [NSRegularExpression
    regularExpressionWithPattern:anchorSpecifier
    options:NSRegularExpressionCaseInsensitive
    error:nil];
}

/**
 * Returns a case insensitive regexp selector using the specified domain specifier string.
 * Domain specifiers can contain a wildcard to specify subdomains.
 * Use "<all_urls>" to specify all domains.
 * (example input: @"*.example.org"). 
 * (example output: [NSRegularExpression
 *   regularExpressionWithPattern:@"(?:[a-z0-9](?:[a-z0-9-]{0,61}[a-z0-9])?.)+\\.example\\.org"
 *   options:NSRegularExpressionCaseInsensitive
 *   error:nil]"
 */
+(NSRegularExpression *)domainSpecifierToRegexpIgnoreCase:(NSString *)domainSpecifier {
  NSRegularExpression * regexp = [NSRegularExpression
    regularExpressionWithPattern:@"[-]"
    options:NSRegularExpressionCaseInsensitive
    error:nil];
  domainSpecifier = [regexp
    stringByReplacingMatchesInString:domainSpecifier
    options:0
    range:NSMakeRange(0, [domainSpecifier length])
    withTemplate:@"\\-"];
  regexp = [NSRegularExpression
    regularExpressionWithPattern:@"^[*][.]"
    options:NSRegularExpressionCaseInsensitive
    error:nil];
  domainSpecifier = [regexp
    stringByReplacingMatchesInString:domainSpecifier
    options:0 
    range:NSMakeRange(0, [domainSpecifier length])
    withTemplate:@"(?:[a-z0-9](?:[a-z0-9-]{0,61}[a-z0-9])?.)+"];
  regexp = [NSRegularExpression
    regularExpressionWithPattern:@"[.]"
    options:NSRegularExpressionCaseInsensitive
    error:nil];
  domainSpecifier = [regexp
    stringByReplacingMatchesInString:domainSpecifier
    options:0 
    range:NSMakeRange(0, [domainSpecifier length])
    withTemplate:@"\\."];
  regexp = [NSRegularExpression
    regularExpressionWithPattern:@"<all_urls>"
    options:NSRegularExpressionCaseInsensitive
    error:nil];
  domainSpecifier = [regexp
    stringByReplacingMatchesInString:domainSpecifier
    options:0
    range:NSMakeRange(0, [domainSpecifier length])
    withTemplate:@".*"];
  return [NSRegularExpression
    regularExpressionWithPattern:domainSpecifier
    options:NSRegularExpressionCaseInsensitive
    error:nil];
}

/**
 * Returns a dictionary of decoded URL form values.
 * (example input: "?data=A93j20%3D%3D&protocol=https%3A&protocol=wss%3A&a")
 * (example output: @{@"data":@[@"A93j20=="], @"protocol":@[@"https:", @"wss:"], @"a":@[]})
 */
+(NSDictionary *)getDecodedURLParameters:(NSString *)encoded {
  NSMutableDictionary * dict = [NSMutableDictionary new];
  encoded = [[NSRegularExpression
    regularExpressionWithPattern:@"[+]"
    options:0
    error:nil]
      stringByReplacingMatchesInString:encoded
      options:0
      range:NSMakeRange(0, [encoded length])
      withTemplate:@" "];
  NSArray * encodedParams = [encoded
    componentsSeparatedByString:@"&"];
  for (NSString * thisParam in encodedParams) {
    const NSArray * const encodedParamParts = [thisParam
      componentsSeparatedByString:@"="];
    NSString * decodedParamName = [encodedParamParts[0]
      stringByRemovingPercentEncoding];
    NSMutableArray * decodedValues = [NSMutableArray array];
    NSArray * encodedValues = [encodedParamParts
      subarrayWithRange:NSMakeRange(1, [encodedParamParts count] - 1)];
    for (NSString * thisEncodedValue in encodedValues) {
      const NSString * const thisDecodedValue = [thisEncodedValue
        stringByRemovingPercentEncoding];
      [decodedValues addObject:thisDecodedValue];
    }
    if (!dict[decodedParamName]) {
      dict[decodedParamName] = [NSMutableArray array];
    }
    dict[decodedParamName] = [dict[decodedParamName]
      arrayByAddingObjectsFromArray:decodedValues];
  }
  return dict;
}

/**
 * Returns an array of strings that were separated by ";" and stripped from trailing
 * whitespaces.
 * (example input: @"form-data; name=\"attachment\"; filename=\"/path/img.png\"")
 * (example output: @[@"form-data", @"name=\"attachment\"", @"filename=\"/path/img.png\""])
 */
+(NSArray *)getHeaderParts:(NSString *)headerValue {
  NSMutableArray * arr = [NSMutableArray array];
  NSArray * matches = [headerValue
    componentsSeparatedByString:@";"];
  for (NSString * match in matches) {
    [arr addObject:[self
      stripAllTrailingWhitespaces:match]];
  }
  return arr;
}

/**
 * Returns a dictionary of headers that were found in a string
 * @{
 *   @"Content-Type": @["multipart/form-data; boundary=\"538948530\""],
 *   @"User-Agent": @["Mozilla ..."]
 * }
 */
+(NSDictionary *)getHeaders:(NSString *)rawHeaders {
  NSMutableDictionary * dict = [NSMutableDictionary new];
  for (NSString * headerString in [rawHeaders
    componentsSeparatedByString:@"\r\n"]
  ) {
    NSRegularExpression * regexp = [NSRegularExpression
      regularExpressionWithPattern:@"^\\s*(.*?)\\s*:\\s*(.*?)\r\n$"
      options:NSRegularExpressionCaseInsensitive
      error:nil];
    const NSString * const name = [regexp
      stringByReplacingMatchesInString:headerString
      options:0
      range:NSMakeRange(0, [headerString length])
      withTemplate:@"$1"];
    const NSString * const value = [regexp
      stringByReplacingMatchesInString:headerString
      options:0
      range:NSMakeRange(0, [headerString length])
      withTemplate:@"$2"];
    if (![name isEqual:@""]) {
      if (dict[name]) {
        [dict[name] addObject:value];
      } else {
        dict[name] = @[value];
      }
    }
  }
  return dict;
}

/**
 * Returns a case insensitive regexp selector that will match the specified path string.
 * (wilcards are allowed)
 * (example input: @"/api/something-*")
 * (example output: [NSRegularExpression
 *   regularExpressionWithPattern:@"/api/something-.*"
 *   options:NSRegularExpressionCaseInsensitive
 *   error:nil)]
 */
+(NSRegularExpression *)pathSpecifierToRegexpIgnoreCase:(NSString *)pathSpecifier {
  NSRegularExpression * regexp = [NSRegularExpression
    regularExpressionWithPattern:@"[.?[\\]{}()\\\\|]"
    options:NSRegularExpressionCaseInsensitive
    error:nil];
  pathSpecifier = [regexp
    stringByReplacingMatchesInString:pathSpecifier
    options:0
    range:NSMakeRange(0, [pathSpecifier length])
    withTemplate:@"\\$1"];
  regexp = [NSRegularExpression
    regularExpressionWithPattern:@"[*]"
    options:NSRegularExpressionCaseInsensitive
    error:nil];
  pathSpecifier = [regexp
    stringByReplacingMatchesInString:pathSpecifier  
    options:0
    range:NSMakeRange(0, [pathSpecifier length])
    withTemplate:@".*"];
  return [NSRegularExpression
    regularExpressionWithPattern:pathSpecifier
    options:NSRegularExpressionCaseInsensitive
    error:nil];
}

/**
 * Returns a case insensitive regexp selector using the specified port string.
 * (example input: @":443")
 * (example output: [NSRegularExpression
 *   regularExpressionWithPattern:@":443"
 *   options:NSRegularExpressionCaseInsensitive
 *   error:nil])
 */
+(NSRegularExpression *)portSpecifierToRegexpIgnoreCase:(NSString *)portSpecifier {
  return [NSRegularExpression
    regularExpressionWithPattern:portSpecifier
    options:NSRegularExpressionCaseInsensitive
    error:nil];
}

/**
 * Returns a case insensitive regexp selector using the specified protocol string.
 * (example input: @"*:")
 * (example output: [NSRegularExpression
 *   regularExpressionWithPattern:@"[a-z-]+:"
 *   options:NSRegularExpressionCaseInsensitive
 *   error:nil])
 */
+(NSRegularExpression *)protocolSpecifierToRegexpIgnoreCase:(NSString *)protocolSpecifier {
  NSRegularExpression * regexp = [NSRegularExpression
    regularExpressionWithPattern:@"[*]"
    options:NSRegularExpressionCaseInsensitive
    error:nil];
  protocolSpecifier = [regexp
    stringByReplacingMatchesInString:protocolSpecifier
    options:0
    range:NSMakeRange(0, [protocolSpecifier length])
    withTemplate:@"[a-z-]+"];
  return [NSRegularExpression
    regularExpressionWithPattern:protocolSpecifier
    options:NSRegularExpressionCaseInsensitive
    error:nil];
}

/**
 * Returns a case insensitive regexp selector that will match the specified query string.
 * (wilcards are allowed)
 * (example input: @"?param=value&darkmode=1&data=AjujNW%3D%3D")
 * (example output: [NSRegularExpression
 *   regularExpressionWithPattern:@"\\?param=value&darkmode=1&data=AjujNW%3D%3D"
 *   options:NSRegularExpressionCaseInsensitive
 *   error:nil)]
 */
+(NSRegularExpression *)querySpecifierToRegexpIgnoreCase:(NSString *)querySpecifier {
  NSRegularExpression * regexp = [NSRegularExpression
    regularExpressionWithPattern:@"[.?[\\]{}()\\\\|]"
    options:NSRegularExpressionCaseInsensitive
    error:nil];
  querySpecifier = [regexp
    stringByReplacingMatchesInString:querySpecifier  
    options:0
    range:NSMakeRange(0, [querySpecifier length])
    withTemplate:@"\\$1"];
  regexp = [NSRegularExpression
    regularExpressionWithPattern:@"[*]"
    options:NSRegularExpressionCaseInsensitive
    error:nil];
  querySpecifier = [regexp
    stringByReplacingMatchesInString:querySpecifier  
    options:0
    range:NSMakeRange(0, [querySpecifier length])
    withTemplate:@".*"];
  return [NSRegularExpression
    regularExpressionWithPattern:querySpecifier
    options:NSRegularExpressionCaseInsensitive
    error:nil];
}

/**
 * Removes all whitespace at the start and end of a string.
 */
+(NSString *)stripAllTrailingWhitespaces:(NSString *)str {
  const NSRegularExpression * const regexTrailingWhitespace = [NSRegularExpression
    regularExpressionWithPattern:@"^\\s*(.*)\\s*$"
    options:0
    error:nil];
  return [regexTrailingWhitespace
    stringByReplacingMatchesInString:str
    options:0
    range:NSMakeRange(0, [str length])
    withTemplate:@"$1"];
}

/**
 * Removes a double quote at the start and end of a string.
 */
+(NSString *)stripTrailingDoubleQuotes:(NSString *)str {
  const NSRegularExpression * const regexTrailingWhitespace = [NSRegularExpression
    regularExpressionWithPattern:@"^[\"]?(.*)[\"]?$"
    options:0
    error:nil];
  return [regexTrailingWhitespace
    stringByReplacingMatchesInString:str
    options:0
    range:NSMakeRange(0, [str length])
    withTemplate:@"$1"];
}

/**
 * Upgrades the specified NSURL's protocol (http: and ws:).'
 * (example input: [NSURL URLWithString:@"http://www.example.org/"])
 * (example output: [NSURL URLWithString:@"https://www.example.org/"])
 */
+(NSURL *)upgradeNSURLProtocol:(NSURL *)URL {
  NSString * const insecureURL = [NSString
    stringWithFormat:@"%@", [URL absoluteURL]];
  NSRegularExpression * regexp = [NSRegularExpression
    regularExpressionWithPattern:@"(http|ws):"
    options:NSRegularExpressionCaseInsensitive
    error:nil];
  NSString * secureURL = [regexp
    stringByReplacingMatchesInString:insecureURL
    options:0
    range:NSMakeRange(0, [insecureURL length])
    withTemplate:@"$1s:"];
  return [NSURL URLWithString:secureURL];
}

/**
 * Returns a case insensitive regexp selector for a given URI specifier.
 * (example input: @"*://example.org/test*")
 * (example output: [NSRegularExpression
 *   regularExpressionWithPattern:@".*?[:][/][/]example[.]org[/]test.*?"
 *   options:NSRegularExpressionCaseInsensitive
 *   error:nil])
 */
+(NSRegularExpressionCaseInsensitive *)URLSpecifierToRegexpIgnoreCase:(NSString *)uriSpecifier {
  NSRegularExpression * regexp = [NSRegularExpression
    regularExpressionWithPattern:@"[^*\]a-z0-9]"
    options:NSRegularExpressionCaseInsensitive
    error:nil];
  NSString * selector = [regexp
    stringByReplacingMatchesInString:uriSpecifier
    options:0
    range:NSMakeRange(0, [insecureURL length])
    withTemplate:@"[$1]"];
  regexp = [NSRegularExpression
    regularExpressionWithPattern:@"[*]"
    options:NSRegularExpressionCaseInsensitive
    error:nil];
  selector = [regexp
    stringByReplacingMatchesInString:uriSpecifier
    options:0
    range:NSMakeRange(0, [insecureURL length])
    withTemplate:@".*?"];
  return [NSRegularExpression
    regularExpressionWithPattern:selector
    options:NSRegularExpressionCaseInsensitive
    error:nil];
}

@end

