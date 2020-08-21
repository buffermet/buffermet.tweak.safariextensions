#import "SEContentScripts.h"
#import "URLTools.h"

@implementation SEContentScripts

+(NSString *)assembleContentScriptsForHost:(NSString *)host {
  /* debug */
  const NSDictionary * const safariExtensions = @{
    @"<all_urls>": @"function darken() { const darkCss = `html,img,svg,video{filter: invert(1);}`; const styleNode = document.createElement('style'); styleNode.type = 'text/css'; styleNode.innerText = darkCss; document.body.append(styleNode); }; if (document.readyState !== 'loading') { darken(); } else { document.addEventListener('DOMContentLoaded', darken); };",
  };

  NSString * payload;
  for (NSString * domainSpecifier in [safariExtensions allKeys]) {
    if ([domainSpecifier isEqual:@"<all_urls>"]) {
      payload = [NSString
        stringWithFormat:
          @"%@%@%@",
          payload, @"\n", safariExtensions[domainSpecifier]];
    } else {
      NSRegularExpression * regexp = [URLTools
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

@end

