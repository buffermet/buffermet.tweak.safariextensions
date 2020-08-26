#import "URLTools.h"

@implementation URLTools

/**
 * Returns a regexp selector using the specified domain specifier.
 * Domain specifiers can contain a wildcard at the start of a domain
 * (e.g. *.google.com). "<all_urls>" is treated as `.*`
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
    withTemplate:@"((?:[a-z0-9](?:[a-z0-9-]{0,61}[a-z0-9])?.)+)"];
  regexp = [NSRegularExpression
    regularExpressionWithPattern:@"[.]"
    options:NSRegularExpressionCaseInsensitive
    error:nil];
  domainSpecifier = [regexp
    stringByReplacingMatchesInString:domainSpecifier
    options:0
    range:NSMakeRange(0, [domainSpecifier length])
    withTemplate:@"\\."];
  return [NSRegularExpression
    regularExpressionWithPattern:domainSpecifier
    options:NSRegularExpressionCaseInsensitive
    error:nil];
}

/**
 * Returns an array of decoded URL form values.
 * (example: @[@[@"name", @"value1", @"value2"], @["nameWithoutValue"]])
 */
+(NSArray *)getDecodedURLParameters:(NSString *)encoded {
  NSMutableArray * arr = [NSMutableArray array];
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
 * Returns an array of strings that were separated by ";".
 * (example: @[@"form-data", @"name=\"attachment\"", @"filename=\"/path/img.png\""])
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
 */
+(NSArray *)anchorSpecifierToRegexpIgnoreCase:(NSString *)anchorSpecifier {
  NSString * openingSquareBracketTag = [[NSProcessInfo processInfo] globallyUniqueString];
  NSRegularExpression * regexp = [NSRegularExpression // [ and ]
    regularExpressionWithPattern:@"[[]"
    options:NSRegularExpressionCaseInsensitive
    error:nil];
  anchorSpecifier = [regexp
    stringByReplacingMatchesInString:anchorSpecifier
    options:0
    range:NSMakeRange(0, [anchorSpecifier length])
    withTemplate:openingSquareBracketTag];
  regexp = [NSRegularExpression
    regularExpressionWithPattern:@"[]]"
    options:NSRegularExpressionCaseInsensitive
    error:nil];
  anchorSpecifier = [regexp
    stringByReplacingMatchesInString:anchorSpecifier
    options:0
    range:NSMakeRange(0, [anchorSpecifier length])
    withTemplate:@"[]]"];
  anchorSpecifier = [regexp
    stringByReplacingMatchesInString:openingSquareBracketTag
    options:0
    range:NSMakeRange(0, [anchorSpecifier length])
    withTemplate:@"[[]"];
  regexp = [NSRegularExpression /* ( */
    regularExpressionWithPattern:@"[(]"
    options:NSRegularExpressionCaseInsensitive
    error:nil];
  anchorSpecifier = [regexp
    stringByReplacingMatchesInString:anchorSpecifier  
    options:0
    range:NSMakeRange(0, [anchorSpecifier length])
    withTemplate:@"[(]"];
  regexp = [NSRegularExpression /* ) */
    regularExpressionWithPattern:@"[)]"
    options:NSRegularExpressionCaseInsensitive
    error:nil];
  anchorSpecifier = [regexp
    stringByReplacingMatchesInString:anchorSpecifier  
    options:0
    range:NSMakeRange(0, [anchorSpecifier length])
    withTemplate:@"[)]"];
  regexp = [NSRegularExpression /* { */
    regularExpressionWithPattern:@"[{]"
    options:NSRegularExpressionCaseInsensitive
    error:nil];
  anchorSpecifier = [regexp
    stringByReplacingMatchesInString:anchorSpecifier  
    options:0
    range:NSMakeRange(0, [anchorSpecifier length])
    withTemplate:@"[{]"];
  regexp = [NSRegularExpression /* } */
    regularExpressionWithPattern:@"[}]"
    options:NSRegularExpressionCaseInsensitive
    error:nil];
  anchorSpecifier = [regexp
    stringByReplacingMatchesInString:anchorSpecifier  
    options:0
    range:NSMakeRange(0, [anchorSpecifier length])
    withTemplate:@"[}]"];
  regexp = [NSRegularExpression /* \ */
    regularExpressionWithPattern:@"[\\]"
    options:NSRegularExpressionCaseInsensitive
    error:nil];
  anchorSpecifier = [regexp
    stringByReplacingMatchesInString:anchorSpecifier  
    options:0
    range:NSMakeRange(0, [anchorSpecifier length])
    withTemplate:@"[\\]"];
  regexp = [NSRegularExpression /* * */
    regularExpressionWithPattern:@"[*]"
    options:NSRegularExpressionCaseInsensitive
    error:nil];
  anchorSpecifier = [regexp
    stringByReplacingMatchesInString:anchorSpecifier  
    options:0
    range:NSMakeRange(0, [anchorSpecifier length])
    withTemplate:@"[*]"];
  regexp = [NSRegularExpression /* | */
    regularExpressionWithPattern:@"[|]"
    options:NSRegularExpressionCaseInsensitive
    error:nil];
  anchorSpecifier = [regexp
    stringByReplacingMatchesInString:anchorSpecifier  
    options:0
    range:NSMakeRange(0, [anchorSpecifier length])
    withTemplate:@"[|]"];
  return [NSRegularExpression
    regularExpressionWithPattern:anchorSpecifier
    options:0
    range:
  ];
}

+(NSArray *)pathSpecifierToRegexpIgnoreCase:(NSString *)pathSpecifier {
  return nil;
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

+(NSRegularExpression *)schemeSpecifierToRegexpIgnoreCase:(NSString *)schemeSpecifier {
  NSRegularExpression * regexp = [NSRegularExpression
    regularExpressionWithPattern:@"[*]"
    options:NSRegularExpressionCaseInsensitive
    error:nil];
  schemeSpecifier = [regexp
    stringByReplacingMatchesInString:schemeSpecifier
    options:0
    range:NSMakeRange(0, [schemeSpecifier length])
    withTemplate:@"[a-z-]+"];
  return [NSRegularExpression
    regularExpressionWithPattern:schemeSpecifier
    options:NSRegularExpressionCaseInsensitive
    error:nil];
}

+(NSURL *)upgradeNSURLScheme:(NSURL *)URL {
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
  NSString * schemeSpecifier = [regexp
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
    [self schemeSpecifierToRegexpIgnoreCase:schemeSpecifier],
    [self domainSpecifierToRegexpIgnoreCase:domainSpecifier],
    [self pathSpecifierToRegexpIgnoreCase:pathSpecifier],
    [self querySpecifierToRegexpIgnoreCase:querySpecifier],
    [self anchorSpecifierToRegexpIgnoreCase:anchorSpecifier]
  ];
}

@end

