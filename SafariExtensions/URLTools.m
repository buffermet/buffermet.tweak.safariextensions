#import "URLTools.h"

@implementation URLTools

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

/*
 *  Returns an array of decoded URL form values.
 *
 *  @[
 *    @[@"name", @"value1", @"value2"],
 *    @["nameWithoutValue"]
 *  ]
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

/*
 *  Returns a dictionary of headers that were found in a string
 *
 *  @{
 *    @"Content-Type": @["multipart/form-data; boundary=\"538948530\""],
 *    @"User-Agent": @["Mozilla ..."]
 *  }
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

/*
 *  Returns an array of strings that were separated by ";".
 *
 *  @[
 *    @"form-data",
 *    @"name=\"attachment\"",
 *    @"filename=   \"/Users/buffermet/lol.png\""
 *  ]
 */
+(NSArray *)getHeaderParts(NSString *)headerValue {
  NSMutableArray * arr = [NSMutableArray array];
  NSArray * matches = [headerValue
    componentsSeparatedByString:@";"];
  for (NSString * match in matches) {
    [arr addObject:stripTrailingWhitespace(match)];
  }
  return arr;
}

+(NSURL *)upgradeScheme:(NSURL *)URL {
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

@end

