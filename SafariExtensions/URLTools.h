@interface URLTools : NSObject
+(NSRegularExpression *)domainSpecifierToRegexpIgnoreCase:(NSString *)domainSpecifier;
+(NSArray *)getDecodedURLParameters:(NSString *)encoded;
+(NSArray *)getHeaderParts:(NSString *)headerValue;
+(NSDictionary *)getHeaders:(NSString *)rawHeaders;
+(NSRegularExpression *)pathSpecifierToRegexpIgnoreCase:(NSString *)pathSpecifier;
+(NSString *)stripAllTrailingWhitespace:(NSString *)str;
+(NSString *)stripTrailingDoubleQuote:(NSString *)str;
//+(NSString *)stripTrailingWhitespace:(NSString *)str;
+(NSURL *)upgradeNSURLProtocol:(NSURL *)URL;
@end

