// https://chromium.googlesource.com/chromium/src/+/master/extensions/browser/api
// https://chromium.googlesource.com/chromium/src/+/master/extensions/common/api/web_request.json
// https://searchfox.org/mozilla-central/rev/3345af4b5/toolkit/modules/addons/WebRequestUpload.jsm#258-269

#import <WebKit/WebKit.h>
#import "SEWebRequest.h"
#import "URLTools.h"
//#import "SEJSContext.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface NSURLRequestInternal
-(unsigned long long)hash;
@end

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

/*
// https://searchfox.org/mozilla-central/source/modules/libpref/init/all.js#4417

pref("webextensions.webRequest.requestBodyMaxRawBytes", 16777216);
*/

//const NSString * const rawRequestDetailsObject = @"{\
//  \"cookieStoreId\": null,\
//  \"documentURL\": null,\
//  \"frameAncestors\": {\
//    \"url\": null,\
//    \"frameId\": null,\
//  },\
//  \"frameId\": null,\
//  \"incognito\": null,\
//  \"method\": null,\
//  \"originUrl\": null,\
//  \"parentFrameId\": null,\
//  \"proxyInfo\": {\
//    \"host\": null,\
//    \"port\": null,\
//    \"type\": null,\
//    \"username\": null,\
//    \"proxyDNS\": null,\
//    \"failoverTimeout\": null\
//  },\
//  \"requestBody\": {\
//    \"error\": null,\
//    \"formData\": null,\
//    \"raw\": null\
//  },\
//  \"requestId\": null,\
//  \"tabId\": null,\
//  \"thirdParty\": null,\
//  \"timeStamp\": null,\
//  \"type\": null,\
//  \"url\": null,\
//  \"urlClassification\": {\
//    \"firstParty\": null,\
//    \"thirdParty\": null\
//  }\
//}";

NSArray * Uint8ArrayFromData(NSData * data) {
  const void * bytes = [data bytes];
  NSMutableArray * arr = [NSMutableArray array];
  for (NSUInteger i = 0; i < [data length]; i += sizeof(uint8_t)) {
    uint8_t el = OSReadLittleInt(bytes, i);
    [arr addObject:[NSNumber numberWithInt:el]];
  }
  return arr;
}

NSArray * int8ArrayFromData(NSData * data) {
  const void * bytes = [data bytes];
  NSMutableArray * arr = [NSMutableArray array];
  for (NSInteger i = 0; i < [data length]; i += sizeof(int8_t)) {
    int8_t el = OSReadLittleInt(bytes, i);
    [arr addObject:[NSNumber numberWithInt:el]];
  }
  return arr;
}

NSArray * int16ArrayFromData(NSData * data) {
  const void * bytes = [data bytes];
  NSMutableArray * arr = [NSMutableArray array];
  for (NSInteger i = 0; i < [data length]; i += sizeof(int16_t)) {
    int16_t el = OSReadLittleInt16(bytes, i);
    [arr addObject:[NSNumber numberWithInt:el]];
  }
  return arr;
}

NSArray * int32ArrayFromData(NSData * data) {
  const void * bytes = [data bytes];
  NSMutableArray * arr = [NSMutableArray array];
  for (NSInteger i = 0; i < [data length]; i += sizeof(int32_t)) {
    int32_t el = OSReadLittleInt32(bytes, i);
    [arr addObject:[NSNumber numberWithInt:el]];
  }
  return arr;
}

/**
 * Returns a pointer to an NSData instance using a given array of 8-bit unsigned integers.
 */
NSData * dataFromUint8Array(NSArray *)arr {
  unsigned length = [arr count];
  uint8_t * bytes = malloc(sizeof(* bytes) * length);
  unsigned i;
  for (i = 0; i < length; i++) {
    NSNumber * num = [arr objectAtIndex:i];
    int byte = [num unsignedCharValue];
    bytes[i] = byte;
  }
  return [NSData
    dataWithBytesNoCopy:bytes
    length:length
    freeWhenDone:YES];
}

/**
 * Returns a pointer to an NSData instance using a given array of 8-bit integers.
 */
NSData * dataFromInt8Array(NSArray *)arr {
  unsigned length = [arr count];
  int8_t * bytes = malloc(sizeof(* bytes) * length);
  unsigned i;
  for (i = 0; i < length; i++) {
    NSNumber * num = [arr objectAtIndex:i];
    int byte = [num charValue];
    bytes[i] = byte;
  }
  return [NSData
    dataWithBytesNoCopy:bytes
    length:length
    freeWhenDone:YES];
}

/**
 * Returns a pointer to an NSData instance using a given array of 16-bit integers.
 */
NSData * dataFromInt16Array(NSArray *)arr {
  unsigned length = [arr count];
  int16_t * bytes = malloc(sizeof(* bytes) * length);
  unsigned i;
  for (i = 0; i < length; i++) {
    NSNumber * num = [arr objectAtIndex:i];
    int byte = [num intValue];
    bytes[i] = byte;
  }
  return [NSData
    dataWithBytesNoCopy:bytes
    length:length
    freeWhenDone:YES];
}

/**
 * Returns a pointer to an NSData instance using a given array of 32-bit integers.
 */
NSData * dataFromInt32Array(NSArray *)arr {
  unsigned length = [arr count];
  int32_t * bytes = malloc(sizeof(* bytes) * length);
  unsigned i;
  for (i = 0; i < length; i++) {
    NSNumber * num = [arr objectAtIndex:i];
    int byte = [num longValue];
    bytes[i] = byte;
  }
  return [NSData
    dataWithBytesNoCopy:bytes
    length:length
    freeWhenDone:YES];
}

/**
 * Returns an array of strings that contain no more than 8192 unsigned chars using
 * a given input stream and size.
 */
NSArray * getBufferedStreamChunks(NSInputStream * inputStream, int size) {
  const int BUFFER_LENGTH = 8192;
  uint8_t buffer[size];
  NSMutableArray * arr = [NSMutableArray array];
  NSUInteger result;
  while (
    (result = [inputStream
      read:buffer
      maxLength:BUFFER_LENGTH])
  ) {
    if (result > 0) {
      [arr addObject:[NSString
        stringWithFormat:@"%s", buffer]];
    } else {
      break;
    }
  }
  return arr;
}

/**
 * Returns an array of strings that were split at a given bounday and contain
 * no more than 8192 unsigned chars using a given input stream and size.
 */
NSArray * getBufferedStreamChunksAndSplit(
  NSInputStream * inputStream,
  int size,
  NSString * boundary)
{
  const int BUFFER_LENGTH = 8192;
  uint8_t buffer[size];
  NSMutableArray * arr = [NSMutableArray array];
  NSUInteger result;
  while (
    (result = [inputStream
      read:buffer
      maxLength:BUFFER_LENGTH])
  ) {
    if (result > 0) {
      for (
        NSString * part in
          [[NSString stringWithFormat:@"%s", buffer]
            componentsSeparatedByString:boundary]
      ) {
        [arr addObject:part];
      }
    } else {
      break;
    }
  }
  return arr;
}

NSArray * getBufferedStringChunks(NSString * str, int size) {
  NSInputStream * const inputStream = [NSInputStream
    inputStreamWithData:[str
      dataUsingEncoding:NSUTF8StringEncoding]];
  return getBufferedStreamChunks(inputStream, size);
}

NSArray * getBufferedStringChunksAndSplit(NSString * str, int size, NSString * boundary) {
  NSInputStream * const inputStream = [NSInputStream
    inputStreamWithData:[str
      dataUsingEncoding:NSUTF8StringEncoding]];
  return getBufferedStreamChunksAndSplit(inputStream, size, boundary);
}

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
//  NSData * data = [rawRequestDetailsObject
//    dataUsingEncoding:NSUTF8StringEncoding];
//  return [NSJSONSerialization
//    JSONObjectWithData:data
//    options:0
//    error:nil];
  return nil;
}

-(NSMutableURLRequest *)detailsObjectToNSMutableURLRequest:(NSDictionary *)details {
  NSMutableURLRequest * request;
//  \"cookieStoreId\": null,
//  \"documentURL\": null,
  if (details[@"documentURL"]) {
    NSURL * url = [NSURL URLWithString:details[@"documentURL"]];
    request.mainDocumentURL = url;
  }
//  \"frameAncestors\": {
//    \"url\": null,
//    \"frameId\": null,
//  },
//  \"frameId\": null,
//  \"incognito\": null,
//  \"method\": null,
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
  if (details[@"requestBody"]) {
    JSValue * requestBody = details[@"requestBody"];
    if ([requestBody hasProperty:@"error"]) {
      // print the error in console
    }
    if ([requestBody hasProperty:@"formData"]) {
      JSValue * 
      
    }
    if ([requestBody hasProperty:@"raw"]) {
//      JSValue * arrayBuffer = [requestBody
//        valueForProperty:@"raw"];
//      NSArray * Uint8Array = [jsContext ]
    }  
  }
//  },
//  \"requestId\": null,
//  \"tabId\": null,
//  \"thirdParty\": null,
//  \"timeStamp\": null,
//  \"type\": null,
//  \"url\": null,
  if (details[@"url"]) {
    NSURL * url = [NSURL URLWithString:details[@"url"]];
    request.URL = url;
  }
//  \"urlClassification\": {
//    \"firstParty\": null,
//    \"thirdParty\": null
//  }
  return nil;
}

-(NSMutableDictionary *)NSURLRequestToDetailsObject:(NSURLRequest *)request {
  JSContext * jsContext = [%c(JSContext) new];
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
  const NSString * const method = [request HTTPMethod];
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
  JSValue * detailsRequestBody;
  JSValue * detailsRequestBodyError;
  JSValue * detailsRequestBodyFormData;
  JSValue * detailsRequestBodyRaw;
  NSString * const contentTypeLowercase = [[request
    valueForHTTPHeaderField:@"Content-Type"] lowercaseString];
  NSArray * contentTypeParameterString = [URLTools
    getHeaderParts:contentTypeLowercase];
  if ([contentTypeParameterString containsObject:@"multipart/form-data"]) {
    NSMutableDictionary * formData = [NSMutableDictionary new];
    /* debug */
    NSString * boundary = [[NSRegularExpression
      regularExpressionWithPattern:@".*;\\s*boundary=[\"](.*?)[\"].*"
      options:NSRegularExpressionCaseInsensitive
      error:nil]
        stringByReplacingMatchesInString:contentTypeLowercase
        options:0
        range:NSMakeRange(0, [contentTypeLowercase length])
        withTemplate:@"$1"];
    for (const NSString * thisFormDataPart in getBufferedStreamChunksAndSplit(
      [request HTTPBodyStream],
      [[request HTTPBody] length],
      boundary)
    ) {
      if ([thisFormDataPart isEqual:@""]) {
        continue;
      }
      if ([thisFormDataPart isEqual:@"--\r\n"]) {
        break;
      }
      const NSRange endRange = [thisFormDataPart
        rangeOfString:@"\r\n\r\n"];
      const NSUInteger endIx = endRange.location;
      const NSString * content = [thisFormDataPart
        substringWithRange:NSMakeRange(
          endIx + 4,
          [thisFormDataPart length] - (endIx + 4))];
      if (
           ![thisFormDataPart hasPrefix:@"\r\n"]
        || endIx == 0
        || endIx == NSNotFound
      ) {
        // throw error: Invalid MIME stream
        continue;
      }
      NSString * const rawHeaders = [thisFormDataPart
        substringWithRange:NSMakeRange(0, endIx)];
      NSDictionary * const thisFormDataPartHeaders = [URLTools
        getHeaders:rawHeaders];
      NSString * const contentDispositionString = thisFormDataPartHeaders[@"content-disposition"];
      if (
           !contentDispositionString
        || ![[URLTools
             getHeaderParts:contentDispositionString]
               containsObject:@"form-data"]
      ) {
        // throw error: invalid MIME stream: No valid Content-Disposition header
        continue;
      }
      NSArray * const headerParts = [URLTools
        getHeaderParts:contentDispositionString];
      NSString * name = @"";
      NSString * filename;
      for (NSString * thisHeaderPart in headerParts) {
        NSArray * decodedParams = [URLTools
          getDecodedURLParameters:thisHeaderPart];
        for (NSArray * thisParamSet in decodedParams) {
          if (
               [thisParamSet[0] isEqual:@"name"]
            && thisParamSet[1]
          ) {
            name = stripTrailingDoubleQuotes(thisParamSet[1]);
          }
          if (
               [thisParamSet[0] isEqual:@"filename"]
            && thisParamSet[1]
          ) {
            filename = stripTrailingDoubleQuotes(thisParamSet[1]);
          }
        }
        if ([name length] != 0 && filename) {
          break;
        }
      }
      if ([name isEqual:@""]) {
        // throw error: invalid MIME stream: No valid Content-Disposition header
        continue;
      }
      if (filename) {
        content = filename;
      }
      if (!formData[name]) {
        formData[name] = [NSMutableArray array];
      }
      formData[name] = [formData[name]
        arrayByAddingObject:content];
    }
    detailsRequestBodyFormData = [%c(JSValue)
      valueWithObject:formData
      inContext:jsContext];
  } else if ([contentTypeParameterString containsObject:@"application/x-www-form-urlencoded"]) {
    NSMutableDictionary * urlDecodedForm = [NSMutableDictionary new];
    const NSArray * bufferedChunks = getBufferedStreamChunks(
      [request HTTPBodyStream],
      [[request HTTPBody] length]);
    for (NSString * thisChunk in bufferedChunks) {
      NSArray * const decodedParams = [URLTools
        getDecodedURLParameters:thisChunk];
      for (NSArray * thisDecodedParamSet in decodedParams) {
        NSString * const paramName = thisDecodedParamSet[0];
        if (!urlDecodedForm[paramName]) {
          urlDecodedForm[paramName] = [NSMutableArray array];
        }
        urlDecodedForm[paramName] = [urlDecodedForm[paramName]
          arrayByAddingObjectsFromArray:[thisDecodedParamSet
            subarrayWithRange:NSMakeRange(1, [thisDecodedParamSet count] - 1)]];
      }
    }
    detailsRequestBodyFormData = [%c(JSValue)
      valueWithObject:urlDecodedForm
      inContext:jsContext];
  } else if (
       [method isEqual:@"PUT"]
    || [method isEqual:@"POST"]
  ) {
    // {raw: ArrayBuffer(...)}
    detailsRequestBodyRaw = [%c(JSValue)
      valueWithNewArrayInContext:jsContext];
    NSArray * bufferedChunks = getBufferedStreamChunks(
      [request HTTPBodyStream],
      [[request HTTPBody] length]);
    for (NSString * thisChunk in bufferedChunks) {
      JSValue * const detailsRequestBodyRawArrayItem = [%c(JSValue)
        valueWithNewObjectInContext:jsContext];
      JSValue * const detailsRequestBodyRawUint8Array = [jsContext[@"Uint8Array"]
        invokeMethod:@"from"
        withArguments:Uint8ArrayFromData([thisChunk
          dataUsingEncoding:NSUTF8StringEncoding])];
      JSValue * const detailsRequestBodyRawArrayBuffer = [detailsRequestBodyRawUint8Array
        valueForProperty:@"buffer"];
      [detailsRequestBodyRawArrayItem
        setValue:detailsRequestBodyRawArrayBuffer
        forProperty:@"bytes"];
      [detailsRequestBodyRaw
        invokeMethod:@"push"
        withArguments:@[detailsRequestBodyRawArrayItem]];
    }
  }
  if (detailsRequestBodyError) {
    detailsRequestBody = [%c(JSValue)
      valueWithNewObjectInContext:jsContext];
    [detailsRequestBody
      setValue:detailsRequestBodyError
      forProperty:@"error"];
    details[@"requestBody"] = detailsRequestBody;
  } else if (detailsRequestBodyFormData) {
    detailsRequestBody = [%c(JSValue)
      valueWithNewObjectInContext:jsContext];
    [detailsRequestBody
      setValue:detailsRequestBodyFormData
      forProperty:@"formData"];
    details[@"requestBody"] = detailsRequestBody;
  } else if (detailsRequestBodyRaw) {
    detailsRequestBody = [%c(JSValue)
      valueWithNewObjectInContext:jsContext];
    [detailsRequestBody
      setValue:detailsRequestBodyRaw
      forProperty:@"raw"];
    details[@"requestBody"] = detailsRequestBody;
  }
//  },
//  \"requestId\": null,

/*
  NSDictionary * request ....
  unsigned long long requestHash = [MSHookIvar<NSURLRequestInternal *>(
    request,
    "_internal") hash];
*/

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

-(NSURLRequest *)handleOnBeforeRequest:(NSURLRequest *)request {
/*
  NSDictionary * details = [self NSURLRequestToDetailsObject:request];
  for (NSString * extensionID in [extensions allKeys]) {
    BOOL isPermittedWebRequest = [extensions[extensionID][@"manifest"][@"permissions"]
      containsObject:@"webRequest"];
    BOOL isPermittedWebRequestBlocking = [extensions[extensionID][@"manifest"][@"permissions"]
      containsObject:@"webRequestBlocking"];
    const NSDictionary * const listeners = extensions
      [extensionID]
      [@"webRequest"]
      [@"onBeforeRequest"];
    for (NSString listenerID in [listeners allKeys]) {
      const NSDictionary * const listener = listeners[listenerID];
      const NSDictionary * const callback = listener[@"callback"];
      const NSDictionary * const filter = listener[@"filter"];
      const NSArray * const extraInfoSpec = listener[@"extraInfoSpec"];
      BOOL isBlocking = [extraInfoSpec containsObject:@"blocking"];
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
  // generate request details object using original NSURLRequest
  // run details object through all listeners
  //   async for non-blocking requests
  // parse new details object and return as NSURLRequest
*/
  return nil;
}

-(NSURLRequest *)handleOnBeforeSendHeaders:(NSURLRequest *)request {
  
}

@end

