#import "ContentScripts.h"
#import "WebKit/WebKit.h"

@implementation ContentScripts

+(void)injectContentScriptsForWebView:(WKWebView *)webView {
}

@end

%hook WKWebView

//all_frames
//css
//exclude_globs
//exclude_matches
//include_globs
//js
//match_about_blank
//matches
//run_at
-(void)_didCommitLoadForMainFrame {
  %orig;
  NSString * const host = [[self URL] host];
  if (host) {
    const NSDictionary * manifest = [[NSDictionary alloc]
      initWithContentsOfFile:
        @"/var/mobile/Library/Preferences/SafariExtensions/HTTPS or BYE/manifest.plist"];
    if (manifest) {
      NSArray * contentScripts = manifest[@"content_scripts"];
      if (contentScripts) {
        for (NSDictionary * contentScript in contentScripts) {
          BOOL isMatchingURISpecifier = NO;
          NSArray * matches = contentScript[@"matches"];
          if (matches) {
            
          } else {
            // throw error: missing 'matches' property
          }
        }
      }
    }
    
//    /* debug */
//    NSString * const payload = [%c(SEContentScripts)
//      assembleContentScriptsForHost:host];
//    if (payload) {
//      [self
//        evaluateJavaScript:payload
//        completionHandler:nil];
//    }
  }
}

%end

