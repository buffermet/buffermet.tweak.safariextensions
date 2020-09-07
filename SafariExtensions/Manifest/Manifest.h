@interface Manifest : NSObject
+(NSDictionary *)parseManifest:(NSString *)encodedJSON;
@end

