// https://chromium.googlesource.com/chromium/src/+/master/extensions/common/api/web_request.json
// https://searchfox.org/mozilla-central/rev/3345af4b5/toolkit/modules/addons/WebRequestUpload.jsm#258-269

#import "SEWebRequest.h"
#import "URLTools.h"
//#import "SEJSContext.h"
#import <JavaScriptCore/JavaScriptCore.h>

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

NSString * stripTrailingWhitespace(NSString * str) {
  const NSRegularExpression * const regexTrailingWhitespace = [NSRegularExpression
    regularExpressionWithPattern:@"^\\s*(.*)\\s*$"
    options:NSRegularExpressionCaseInsensitive
    error:nil];
  return [regexTrailingWhitespace
    stringByReplacingMatchesInString:str
    options:0
    range:NSMakeRange(0, [str length])
    withTemplate:@"$1"];
}

NSString * stripTrailingDoubleQuotes(NSString * str) {
  const NSRegularExpression * const regexTrailingWhitespace = [NSRegularExpression
    regularExpressionWithPattern:@"^[\"]*(.*)[\"]*$"
    options:NSRegularExpressionCaseInsensitive
    error:nil];
  return [regexTrailingWhitespace
    stringByReplacingMatchesInString:str
    options:0
    range:NSMakeRange(0, [str length])
    withTemplate:@"$1"];
}

NSArray * getHeaderParts(NSString * headerValue) {
  NSMutableArray * arr = [NSMutableArray array];
  NSArray * matches = [headerValue
    componentsSeparatedByString:@";"];
  for (NSString * match in matches) {
    [arr addObject:stripTrailingWhitespace(match)];
  }
  return arr;
}

NSDictionary * getHeaders(NSString * rawHeaders) {
  NSMutableDictionary * dict = [NSMutableDictionary new];
  for (NSString * headerString in [rawHeaders
    componentsSeparatedByString:@"\r\n"]
  ) {
    NSRegularExpression * regexp = [NSRegularExpression
      regularExpressionWithPattern:@"^\\s*(.*?)\\s*:\\s*(.*)\\s*$"
      options:NSRegularExpressionCaseInsensitive
      error:nil];
    const NSString * const name = [[regexp
      stringByReplacingMatchesInString:headerString
      options:0
      range:NSMakeRange(0, [headerString length])
      withTemplate:@"$1"]
        lowercaseString];
    const NSString * const value = [regexp
      stringByReplacingMatchesInString:headerString
      options:0
      range:NSMakeRange(0, [headerString length])
      withTemplate:@"$2"];
    if (![name isEqual:@""]) {
      if (dict[name]) {
        [dict[name] addObject:value];
      } else {
        dict[name] = @[value];
      }
    }
  }
  return dict;
}

NSArray * getBufferedStreamChunks(NSInputStream * inputStream, int size) {
  const int BUFFER_LENGTH = 8192;
  uint8_t buffer[size];
  NSMutableArray * arr = [NSMutableArray array];
  NSUInteger result;
  while ((result = [inputStream
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

NSArray * getBufferedStreamChunksAndSplit(NSInputStream * inputStream, int size, NSString * boundary) {
  const int BUFFER_LENGTH = 8192;
  uint8_t buffer[size];
  NSMutableArray * arr = [NSMutableArray array];
  NSUInteger result;
  while ((result = [inputStream
    read:buffer
    maxLength:BUFFER_LENGTH])
  ) {
    if (result > 0) {
      for (NSString * part in [[NSString
        stringWithFormat:@"%s", buffer]
          componentsSeparatedByString:boundary])
      {
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
  NSArray * contentTypeParameterString = getHeaderParts(contentTypeLowercase);
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
      NSDictionary * const thisFormDataPartHeaders = getHeaders(rawHeaders);
      NSString * const contentDispositionString = thisFormDataPartHeaders[@"content-disposition"];
      if (
           !contentDispositionString
        || ![getHeaderParts(contentDispositionString) containsObject:@"form-data"]
      ) {
        // throw error: invalid MIME stream: No valid Content-Disposition header
        continue;
      }
      NSArray * const headerParts = getHeaderParts(contentDispositionString);
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
    // new Array().concat({bytes: new ArrayBuffer(payload)});
    // {raw: ArrayBuffer(...)}
    // Uint8Array.from([0,0,0]).buffer
    JSValue * detailsRequestBodyRawArray = [%c(JSValue)
      valueWithNewObjectInContext:jsContext];
    NSArray * bufferedChunks = getBufferedStreamChunks(
      [request HTTPBodyStream],
      [[request HTTPBody] length]);
    for (NSString * thisChunk in bufferedChunks) {
      JSValue * const detailsRequestBodyRawUint8Array = [jsContext[@"Uint8Array"]
        invokeMethod:@"from"
        withArguments:Uint8ArrayFromData([thisChunk
          dataUsingEncoding:NSUTF8StringEncoding])];
      JSValue * const detailsRequestBodyArrayBuffer = [detailsRequestBodyRawUint8Array
        valueForProperty:@"buffer"];
      [detailsRequestBodyRawArray
        invokeMethod:@"push"
        withArguments:@[detailsRequestBodyArrayBuffer]];
    }
    detailsRequestBodyRaw = detailsRequestBodyRawArray;
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
  return nil;
}

@end

