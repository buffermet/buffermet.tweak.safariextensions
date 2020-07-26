@interface URLTools : NSObject
+(NSRegularExpression *)domainSpecifierToRegexpIgnoreCase:(NSString *)domainSpecifier;
+(NSURL *)upgradeScheme:(NSURL *)URL;
@end

