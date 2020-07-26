@interface WKWebView : NSObject
-(NSURL *)URL;
-(void)evaluateJavaScript:(id)arg1 completionHandler:(id)arg2 ;
@end

/*
NSURL * upgradeScheme(NSURL * URL) {
  NSString * const insecureURL = [NSString
    stringWithFormat:@"%@", [URL absoluteURL]];
  NSError * err = nil;
  NSRegularExpression * regex = [NSRegularExpression
    regularExpressionWithPattern:@"^\\s*http:"
    options:NSRegularExpressionCaseInsensitive
    error:&err];
  NSString * secureURL = [regex
    stringByReplacingMatchesInString:insecureURL
    options:0
    range:NSMakeRange(0, [insecureURL length]);
    withTemplate:@"https:"];
  return [NSURL URLWithString:secureURL];
}
*/

NSRegularExpression * domainSpecifierToRegexpIgnoreCase(NSString * domainSpecifier) {
  NSRegularExpression *  regex = [NSRegularExpression
    regularExpressionWithPattern:@"[-]"
    options:NSRegularExpressionCaseInsensitive
    error:nil];
  domainSpecifier = [regex
    stringByReplacingMatchesInString:domainSpecifier
    options:0
    range:NSMakeRange(0, [domainSpecifier length])
    withTemplate:@"\\-"];
  regex = [NSRegularExpression
    regularExpressionWithPattern:@"^[*][.]"
    options:NSRegularExpressionCaseInsensitive
    error:nil];
  domainSpecifier = [regex
    stringByReplacingMatchesInString:domainSpecifier
    options:0
    range:NSMakeRange(0, [domainSpecifier length])
    withTemplate:@"((?:[a-z0-9](?:[a-z0-9-]{0,61}[a-z0-9])?.)+)"];
  regex = [NSRegularExpression
    regularExpressionWithPattern:@"[.]"
    options:NSRegularExpressionCaseInsensitive
    error:nil];
  domainSpecifier = [regex
    stringByReplacingMatchesInString:domainSpecifier
    options:0
    range:NSMakeRange(0, [domainSpecifier length])
    withTemplate:@"\\."]; 
  return [NSRegularExpression
    regularExpressionWithPattern:domainSpecifier
    options:NSRegularExpressionCaseInsensitive
    error:nil];
}

NSString * assembleScriptForHost(NSString * host) {
  NSString * script;
  /* debug */

  const NSDictionary * const safariExtensions = @{
    // debug result: JS is executed before readyState is set to "loading" (i.e. inline script tag at top of document)
    @"*.google.com.au": @"document.onreadystatechange=function(){alert(document.readyState)};self.stop()",
    @"*": @"const darkModeCSS = `html, body, html div, html section, html span, html table { background-color: #000 !important; color: #fff !important; } a { color: rgb(0,142,255) !important; }`; const stylesheet = document.createElement(\"style\"); stylesheet.type = \"text/css\"; stylesheet.innerText = darkModeCSS; document.body.append(stylesheet);",
  };
  for (NSString * domainSpecifier in [safariExtensions allKeys]) {
    if ([domainSpecifier isEqual:@"*"]) {
      script = [NSString
        stringWithFormat:
          @"%@%@%@",
          script, @"\n", safariExtensions[domainSpecifier]];
    } else {
      NSRegularExpression * regex = domainSpecifierToRegexpIgnoreCase(domainSpecifier);
      NSString * matchString = [regex
        stringByReplacingMatchesInString:host
        options:0
        range:NSMakeRange(0, [host length])
        withTemplate:@"1"]; /* lazy */
      if ([matchString isEqual:@"1"]) {
        script = [NSString
        stringWithFormat:
          @"%@%@%@",
          script, @"\n", safariExtensions[domainSpecifier]];
      }
    }
  }
  return script;
}

%hook WKWebView

-(void)_didCommitLoadForMainFrame {
  [self
    evaluateJavaScript:assembleScriptForHost([[self URL] host])
    completionHandler:nil];
  %orig;
}

/*
// obviously called when page finished loading (i.e. self.onload)
-(void)_didFinishLoadForMainFrame {
  NSLog(@"abla %@", @"-(void)_didFinishLoadForMainFrame {");
  %orig;
}
*/

/*
// called when new search/URL is requested
-(id)loadRequest:(id)arg1 {
  NSLog(@"abla %@", @"-(id)loadRequest:(id)arg1 {");
  NSLog(@"abla %@", [[self URL] absoluteURL]);
  NSLog(@"abla %@", arg1);
//  self.URL = upgradeScheme([self URL]);
  return %orig;
}

// called when page is reloaded
-(id)reload {
  NSLog(@"abla %@", @"-(id)reload {");
  NSLog(@"abla %@", [[self URL] absoluteURL]);
//  self.URL = upgradeScheme([self URL]);
  return %orig;
}
*/

/*
// ?
-(id)initWithFrame:(CGRect)arg1 {
  NSLog(@"abla %@", @"-(id)initWithFrame:(CGRect)arg1 {");
  return %orig;
}

// called on page load cycles
-(id)initWithFrame:(CGRect)arg1 configuration:(id)arg2 {
  NSLog(@"abla %@", @"-(id)initWithFrame:(CGRect)arg1 configuration:(id)arg2 {");
  NSLog(@"abla %@", arg2);
  return %orig;
}
*/

/*
// called at pretty much every event
-(void)setFrame:(CGRect)arg1 {
  NSLog(@"abla %@", @"-(void)setFrame:(CGRect)arg1 {");
  NSLog(@"abla %@", self);
  %orig;
}
*/

%end
