@interface SEWebRequest : NSObject
-(NSURLRequest *)detailsObjectToNSURLRequest:(id)details;
-(id)NSURLRequestToDetailsObject:(NSURLRequest *)request;
-(void)addListener:(id)listenerObj;
-(id)newListenerDetailsObject;
@end

