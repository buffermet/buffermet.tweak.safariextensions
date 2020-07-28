#import "URLTools.h"

@interface WKWebView : NSObject
-(NSURL *)URL;
-(void)evaluateJavaScript:(id)arg1 completionHandler:(id)arg2;
@end

void testing() {
  NSLog(@"abla %@", @"123");
}

NSString * assemblePayloadForHost(NSString * const host) {
  /* debug */
  const NSDictionary * const safariExtensions = @{
    @"*": @"if (self.location.protocol == 'http:') { self.stop(); }",
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

-(void)_didCommitLoadForMainFrame {
  NSString * const host = [[self URL] host];
  if (host) {
    const NSString * const payload = assemblePayloadForHost(host);
    if (payload) {
      [self
        evaluateJavaScript:payload
        completionHandler:testing];
    }
  }
  %orig;
}

%end

