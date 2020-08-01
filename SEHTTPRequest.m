// consider renaming this to SEWebRequest.m

/*
cookieStoreId
string. If the request is from a tab open in a contextual identity, the cookie store ID of the contextual identity.

documentUrl
string. URL of the document in which the resource will be loaded. For example, if the web page at "https://example.com" contains an image or an iframe, then the documentUrl for the image or iframe will be "https://example.com". For a top-level document, documentUrl is undefined.

frameAncestors
array. Contains information for each document in the frame hierarchy up to the top-level document. The first element in the array contains information about the immediate parent of the document being requested, and the last element contains information about the top-level document. If the load is actually for the top-level document, then this array is empty.

  url
  string. The URL that the document was loaded from.

  frameId
  integer. The frameId of the document. details.frameAncestors[0].frameId is the same as details.parentFrameId.

frameId
integer. Zero if the request happens in the main frame; a positive value is the ID of a subframe in which the request happens. If the document of a (sub-)frame is loaded (type is main_frame or sub_frame), frameId indicates the ID of this frame, not the ID of the outer frame. Frame IDs are unique within a tab.

incognito
boolean. Whether the request is from a private browsing window.

method
string. Standard HTTP method: for example, "GET" or "POST".

originUrl
string. URL of the resource which triggered the request. For example, if "https://example.com" contains a link, and the user clicks the link, then the originUrl for the resulting request is "https://example.com".

The originUrl is often but not always the same as the documentUrl. For example, if a page contains an iframe, and the iframe contains a link that loads a new document into the iframe, then the documentUrl for the resulting request will be the iframe's parent document, but the originUrl will be the URL of the document in the iframe that contained the link.

parentFrameId
integer. ID of the frame that contains the frame which sent the request. Set to -1 if no parent frame exists.

proxyInfo
object. This property is present only if the request is being proxied. It contains the following properties:

host
string. The hostname of the proxy server.

port
integer. The port number of the proxy server.

type
string. The type of proxy server. One of:

"http": HTTP proxy (or SSL CONNECT for HTTPS)
"https": HTTP proxying over TLS connection to proxy
"socks": SOCKS v5 proxy
"socks4": SOCKS v4 proxy
"direct": no proxy
"unknown": unknown proxy

username
string. Username for the proxy service.

proxyDNS
boolean. True if the proxy will perform domain name resolution based on the hostname supplied, meaning that the client should not do its own DNS lookup.

Timeout
integer. Failover timeout in seconds. If the proxy connection fails, the proxy will not be used again for this period.

requestBody
object. Contains the HTTP request body data. Only provided if extraInfoSpec contains "requestBody".

  error
  string. This is set if any errors were encountered when obtaining request body data.

  formData
  object. This object is present if the request method is POST and the body is a sequence of key-value pairs encoded in UTF-8 as either "multipart/form-data" or "application/x-www-form-urlencoded".
  It is a dictionary in which each key contains the list of all values for that key. For example: {'key': ['value1', 'value2']}. If the data is of another media type, or if it is malformed, the object is not present.

  raw
  array of webRequest.UploadData. If the request method is PUT or POST, and the body is not already parsed in formData, then this array contains the unparsed request body elements.

requestId
string. The ID of the request. Request IDs are unique within a browser session, so you can use them to relate different events associated with the same request.

tabId
integer. ID of the tab in which the request takes place. Set to -1 if the request isn't related to a tab.

thirdParty
boolean. Indicates whether the request and its content window hierarchy are third party.

timeStamp
number. The time when this event fired, in milliseconds since the epoch.

type
webRequest.ResourceType. The type of resource being requested: for example, "image", "script", "stylesheet".

url
string. Target of the request.

urlClassification
object. The type of tracking associated with the request, if with the request has been classified by Firefox Tracking Protection. This is an object with the following properties:

  firstParty
  array of strings. Classification flags for the request's first party.

  thirdParty
  array of strings. Classification flags for the request or its window hierarchy's third parties.

  The classification flags include:
  fingerprinting and fingerprinting_content: indicates the request is involved in fingerprinting. fingerprinting_content indicates the request is loaded from an origin that has been found to fingerprint but is not considered to participate in tracking, such as a payment provider.
  cryptomining and cryptomining_content: similar to the fingerprinting category but for cryptomining resources.
  tracking, tracking_ad, tracking_analytics, tracking_social,  and tracking_content: indicates the request is involved in tracking. tracking is any generic tracking request, the ad, analytics, social, and content suffixes identify the type of tracker.
  any_basic_tracking: a meta flag that combines any tracking and fingerprinting flags, excluding tracking_content and fingerprinting_content.
  any_strict_tracking: a meta flag that combines any tracking and fingerprinting flags, including tracking_content and fingerprinting_content.
  any_social_tracking: a meta flag that combines any social tracking flags.
---

#import <CFNetwork/CFNetwork-Structs.h>
#import <CFNetwork/NSSecureCoding.h>
#import <CFNetwork/NSCopying.h>
#import <CFNetwork/NSMutableCopying.h>

@class NSURLRequestInternal, NSString, NSDictionary, NSData, NSInputStream, NSURL;

@interface NSURLRequest : NSObject <NSSecureCoding, NSCopying, NSMutableCopying> {
	NSURLRequestInternal* _internal;
}
@property (copy,readonly) NSString* HTTPMethod; 
@property (copy,readonly) NSDictionary* allHTTPHeaderFields; 
@property (copy,readonly) NSData* HTTPBody; 
@property (retain,readonly) NSInputStream* HTTPBodyStream; 
@property (readonly) bool HTTPShouldHandleCookies; 
@property (readonly) bool HTTPShouldUsePipelining; 
@property (copy,readonly) NSURL* URL; 
@property (readonly) unsignedlonglong cachePolicy; 
@property (readonly) double timeoutInterval; 
@property (copy,readonly) NSURL* mainDocumentURL; 
@property (readonly) unsignedlonglong networkServiceType; 
@property (readonly) bool allowsCellularAccess; 
+(id)getObjectKeyWithIndex:(long long)arg1 ;
+(bool)allowsAnyHTTPSCertificateForHost:(id)arg1 ;
+(void)setDefaultTimeoutInterval:(double)arg1 ;
+(double)defaultTimeoutInterval;
+(void)setAllowsAnyHTTPSCertificate:(bool)arg1 forHost:(id)arg2 ;
+(bool)supportsSecureCoding;
+(id)requestWithURL:(id)arg1 cachePolicy:(unsigned long long)arg2 timeoutInterval:(double)arg3 ;
+(id)requestWithURL:(id)arg1 ;
+(id)allowsSpecificHTTPSCertificateForHost:(id)arg1 ;
+(void)setAllowsSpecificHTTPSCertificate:(id)arg1 forHost:(id)arg2 ;
-(id)_startTimeoutDate;
-(double)_payloadTransmissionTimeout;
-(id)mainDocumentURL;
-(bool)_URLHasScheme:(id)arg1 ;
-(bool)_isSafeRequestForBackgroundDownload;
-(void)_removePropertyForKey:(id)arg1 ;
-(double)_timeWindowDelay;
-(double)_timeWindowDuration;
-(bool)_requiresShortConnectionTimeout;
-(id)_copyReplacingURLWithURL:(id)arg1 ;
-(id)boundInterfaceIdentifier;
-(id)HTTPContentType;
-(id)HTTPExtraCookies;
-(id)HTTPReferrer;
-(id)HTTPUserAgent;
-(bool)HTTPShouldUsePipelining;
-(id)contentDispositionEncodingFallbackArray;
-(unsigned long long)expectedWorkload;
-(unsigned long long)networkServiceType;
-(id)initWithURL:(id)arg1 cachePolicy:(unsigned long long)arg2 timeoutInterval:(double)arg3 ;
-(unsigned long long)cachePolicy;
-(double)timeoutInterval;
-(bool)HTTPShouldHandleCookies;
-(bool)allowsCellularAccess;
-(id)HTTPMethod;
-(id)HTTPBody;
-(id)allHTTPHeaderFields;
-(id)init;
-(id)initWithCoder:(id)arg1 ;
-(void)encodeWithCoder:(id)arg1 ;
-(void)dealloc;
-(bool)isEqual:(id)arg1 ;
-(unsigned long long)hash;
-(id)description;
-(id)initWithURL:(id)arg1 ;
-(id)copyWithZone:(NSZoneRef)arg1 ;
-(id)URL;
-(id)mutableCopyWithZone:(NSZoneRef)arg1 ;
-(id)valueForHTTPHeaderField:(id)arg1 ;
-(CFURLRequestRef)_CFURLRequest;
-(id)_initWithCFURLRequest:(CFURLRequestRef)arg1 ;
-(id)_propertyForKey:(id)arg1 ;
-(id)HTTPBodyStream;
-(void)_setProperty:(id)arg1 forKey:(id)arg2 ;
@end
*/



/*
// example hook
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
sampleListener = {
  "listener": "function(details){details.url='https://www.example.com/';}",
  "filter": {},
  "extraInfoSpec": []
}
*/

/*
// example storage of listeners
// note: 'sampleListener' is listener.name
listeners = {
  "HTTPS or BYE": {
    "sampleListener": {
      "listener": "",
      "filter": {},
      "extraInfoSpec": []
    }
  }
}
*/

const NSString * const rawRequestDetailsObject = @"{
  \"cookieStoreId\": null,
  \"documentURL\": null,
  \"frameAncestors\": null,
  \"url\": null,
  \"frameId\": null,
  \"incognito\": null,
  \"method\": null,
  \"originUrl\": null,
  \"parentFrameId\": null,
  \"proxyInfo\": {
    \"host\": null,
    \"port\": null,
    \"type\": null,
    \"username\": null,
    \"proxyDNS\": null,
    \"failoverTimeout\": null
  },
  \"requestBody\": {
    \"error\": null,
    \"formData\": null,
    \"raw\": null
  },
  \"requestId\": null,
  \"tabId\": null,
  \"thirdParty\": null,
  \"timeStamp\": null,
  \"type\": null,
  \"url\": null,
  \"lassification\": {
    \"firstParty\": null,
    \"thirdParty\": null
  }
}";

/* debug */
NSDictionary * listeners = @{
  @"HTTPS or BYE": {
    @"webRequest": {
      @"onAuthRequired": @{
        @"listeners": @[]
      }
      @"onBeforeRequest": {
        @"listeners": @[]
      },
      @"onBeforeSendHeaders": {
        @"listeners": @[]
      },
      @"onHeadersReceived": {
        @"listeners": @[]
      },
    }
  }
};

@interface SEHTTPRequest
+(id)newListenerDetailsObject;
+(id)NSURLRequestToJSON:(NSURLRequest *)request;
+(NSURLRequest *)handleNSURLRequest:(NSURLRequest *)request;
@end

@implementation SEHTTPRequest

+(void)addListener:(id)listenerObj {
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

+(id)newListenerDetailsObject {
  NSData * data = [rawRequestDetailsObject
    dataUsingEncoding:NSUTF8StringEncoding];
  return [NSJSONSerialization
    JSONObjectWithData:data
    options:0
    error:nil];
}

+(id)NSURLRequestToJSON:(NSURLRequest *)request {
   NSData * data = [rawRequestDetailsObject
    dataUsingEncoding:NSUTF8StringEncoding];
  id details = [NSJSONSerialization
    JSONObjectWithData:data
    options:0
    error:nil];
  NSURL * URL = [request URL];
  if (URL) {
    [details
      setObject:[URL absoluteURL]
      forKey:@"url"];
  }
  if ([request HTTPMethod]) {
    [details
      setObject:[request HTTPMethod]
      forKey:@"method"];
  }
/*
  // this is a special case, needs to be a header
  if ([request HTTPUserAgent]) {
    [details
      setObject:[request HTTPUserAgent]
      forKey:@"method"];
  }
*/
  return details;
}

+(NSURLRequest *)handleNSURLRequest:(NSURLRequest *)request {
  /* debug */
  for (NSDictionary * listener in listeners) {
    
  }
  // generate request details object using original NSURLRequest
  // run details object through all listeners
  //   async for non-blocking requests
  // parse new details object and return as NSURLRequest
  return nil;
}

@end

