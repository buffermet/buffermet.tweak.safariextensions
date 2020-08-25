@interface URLTools : NSObject
+(NSRegularExpression *)domainSpecifierToRegexpIgnoreCase:(NSString *)domainSpecifier;
+(NSArray *)getDecodedURLParameters:(NSString *)encoded;
+(NSRegularExpression *)pathSpecifierToRegexpIgnoreCase:(NSString *)pathSpecifier;
+(NSString *)stripTrailingWhitespace:(NSString *)str;
+(NSURL *)upgradeNSURLScheme:(NSURL *)URL;
@end

