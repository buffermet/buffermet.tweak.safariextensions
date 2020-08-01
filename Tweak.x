@interface _SFInjectedJavaScriptController : NSObject {
	WKWebView* _webView;
	id<SFInjectedJavaScriptWebProcessController> _activityProxy;
}
-(id)initWithWebView:(id)arg1 ;
-(void)runJavaScriptForActivity:(id)arg1 withScript:(id)arg2 object:(id)arg3 invokeMethod:(id)arg4 completionHandler:(/*^block*/id)arg5 ;
-(id)_webProcessActivityProxy;
@end

%hook _SFInjectedJavaScriptController

-(void)runJavaScriptForActivity:(id)arg1 withScript:(id)arg2 object:(id)arg3 invokeMethod:(id)arg4 completionHandler:(/*^block*/id)arg5 {
  NSLog(@"abla %@ %@ %@ %@ %@", arg1, arg2, arg3, arg4, arg5);
  %orig(arg1, arg2, arg3, arg4, arg5);
}

%end

