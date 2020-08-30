@interface SEWebRequest : NSObject
-(NSMutableURLRequest *)detailsObjectToNSMutableURLRequest:(NSDictionary *)details;
-(NSMutableDictionary *)NSURLRequestToDetailsObject:(NSURLRequest *)request;
-(void)addListener:(id)listenerObj;
-(NSMutableDictionary *)newListenerDetailsObject;
//-(id)handleOnBeforeRequest:(NSURLRequest *)request;
-(NSURLRequest *)handleOnBeforeSendHeaders:(NSURLRequest *)request;
@end

