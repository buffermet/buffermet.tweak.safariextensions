#import <WebKit/WebKit.h>
#import "SafariExtensions/URLTools.h"
#import "SafariExtensions/SEContentScripts.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface NSURLRequestInternal : NSObject
-(unsigned long long)hash;
@end

@interface NSURLRequest (SafariExtensions)
-(long)requestID;
@end

NSDictionary * const extensions = @{
  @"0": @{
    @"manifest": @{
      @"manifest_version": @2,
      @"name": @"HTTPS or BYE",
      @"version": @"1.0",
      @"description": @"A strict HTTPS enforcer.",
      @"icons": @{
        @"48": @"assets/img/icon.svg",
        @"96": @"assets/img/icon.svg"
      },
      @"permissions": @[
        @"<all_urls>",
        @"webRequest",
        @"webRequestBlocking",
        @"contextMenus"
      ],
      @"background": @{
        @"scripts": @[
          @"assets/js/hook.js"
        ]
      }
    },
    @"webRequest": @{
      @"onAuthRequired": @{},
      @"onBeforeRequest": @{},
      @"onBeforeSendHeaders": @{},
      @"onHeadersReceived": @{}
    }
  }
};

%group SpringBoard
%hook SpringBoard

-(void)applicationDidFinishLaunching:(id)arg1 {
  %orig;
  NSLog(@"abla --- %@", @"applicationDidFinishLaunching");
  JSContext * jsContext = [%c(JSContext) new];
  [jsContext[@"console"]
    invokeMethod:@"log"
    withArguments:@[@"abla 123456"]];
}

%end
%end

/* NSURLConnection */

%group WKNetworking
%hook NSURLConnection

+(BOOL)canHandleRequest:(id)arg1 {
//NSLog(@"abla --- %@ +[NSURLConnection canHandleRequest:%@]", [self class], arg1);
  return %orig;
}

+(id)pcdeprecated_connectionWithRequest:(id)arg1 delegate:(id)arg2 usesCache:(BOOL)arg3 maxContentLength:(long long)arg4 startImmediately:(BOOL)arg5 connectionProperties:(id)arg6 {
//NSLog(@"abla --- %@ %@%@ %@%@ %@%@ %@%lld %@%@ %@%@", [self class], @"+(id)pcdeprecated_connectionWithRequest:", arg1, @"delegate:", arg2, @"usesCache:", (arg3?@"YES":@"NO"), @"maxContentLength:", arg4, @"startImmediately:", (arg5?@"YES":@"NO"), @"connectionProperties:", arg6);
  return %orig;
}

+(id)sendSynchronousRequest:(id)arg1 returningResponse:(id*)arg2 error:(id*)arg3 {
//NSLog(@"abla --- %@ %@%@ %@ %@", [self class], @"+(id)sendSynchronousRequest:", arg1, @"returningResponse:pointer", @"error:pointer");
  return %orig;
}

+(id)connectionWithRequest:(id)arg1 delegate:(id)arg2 {
//NSLog(@"abla --- %@ %@%@ %@%@", [self class], @"+(id)connectionWithRequest:", arg1, @"delegate:", arg2);
  return %orig;
}

-(void)scheduleInRunLoop:(id)arg1 forMode:(id)arg2 {
//NSLog(@"abla --- %@ %@%@ %@%@", [self class], @"-(void)scheduleInRunLoop:", arg1, @"forMode:", arg2);
  %orig;
}

-(id)_initWithRequest:(id)arg1 delegate:(id)arg2 usesCache:(BOOL)arg3 maxContentLength:(long long)arg4 startImmediately:(BOOL)arg5 connectionProperties:(id)arg6 {
//NSLog(@"abla --- %@ %@%@ %@%@ %@%@ %@%lld %@%@ %@%@", [self class], @"-(id)_initWithRequest:", arg1, @"delegate:", arg2, @"usesCache:", (arg3?@"YES":@"NO"), @"maxContentLength:", arg4, @"startImmediately:", (arg5?@"YES":@"NO"), @"connectionProperties:", arg6);
  return %orig;
}

-(id)initWithRequest:(id)arg1 delegate:(id)arg2 startImmediately:(BOOL)arg3 {
//NSLog(@"abla --- %@ %@%@ %@%@ %@%@", [self class], @"-(id)initWithRequest:", arg1, @"delegate:", arg2, @"startImmediately:", (arg3?@"YES":@"NO"));
  return %orig;
}

-(id)initWithRequest:(id)arg1 delegate:(id)arg2 {
//NSLog(@"abla --- %@ %@%@ %@%@", [self class], @"-(id)initWithRequest:", arg1, @"delegate:", arg2);
  return %orig;
}

%end

/* NSURLSession */

%hook NSURLSession

+(id)sessionWithConfiguration:(id)arg1 delegate:(id)arg2 delegateQueue:(id)arg3 {
//NSLog(@"abla --- %@%@ %@%@ %@%@", @"+(id)sessionWithConfiguration:", arg1, @"delegate:", arg2, @"delegateQueue:", arg3);
  id retval = %orig;
//NSLog(@"abla --- %@ %@", @"retval", retval);
  return retval;
}

+(id)sessionWithConfiguration:(id)arg1 {
//NSLog(@"abla --- %@%@", @"+(id)sessionWithConfiguration:", arg1);
  id retval = %orig;
//NSLog(@"abla --- %@ %@", @"retval", retval);
  return retval;
}

-(id)_downloadTaskWithRequest:(id)arg1 downloadFilePath:(id)arg2 {
//NSLog(@"abla --- %@%@ %@%@", @"-(id)_downloadTaskWithRequest:", arg1, @"downloadFilePath:", arg2);
  id retval = %orig;
//NSLog(@"abla --- %@ %@", @"retval", retval);
  return retval;
}

-(id)dataTaskWithHTTPGetRequest:(id)arg1{
//NSLog(@"abla --- %@%@", @"-(id)dataTaskWithHTTPGetRequest:", arg1);
  id retval = %orig;
//NSLog(@"abla --- %@ %@", @"retval", retval);
  return retval;
}

-(id)dataTaskWithHTTPGetRequest:(id)arg1 completionHandler:(id)arg2{
//NSLog(@"abla --- %@%@ %@%@", @"-(id)dataTaskWithHTTPGetRequest:", arg1, @"completionHandler:", arg2);
  id retval = %orig;
//NSLog(@"abla --- %@ %@", @"retval", retval);
  return retval;
}

// faults
-(id)dataTaskWithRequest:(NSURLRequest *)arg1 {
  NSLog(@"abla --- %llu ", [MSHookIvar<NSURLRequestInternal *>(arg1, "_internal") hash]);
//NSLog(@"abla --- %@%@", @"-(id)dataTaskWithRequest:", arg1);
  id retval = %orig;
//NSLog(@"abla --- %@ %@", @"retval", retval);
  return retval;
}

// faults
-(id)dataTaskWithRequest:(id)arg1 completionHandler:(id)arg2 {
//NSLog(@"abla --- %@%@ %@%@", @"-(id)dataTaskWithRequest:", arg1,  @"completionHandler:", arg2);
  id retval = %orig;
//NSLog(@"abla --- %@ %@", @"retval", retval);
  return retval;
}

-(void)delegate_task:(id)arg1 willBeginDelayedRequest:(id)arg2 completionHandler:(id )arg3{
//NSLog(@"abla --- %@%@ %@%@ %@%@", @"-(void)delegate_task:", arg1, @"willBeginDelayedRequest:", arg2, @"completionHandler:", arg3);
  %orig;
}

-(void)delegate_task:(id)arg1 willPerformHTTPRedirection:(id)arg2 newRequest:(id)arg3 completionHandler:(id )arg4{
//NSLog(@"abla --- %@%@ %@%@ %@%@ %@%@", @"-(void)delegate_task:", arg1, @"willPerformHTTPRedirection:", arg2, @"newRequest:", arg3, @"completionHandler:", arg4);
  %orig;
}

// faults
-(id)downloadTaskWithRequest:(id)arg1{
//NSLog(@"abla --- %@%@", @"-(id)downloadTaskWithRequest:", arg1);
  id retval = %orig;
//NSLog(@"abla --- %@ %@", @"retval", retval);
  return retval;
}

// faults
-(id)downloadTaskWithRequest:(id)arg1 completionHandler:(id)arg2{
//NSLog(@"abla --- %@%@ %@%@", @"-(id)downloadTaskWithRequest:", arg1, @"completionHandler:", arg2);
  id retval = %orig;
//NSLog(@"abla --- %@ %@", @"retval", retval);
  return retval;
}

-(id)downloadTaskWithResumeData:(id)arg1{
//NSLog(@"abla --- %@%@", @"-(id)downloadTaskWithResumeData:", arg1);
  id retval = %orig;
//NSLog(@"abla --- %@ %@", @"retval", retval);
  return retval;
}

-(id)downloadTaskWithResumeData:(id)arg1 completionHandler:(id)arg2{
//NSLog(@"abla --- %@%@ %@%@", @"-(id)downloadTaskWithResumeData:", arg1, @"completionHandler:", arg2);
  id retval = %orig;
//NSLog(@"abla --- %@ %@", @"retval", retval);
  return retval;
}

-(id)downloadTaskWithURL:(id)arg1{
//NSLog(@"abla --- %@%@", @"-(id)downloadTaskWithURL:", arg1);
  id retval = %orig;
//NSLog(@"abla --- %@ %@", @"retval", retval);
  return retval;
}

-(id)downloadTaskWithURL:(id)arg1 completionHandler:(id)arg2{
//NSLog(@"abla --- %@%@ %@%@", @"-(id)downloadTaskWithURL:", arg1, @"completionHandler:", arg2);
  id retval = %orig;
//NSLog(@"abla --- %@ %@", @"retval", retval);
  return retval;
}

// faults
-(id)uploadTaskWithRequest:(id)arg1 fromData:(id)arg2{
//NSLog(@"abla --- %@%@ %@%@", @"-(id)uploadTaskWithRequest:", arg1, @"fromData:", arg2);
  id retval = %orig;
//NSLog(@"abla --- %@ %@", @"retval", retval);
  return retval;
}

// faults
-(id)uploadTaskWithRequest:(id)arg1 fromData:(id)arg2 completionHandler:(id )arg3{
//NSLog(@"abla --- %@%@ %@%@ %@%@", @"-(id)uploadTaskWithRequest:", arg1, @"fromData:", arg2, @"completionHandler:", arg3);
  id retval = %orig;
//NSLog(@"abla --- %@ %@", @"retval", retval);
  return retval;
}

-(id)uploadTaskWithRequest:(id)arg1 fromFile:(id)arg2{
//NSLog(@"abla --- %@%@ %@%@", @"-(id)uploadTaskWithRequest:", arg1, @"fromFile:", arg2);
  id retval = %orig;
//NSLog(@"abla --- %@ %@", @"retval", retval);
  return retval;
}

-(id)uploadTaskWithRequest:(id)arg1 fromFile:(id)arg2 completionHandler:(id )arg3{
//NSLog(@"abla --- %@%@ %@%@ %@%@", @"-(id)uploadTaskWithRequest:", arg1, @"fromFile:", arg2, @"completionHandler:", arg3);
  id retval = %orig;
//NSLog(@"abla --- %@ %@", @"retval", retval);
  return retval;
}

-(id)uploadTaskWithStreamedRequest:(id)arg1{
//NSLog(@"abla --- %@%@", @"-(id)uploadTaskWithStreamedRequest:", arg1);
  id retval = %orig;
//NSLog(@"abla --- %@ %@", @"retval", retval);
  return retval;
}

+(void)_geo_sendasynchronousrequest:(id)arg1 requestcounterticket:(id)arg2 connectionproperties:(id)arg3 completionhandler:(id )arg4{
//NSLog(@"abla --- %@%@ %@%@ %@%@ %@%@", @"+(void)_geo_sendasynchronousrequest:", arg1, @"requestcounterticket:", arg2, @"connectionproperties:", arg3, @"completionhandler:", arg4);
  %orig;
}

+(void)_geo_sendAsynchronousRequest:(id)arg1 requestCounterTicket:(id)arg2 queue:(id)arg3 connectionProperties:(id)arg4 completionHandler:(id )arg5{
//NSLog(@"abla --- %@%@ %@%@ %@%@ %@%@ %@%@", @"+(void)_geo_sendAsynchronousRequest:", arg1, @"requestCounterTicket:", arg2, @"queue:", arg3, @"connectionProperties:", arg4, @"completionHandler:", arg5);
  %orig;
}

+(id)_geo_sendSynchronousRequest:(id)arg1 requestCounterTicket:(id)arg2 connectionProperties:(id)arg3 returningResponse:(id*)arg4 error:(id*)arg5{
//NSLog(@"abla --- %@%@ %@%@ %@%@ %@%@ %@%@", @"+(void)_geo_sendAsynchronousRequest:", arg1, @"requestCounterTicket:", arg2, @"connectionProperties:", arg3, @"returningResponse:", @"(__autoreleasing id *)arg4", @"error:", @"(__autoreleasing id *)arg5");
  id retval = %orig;
//NSLog(@"abla --- %@ %@", @"retval", retval);
  return retval;
}

%end

/* NSURLSessionTask */

%hook NSURLSessionTask

-(void)updateCurrentRequest:(id)arg1 {
//NSLog(@"abla --- %@ %@%@", self, @"-(void)updateCurrentRequest:", arg1);
  %orig;
}

-(id)initWithOriginalRequest:(id)arg1 updatedRequest:(id)arg2 ident:(unsigned long long)arg3 session:(id)arg4 {
//NSLog(@"abla --- %@ %@%@ %@%@ %@%llu %@%@", self, @"-(id)initWithOriginalRequest:", arg1, @"updateRequest:", arg2, @"ident", arg3, @"session:", arg4);
  id retval = %orig;
//NSLog(@"abla --- %@ %@", @"retval", arg1);
  return retval;
}

-(id)initWithTask:(id)arg1 {
//NSLog(@"abla --- %@ %@%@", self, @"-(id)initWithTask:", arg1);
  id retval = %orig;
//NSLog(@"abla --- %@ %@", @"retval", arg1);
  return retval;
}

%end

/* NSURLRequest */

@interface SENSURLRequest : NSURLRequest
@property (nonatomic) long requestID;
@end

%hook NSURLRequest

-(instancetype)init {
  id retval = %orig;
  [retval
    setValue:@420
    forKey:@"requestID"];
  return retval;
}

%end

/* WKWebView */

%hook WKWebView

/*
%new
+(WKWebView *)sharedInstance {
  static WKWebView * webView = nil;
  if (!webView) {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
      webView = [[%c(WKWebView) alloc] init];
    });
  }
  return webView;
}
*/

/*
  Called on a separate thread when the document starts loading,
  this is when content scripts are executed.
*/
-(void)_didCommitLoadForMainFrame {
  NSString * const host = [[self URL] host];
  if (host) {
    /* debug */
    NSString * const payload = [%c(SEContentScripts)
      assembleContentScriptsForHost:host];
    if (payload) {
      [self
        evaluateJavaScript:payload
        completionHandler:nil];
    }
  }
  %orig;
}

/*
-(id)load:(NSURLRequest *)arg1 {
//NSLog(@"abla --- %@%@", @"load:", arg1);
  id retval = %orig;
  return retval;
}

-(id)loadRequest:(NSURLRequest *)arg1 {
//NSLog(@"abla --- %@%@", @"loadRequest:", arg1);
  id retval = %orig;
  return retval;
}

-(id)loadHTMLString:(id)arg1 baseURL:(id)arg2 {
//NSLog(@"abla --- %@%@ %@%@", @"loadHTMLString:", arg1, @"baseURL:", arg2);
  id retval = %orig;
  return retval;
}

-(id)loadFileURL:(id)arg1 allowingReadAccessToURL:(id)arg2 {
//NSLog(@"abla --- %@%@ %@%@", @"loadFileURL:", arg1, @"allowingReadAccessToURL:", arg2);
  id retval = %orig;
  return retval;
}

-(id)loadData:(id)arg1 MIMEType:(id)arg2 characterEncodingName:(id)arg3 baseURL:(id)arg4 {
//NSLog(@"abla --- %@%@ %@%@ %@%@ %@%@", @"loadData:", arg1, @"MIMEType:", arg2, @"characterEncodingName:", arg3, @"baseURL:", arg4);
  id retval = %orig;
  return retval;
}

-(void)_loadAlternateHTMLString:(id)arg1 baseURL:(id)arg2 forUnreachableURL:(id)arg3 {
//NSLog(@"abla --- %@%@ %@%@ %@%@", @"_loadAlternateHTMLString:", arg1, @"baseURL:", arg2, @"forUnreachableURL:", arg3);
  %orig;
}

-(id)_loadData:(id)arg1 MIMEType:(id)arg2 characterEncodingName:(id)arg3 baseURL:(id)arg4 userData:(id)arg5 {
//NSLog(@"abla --- %@%@ %@%@ %@%@ %@%@ %@%@", @"_loadData:", arg1, @"MIMEType:", arg2, @"characterEncodingName:", arg3, @"baseURL:", arg4, @"userData:", arg5);
  id retval = %orig;
  return retval;
}

-(id)_loadRequest:(id)arg1 shouldOpenExternalURLs:(BOOL)arg2 {
//NSLog(@"abla --- %@%@ %@%@", @"_loadRequest:", arg1, @"shouldOpenExternalURLs", (arg2 ? @"YES" : @"NO"));
  id retval = %orig;
  return retval;
}

-(id)reload {
//NSLog(@"abla --- %@", @"reload");
  id retval = %orig;
  return retval; 
}

-(id)reloadFromOrigin {
//NSLog(@"abla --- %@", @"reloadFromOrigin");
  id retval = %orig;
  return retval; 
}

-(id)_reloadWithoutContentBlockers {
//NSLog(@"abla --- %@", @"_reloadWithoutContentBlockers");
  id retval = %orig;
  return retval;
}

-(id)_reloadExpiredOnly {
//NSLog(@"abla --- %@", @"_reloadExpiredOnly");
  id retval = %orig;
  return retval;
}

-(id)targetForAction:(SEL)arg1 withSender:(id)arg2 {
//NSLog(@"abla --- %@%@ %@%@", @"targetForAction:", @"<SEL>", @"withSender:", arg2);
  id retval = %orig;
  return retval;
}
*/

%end
%end

%ctor {
/*
Instances:
ctor {
  SEWR: SEWebRequest,
  : SEWebRequest,
}
*/
  %init;
  NSString * bundleID = [[NSBundle mainBundle] bundleIdentifier];
//  NSLog(@"abla --- bundleID=%@", bundleID);
  if ([bundleID isEqualToString:@"com.apple.springboard"]) {
    %init(SpringBoard);
  }
  if (
       [bundleID isEqualToString:@"com.apple.WebKit.Networking"]
    || [bundleID isEqualToString:@"com.apple.mobilesafari"]
  ) {
    %init(WKNetworking);
  }
}

