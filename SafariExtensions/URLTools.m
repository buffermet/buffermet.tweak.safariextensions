#import "URLTools.h"

@implementation URLTools

/**
 * Returns a regexp selector using the specified domain specifier string.
 * Domain specifiers can contain a wildcard at the start of a domain
 * (example input: *.google.com). 
 * (example output: [NSRegularExpression
 *   regularExpressionWithPattern:@""
                             *   :])
 **/
+(NSRegularExpression *)domainSpecifierToRegexpIgnoreCase:(NSString *)domainSpecifier {
  NSRegularExpression * regexp = [NSRegularExpression
    regularExpressionWithPattern:@"[-]"
    options:0
    error:nil];
  domainSpecifier = [regexp
    stringByReplacingMatchesInString:domainSpecifier
    options:0
    range:NSMakeRange(0, [domainSpecifier length])
    withTemplate:@"\\-"];
  regexp = [NSRegularExpression
    regularExpressionWithPattern:@"^[*][.]"
    options:0
    error:nil];
  domainSpecifier = [regexp
    stringByReplacingMatchesInString:domainSpecifier
    options:0
    range:NSMakeRange(0, [domainSpecifier length])
    withTemplate:@"((?:[a-z0-9](?:[a-z0-9-]{0,61}[a-z0-9])?.)+)"];
  regexp = [NSRegularExpression
    regularExpressionWithPattern:@"[.]"
    options:0
    error:nil];
  domainSpecifier = [regexp
    stringByReplacingMatchesInString:domainSpecifier
    options:0
    range:NSMakeRange(0, [domainSpecifier length])
    withTemplate:@"\\."];
  regexp = [NSRegularExpression
    regularExpressionWithPattern:@"<all_urls>"
    options:0
    error:nil];
  domainSpecifier = [regexp
    stringByReplacingMatchesInString:domainSpecifier
    options:0
    range:NSMakeRange(0, [domainSpecifier length])
    withTemplate:@".*"];
  return [NSRegularExpression
    regularExpressionWithPattern:domainSpecifier
    options:0
    error:nil];
}

/**
 * Returns a dictionary of decoded URL form values.
 * (example input: "?data=A93j20%3D%3D&protocol=https%3A&protocol=wss%3A&a")
 * (example output: @{@"data": @[@"A93j20=="], @"protocol": @[@"https:", @"wss:"]})
 */
+(NSDictionary *)getDecodedURLParameters:(NSString *)encoded {
  NSMutableArray * dict = [NSMutableDictionary new];
  NSArray * params = [encoded
    componentsSeparatedByString:@"&"];
  const NSRegularExpression * const regexPlusSymbol = [NSRegularExpression
    regularExpressionWithPattern:@"[+]"
    options:NSRegularExpressionCaseInsensitive
    error:nil];
  for (NSString * thisParam in params) {
    const NSString * const thisParamEscaped = [regexPlusSymbol
      stringByReplacingMatchesInString:thisParam
      options:0
      range:NSMakeRange(0, [thisParam length])
      withTemplate:@" "];
    NSMutableArray * decodedParams = [NSMutableArray array];
    NSArray * encodedParams = [thisParamEscaped
      componentsSeparatedByString:@"="];
    for (NSString * thisEncodedParam in encodedParams) {
      [decodedParams
        addObject:[thisEncodedParam stringByRemovingPercentEncoding]];
    }
    [arr addObject:decodedParams];
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
      stripTrailingWhitespace:match]];
  }
  return arr;
}

/**
 * Returns a regexp selector that will match the specified anchor string.
 * (wilcards are not allowed)
 * (example input: @"#anyBytes()")
 * (example output: [NSRegularExpression
 *   regularExpressionWithPattern:@"#anyBytes\\(\\)"
 *   options:NSRegularExpressionCaseInsensitive]
 *   error:nil)]
 */
+(NSRegularExpression *)anchorSpecifierToRegexpIgnoreCase:(NSString *)anchorSpecifier {
  NSRegularExpression * regexp = [NSRegularExpression
    regularExpressionWithPattern:@"[?[\\]{}()*\\\\]"
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
 * Returns a regexp selector that will match the specified path string.
 * (wilcards are allowed)
 * (example input: @"/api/*")
 * (example output: [NSRegularExpression
 *   regularExpressionWithPattern:@"/api/.*"
 *   options:NSRegularExpressionCaseInsensitive]
 *   error:nil)]
 */
+(NSArray *)pathSpecifierToRegexpIgnoreCase:(NSString *)pathSpecifier {
  NSRegularExpression * regexp = [NSRegularExpression
    regularExpressionWithPattern:@"[?[\\]{}()\\\\]"
    options:NSRegularExpressionCaseInsensitive
    error:nil];
  anchorSpecifier = [regexp
    stringByReplacingMatchesInString:anchorSpecifier  
    options:0
    range:NSMakeRange(0, [anchorSpecifier length])
    withTemplate:@"\\$1"];
  NSRegularExpression * regexp = [NSRegularExpression
    regularExpressionWithPattern:@"[*]"
    options:NSRegularExpressionCaseInsensitive
    error:nil];
  anchorSpecifier = [regexp
    stringByReplacingMatchesInString:anchorSpecifier  
    options:0
    range:NSMakeRange(0, [anchorSpecifier length])
    withTemplate:@".*"];
  return [NSRegularExpression
    regularExpressionWithPattern:anchorSpecifier
    options:NSRegularExpressionCaseInsensitive
    error:nil];
}

+(NSArray *)querySpecifierToRegexpIgnoreCase:(NSString *)querySpecifier {
  return nil;
}

/**
 * Removes all whitespace at the start and end of a string.
 */
+(NSString *)stripTrailingWhitespace:(NSString *)str {
  const NSRegularExpression * const regexTrailingWhitespace = [NSRegularExpression
    regularExpressionWithPattern:@"^\\s*(.*)\\s*$"
    options:NSRegularExpressionCaseInsensitive
    error:nil];
  return [regexTrailingWhitespace
    stringByReplacingMatchesInString:str
    options:0
    range:NSMakeRange(0, [str length])
    withTemplate:@"$1"];
}

/**
 * Returns a regexp selector using the specified protocol string.
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

+(NSURL *)upgradeNSURLprotocol:(NSURL *)URL {
  NSString * const insecureURL = [NSString
    stringWithFormat:@"%@", [URL absoluteURL]];
  NSError * err = nil;
  NSRegularExpression * regexp = [NSRegularExpression
    regularExpressionWithPattern:@"^\\s*http:"
    options:NSRegularExpressionCaseInsensitive
    error:&err];
  NSString * secureURL = [regexp
    stringByReplacingMatchesInString:insecureURL
    options:0
    range:NSMakeRange(0, [insecureURL length])
    withTemplate:@"https:"];
  return [NSURL URLWithString:secureURL];
}

+(NSArray *)urlSpecifierToRegexpIgnoreCaseSet:(NSString *)urlSpecifier {
  NSRegularExpression * regexp = [NSRegularExpression
    regularExpressionWithPattern:@"((?:[a-z-]+|[*]):)//((?:\\*\\.[a-z]{1,63}|(?:(?:\\*\\.|)(?:[a-z0-9](?:[a-z0-9-]{0,61}[a-z0-9])?\\.)+(?:[a-z]{1,63})))(/[^?#]*)([?][^#]+)?([#].*)?"
    options:NSRegularExpressionCaseInsensitive
    error:nil];
  NSString * protocolSpecifier = [regexp
    stringByReplacingMatchesInString:urlSpecifier
    options:0
    range:NSMakeRange(0, [urlSpecifier length]) 
    withTemplate:@"$1"];
  NSString * domainSpecifier = [regexp
    stringByReplacingMatchesInString:urlSpecifier
    options:0
    range:NSMakeRange(0, [urlSpecifier length]) 
    withTemplate:@"$2"];
  NSString * pathSpecifier = [regexp
    stringByReplacingMatchesInString:urlSpecifier
    options:0
    range:NSMakeRange(0, [urlSpecifier length]) 
    withTemplate:@"$3"];
  NSString * querySpecifier = [regexp
    stringByReplacingMatchesInString:urlSpecifier
    options:0
    range:NSMakeRange(0, [urlSpecifier length]) 
    withTemplate:@"$4"];
  NSString * anchorSpecifier = [regexp
    stringByReplacingMatchesInString:urlSpecifier
    options:0
    range:NSMakeRange(0, [urlSpecifier length]) 
    withTemplate:@"$5"];
  return @[
    [self protocolSpecifierToRegexpIgnoreCase:protocolSpecifier],
    [self domainSpecifierToRegexpIgnoreCase:domainSpecifier],
    [self pathSpecifierToRegexpIgnoreCase:pathSpecifier],
    [self querySpecifierToRegexpIgnoreCase:querySpecifier],
    [self anchorSpecifierToRegexpIgnoreCase:anchorSpecifier]
  ];
}

@end

