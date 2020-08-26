@interface URLTools : NSObject
+(NSRegularExpression *)domainSpecifierToRegexpIgnoreCase:(NSString *)domainSpecifier;
+(NSArray *)getDecodedURLParameters:(NSString *)encoded;
+(NSArray *)getHeaderParts:(NSString *)headerValue;
+(NSDictionary *)getHeaders:(NSString *)rawHeaders;
+(NSRegularExpression *)pathSpecifierToRegexpIgnoreCase:(NSString *)pathSpecifier;
+(NSString *)stripTrailingWhitespace:(NSString *)str;
+(NSURL *)upgradeNSURLScheme:(NSURL *)URL;
@end

