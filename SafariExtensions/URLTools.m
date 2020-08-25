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
  Returns an array of decoded URL form values.

  @[
    @[@"name", @"value1", @"value2"],
    @["nameWithoutValue"]
  ]
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

