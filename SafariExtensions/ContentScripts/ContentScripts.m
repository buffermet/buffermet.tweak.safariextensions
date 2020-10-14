#import "ContentScripts.h"

@implementation ContentScripts

+(void)injectContentScriptsForWebView:(WKWebView *)webView {
  const NSDictionary * manifest = [[NSDictionary alloc]
    initWithContentsOfFile:
      @"/var/mobile/Library/Preferences/SafariExtensions/https-or-bye/manifest.plist"];
  if (manifest) {
//    [manifest setObject: forKey:]
  }
}

@end

