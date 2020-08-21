/*

  * We can use existing HTTP fields to pass along frame ID
    (i.e. HTTP method only accepts alphabetical characters, allowing
    serialization)


*/

#import "SEWebRequest.h"
#import "URLTools.h"

/*
// example hook.js
browser.webRequest.onBeforeRequest.addListener(
  async details => {
    details.url = "https://www.abcdefg.com/";
  },
  {"urls":["<all_urls>"]},
  ["blocking","requestBody"]
);
*/

/*
// example listener object
{
  "callback": "function(details){details.url='https://www.example.com/';}",
  "filter": {},
  "extraInfoSpec": []
}
*/

/*
// example of assembled webrequest payload

*/

const NSString * const rawRequestDetailsObject = @"{\
  \"cookieStoreId\": null,\
  \"documentURL\": null,\
  \"frameAncestors\": {\
    \"url\": null,\
    \"frameId\": null,\
  },\
  \"frameId\": null,\
  \"incognito\": null,\
  \"method\": null,\
  \"originUrl\": null,\
  \"parentFrameId\": null,\
  \"proxyInfo\": {\
    \"host\": null,\
    \"port\": null,\
    \"type\": null,\
    \"username\": null,\
    \"proxyDNS\": null,\
    \"failoverTimeout\": null\
  },\
  \"requestBody\": {\
    \"error\": null,\
    \"formData\": null,\
    \"raw\": null\
  },\
  \"requestId\": null,\
  \"tabId\": null,\
  \"thirdParty\": null,\
  \"timeStamp\": null,\
  \"type\": null,\
  \"url\": null,\
  \"urlClassification\": {\
    \"firstParty\": null,\
    \"thirdParty\": null\
  }\
}";

@implementation SEWebRequest

-(void)addListener:(id)listenerObj {
  if (![listenerObj
    objectForKey:@"listener"]) {
    // return error
  }
  if (![listenerObj
    objectForKey:@"filter"]) {
    // return error
  }
  if (![listenerObj
    objectForKey:@"extraInfoSpec"]) {
    // return error
  }
  // add listener if not already existing
}

-(NSDictionary *)newListenerDetailsObject {
  NSData * data = [rawRequestDetailsObject
    dataUsingEncoding:NSUTF8StringEncoding];
  return [NSJSONSerialization
    JSONObjectWithData:data
    options:0
    error:nil];
}

-(NSURLRequest *)detailsObjectToNSMutableURLRequest:(id)details {
  return nil;
}

-(NSURLRequest *)detailsObjectToNSURLRequest:(id)details {
  return nil;
}

-(id)NSURLRequestToDetailsObject:(NSURLRequest *)request {
  NSMutableDictionary * details = [self newListenerDetailsObject];
  NSURL * URL = [request URL];
//  \"cookieStoreId\": null,
//  \"documentURL\": null,
  [details
    setObject:[request mainDocumentURL]
    forKey:@"documentURL"];
//  \"frameAncestors\": null,
//  \"url\": null,
  [details
    setObject:[URL absoluteURL]
    forKey:@"url"];
//  \"frameId\": null,
//  \"incognito\": null,
//  \"method\": null,
  NSString * const methodString = [request HTTPMethod];
  NSRegularExpression * regexp = [NSRegularExpression
    regularExpressionWithPattern:@"(\d+),([A-Z]+)"
    options:NSRegularExpressionCaseInsensitive
    error:nil];
  const NSNumber * const requestID = [[regexp
    stringByReplacingMatchesInString:methodString
    options:0
    range:NSMakeRange(0, [methodString length])
    withTemplate:@"$1"] intValue];
  const NSString * const method = [regexp
    stringByReplacingMatchesInString:methodString
    options:0
    range:NSMakeRange(0, [methodString length])
    withTemplate:@"$2"];
  [details
    setObject:method
    forKey:@"method"];
//  \"originUrl\": null,
//  \"parentFrameId\": null,
//  \"proxyInfo\": {
//    \"host\": null,
//    \"port\": null,
//    \"type\": null,
//    \"username\": null,
//    \"proxyDNS\": null,
//    \"failoverTimeout\": null
//  },
//  \"requestBody\": {
//    \"error\": null,
//    \"formData\": null,
//    \"raw\": null
  const NSString * const contentType = [[request
    valueForHTTPHeaderField:@"Content-Type"] lowercaseString];
  if (
       [[request HTTPMethod] isEqual:@"POST"]
    && (
         [contentType isEqual:@"multipart/form-data"]
      || [contentType isEqual:@"application/x-www-form-urlencoded"])
  ) {
    // parse formdata
  } else if () {
    
  }
//  },
//  \"requestId\": null,
//  \"tabId\": null,
//  \"thirdParty\": null,
//  \"timeStamp\": null,
  [details
    setObject:[NSNumber numberWithDouble:[[NSDate date] timeIntervalSince1970]]
    forKey:@"timeStamp"];
//  \"type\": null,
//  \"url\": null,
//  \"urlClassification\": {
//    \"firstParty\": null,
//    \"thirdParty\": null
//  }
  return details;
}

/*
=============================================================
// example parsed extensions.json
"0": { // extension ID
  "manifest": {
    // ...
  },
  "webRequest": {
    "onAuthRequired": {},
    "onBeforeRequest": [
      {
        "callback": "",
        "filter": {},
        "extraInfoSpec": []
      },
      {
        "callback": "",
        "filter": {},
        "extraInfoSpec": []
      }
    ],
    "onBeforeSendHeaders": {},
    "onHeadersReceived": {}     
  }
}
============================================================
*/
-(NSURLRequest *)handleOnBeforeRequest:(NSURLRequest *)request forWebView:(id)webView {
/*
  NSDictionary * details = [self NSURLRequestToDetailsObject:request];
  for (NSString * extensionID in [extensions allKeys]) {
    BOOL isPermittedWebRequest = [extensions[extensionID][@"manifest"][@"permissions"]
      hasObject:@"webRequest"];
    BOOL isPermittedWebRequestBlocking = [extensions[extensionID][@"manifest"][@"permissions"]
      hasObject:@"webRequestBlocking"];
    const NSDictionary * const listeners = extensions
      [extensionID]
      [@"webRequest"]
      [@"onBeforeRequest"];
    for (NSString listenerID in [listeners allKeys]) {
      const NSDictionary * const listener = listeners[listenerID];
      const NSDictionary * const callback = listener[@"callback"];
      const NSDictionary * const filter = listener[@"filter"];
      const NSArray * const extraInfoSpec = listener[@"extraInfoSpec"];
      BOOL isBlocking = [extraInfoSpec hasObject:@"blocking"];
      // Create a copy of details with its current (post-handled) state
      // which will be handled by async listeners only but will not
      // affect the returning request. There is an order in which
      // extensions handle requests which is determined by the user.
      if (isBlocking) {
        if (isPermittedWebRequestBlocking) {
          // callback has already been prepared so it returns the details object as a string
          
        } else {
          // throw some error here
        }
      } else {
        dispatch_async(
          dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
          ^(NSDictionary * detailsCopy){
            // async listener
          }
        );
      }
      const NSDictionary * detailsCopy = [details copy];
      
    }
  }
*/
  // generate request details object using original NSURLRequest
  // run details object through all listeners
  //   async for non-blocking requests
  // parse new details object and return as NSURLRequest
  return nil;
}

@end

