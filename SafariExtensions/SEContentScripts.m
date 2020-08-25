#import "SEContentScripts.h"
#import "URLTools.h"

@implementation SEContentScripts

+(NSString *)assembleContentScriptsForHost:(NSString *)host {
  /* debug */
  const NSDictionary * const safariExtensions = @{
    @"<all_urls>": @"function darken() { const darkCss = `html,img,svg,video,object{filter: invert(1);}html,html body{background-color: white !important;}`; const styleNode = document.createElement('style'); styleNode.type = 'text/css'; styleNode.innerText = darkCss; document.body.append(styleNode);for (let i = 0; i < document.all.length; i++) { const el = document.all[i]; switch (el.tagName) { case \"HTML\": break; case \"IMG\": break; case \"SVG\": break; case \"VIDEO\": break; case \"OBJECT\":break;default:const bgStr = new String(self.getComputedStyle(el)[\"background\"] + self.getComputedStyle(el)[\"background-image\"]);if (bgStr.match(/url[(]/i)) {el.style.filter = \"invert(1)\";}}}  }; if (document.readyState !== 'loading') { darken(); } else { document.addEventListener('DOMContentLoaded', darken); };",
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

