#import "../URLTools/URLTools.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface WebRequest : NSObject
-(NSMutableURLRequest *)detailsObjectToNSMutableURLRequest:(NSDictionary *)details;
-(NSMutableDictionary *)NSURLRequestToDetailsObject:(NSURLRequest *)request;
-(void)addListener:(id)listenerObj;
-(NSMutableDictionary *)newOnBeforeRequestListenerDetailsObject;
-(NSDictionary *)newOnResponseStartedListenerDetailsObject;
//-(id)handleOnBeforeRequest:(NSURLRequest *)request;
-(NSURLRequest *)handleOnBeforeSendHeaders:(NSURLRequest *)request;
@end

