@interface URLTools : NSObject
+(NSRegularExpression *)domainSpecifierToRegexpIgnoreCase:(NSString *)domainSpecifier;
+(NSArray *)getDecodedURLParameters:(NSString *)encoded;
+(NSURL *)upgradeScheme:(NSURL *)URL;
@end

