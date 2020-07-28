/*

// 100% compatibility kgo

{
  "applications": {
    "gecko": {
      "id": "buffermet@github.com"
    }
  },
  "contributors": [],
  "manifest_version": 1,
  "name": "XSS-FUZZER",
  "version": "1.0",
  "description": "description.",
  "icons": {
    "48": "assets/img/icon.svg",
    "96": "assets/img/icon.svg"
  },
  "browser_action": {
    "default_icon": {
      "48": "assets/img/icon.svg",
      "96": "assets/img/icon.svg"
    },
    "default_popup": "/assets/html/ui.html",
    "default_title": "XSS-FUZZER"
  },
  "content_security_policy": "script-src 'self' 'wasm-eval'; object-src 'none'",
  "permissions": [
    "<all_urls>",
    "webRequest",
    "webRequestBlocking",
    "contextMenus"
  ],
  "incognito": "spanning",
  "background": {
    "scripts": ["assets/js/hook.js"]
  }
}
*/

@implementation SEManifest

//+(NSDictionary *)parseManifest:(NSString *)rawJSON {
  
//}

@end
