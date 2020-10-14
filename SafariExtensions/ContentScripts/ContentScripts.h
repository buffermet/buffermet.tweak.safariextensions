#import <WebKit/WebKit.h>

@interface ContentScripts : NSObject
+(void)injectContentScriptsForWebView:(WKWebView *)webView;
@end
