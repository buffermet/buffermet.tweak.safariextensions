#import "URLTools.h"

@interface WKWebView : NSObject
-(NSURL *)URL;
-(void)evaluateJavaScript:(id)arg1 completionHandler:(id)arg2 ;
@end

NSString * assemblePayloadForHost(NSString * const host) {
  /* debug */
  const NSDictionary * const safariExtensions = @{
    @"*.google.com.au": @"alert()",
  };

  NSString * payload;
  for (NSString * domainSpecifier in [safariExtensions allKeys]) {
    if ([domainSpecifier isEqual:@"*"]) {
      payload = [NSString
        stringWithFormat:
          @"%@%@%@",
          payload, @"\n", safariExtensions[domainSpecifier]];
    } else {
      NSRegularExpression * regexp = [%c(URLTools)
        domainSpecifierToRegexpIgnoreCase:domainSpecifier];
      NSString * matchString = [regexp
        stringByReplacingMatchesInString:host
        options:0
        range:NSMakeRange(0, [host length])
        withTemplate:@"1"]; /* lazy */
      if ([matchString isEqual:@"1"]) {
        payload = [NSString
          stringWithFormat:
            @"%@%@%@",
            payload, @"\n", safariExtensions[domainSpecifier]];
      }
    }
  }
  return payload;
}

%hook WKWebView

// called when document parsing starts
-(void)_didCommitLoadForMainFrame {
  NSString * const host = [[self URL] host];
  if (host) {
    const NSString * const payload = assemblePayloadForHost(host);
    if (payload) {
      [self
        evaluateJavaScript:payload
        completionHandler:nil];
    }
    %orig;
  }
}

/*
// obviously called when page finished loading (i.e. self.onload)
-(void)_didFinishLoadForMainFrame {
  NSLog(@"abla %@", @"-(void)_didFinishLoadForMainFrame {");
  %orig;
}

// called when new search/URL is requested
-(id)loadRequest:(id)arg1 {
  NSLog(@"abla %@", @"-(id)loadRequest:(id)arg1 {");
  return %orig;
}

// called when page starts reloading
-(id)reload {
  NSLog(@"abla %@", @"-(id)reload {");
  return %orig;
}

// ?
-(id)initWithFrame:(CGRect)arg1 {
  NSLog(@"abla %@", @"-(id)initWithFrame:(CGRect)arg1 {");
  return %orig;
}

// called on page load cycles
-(id)initWithFrame:(CGRect)arg1 configuration:(id)arg2 {
  NSLog(@"abla %@", @"-(id)initWithFrame:(CGRect)arg1 configuration:(id)arg2 {");
  return %orig;
}

// called at pretty much every event
-(void)setFrame:(CGRect)arg1 {
  NSLog(@"abla %@", @"-(void)setFrame:(CGRect)arg1 {");
  %orig;
}
*/

%end
