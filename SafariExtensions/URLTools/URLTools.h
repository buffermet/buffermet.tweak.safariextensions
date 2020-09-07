@interface URLTools : NSObject
+(NSRegularExpression *)anchorSpecifierToRegexpIgnoreCase:(NSString *)anchorSpecifier;
+(NSRegularExpression *)domainSpecifierToRegexpIgnoreCase:(NSString *)domainSpecifier;
+(NSArray *)getDecodedURLParameters:(NSString *)encoded;
+(NSArray *)getHeaderParts:(NSString *)headerValue;
+(NSDictionary *)getHeaders:(NSString *)rawHeaders;
+(NSRegularExpression *)pathSpecifierToRegexpIgnoreCase:(NSString *)pathSpecifier;
+(NSRegularExpression *)portSpecifierToRegexpIgnoreCase:(NSString *)portSpecifier;
+(NSRegularExpression *)protocolSpecifierToRegexpIgnoreCase:(NSString *)protocolSpecifier;
+(NSRegularExpression *)querySpecifierToRegexpIgnoreCase:(NSString *)querySpecifier;
+(NSString *)stripAllTrailingWhitespaces:(NSString *)str;
+(NSString *)stripTrailingDoubleQuotes:(NSString *)str;
//+(NSString *)stripTrailingWhitespaces:(NSString *)str;
+(NSURL *)upgradeNSURLProtocol:(NSURL *)URL;
+(NSArray *)URLSpecifierToRegexpIgnoreCaseSet:(NSString *)urlSpecifier;
@end

