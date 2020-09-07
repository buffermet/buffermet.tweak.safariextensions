@interface SEManifest : NSObject
+(NSDictionary *)parseManifest:(NSString *)encodedJSON;
@end

