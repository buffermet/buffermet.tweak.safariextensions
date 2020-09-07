#import "Manifest.h"

/*
// example of a manifest.json
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

@implementation Manifest

+(NSDictionary *)parseManifest:(NSString *)encodedJSON {
  NSMutableDictionary * const dict = [NSMutableDictionary new];
  NSData * jsonData = [encodedJSON
    dataUsingEncoding:NSUTF8StringEncoding];
  NSDictionary * decodedJSON = [NSJSONSerialization
    JSONObjectWithData:jsonData
    options:0
    error:nil];

 if (decodedJSON[@"author"]) {
    
 }
 if (decodedJSON[@"background"]) {
    
 }
 if (decodedJSON[@"browser_action"]) {}
 if (decodedJSON[@"browser_specific_settings"]) {}
 if (decodedJSON[@"chrome_settings_overrides"]) {}
 if (decodedJSON[@"chrome_url_overrides"]) {}
 if (decodedJSON[@"commands"]) {}
 if (decodedJSON[@"content_scripts"]) {}
 if (decodedJSON[@"content_security_policy"]) {}
 if (decodedJSON[@"default_locale"]) {}
 if (decodedJSON[@"description"]) {}
 if (decodedJSON[@"developer"]) {}
 if (decodedJSON[@"devtools_page"]) {}
 if (decodedJSON[@"dictionaries"]) {}
 if (decodedJSON[@"externally_connectable"]) {}
 if (decodedJSON[@"homepage_url"]) {}
 if (decodedJSON[@"icons"]) {}
 if (decodedJSON[@"incognito"]) {}
 if (decodedJSON[@"manifest_version"]) {}
 if (decodedJSON[@"name"]) {}
 if (decodedJSON[@"offline_enabled"]) {}
 if (decodedJSON[@"omnibox"]) {}
 if (decodedJSON[@"optional_permissions"]) {}
 if (decodedJSON[@"options_page"]) {}
 if (decodedJSON[@"options_ui"]) {}
 if (decodedJSON[@"page_action"]) {}
 if (decodedJSON[@"permissions"]) {}
 if (decodedJSON[@"protocol_handlers"]) {}
 if (decodedJSON[@"short_name"]) {}
 if (decodedJSON[@"sidebar_action"]) {}
 if (decodedJSON[@"storage"]) {}
 if (decodedJSON[@"theme"]) {}
 if (decodedJSON[@"theme_experiment"]) {}
 if (decodedJSON[@"user_scripts"]) {}
 if (decodedJSON[@"version"]) {}
 if (decodedJSON[@"version_name"]) {}
 if (decodedJSON[@"web_accessible_resources"]) {}

//{
//  "applications": {
  if (decodedJSON[@"applications"]) {
    
  }
//    "gecko": {
  if (decodedJSON[@"gecko"]) {
    
  }
//      "id": "buffermet@github.com"
//    }
//  },
//  "contributors": [],
  if (decodedJSON[@"contributors"]) {
    
  }
//  "manifest_version": 1,
  if (decodedJSON[@"manifest_version"]) {
    
  }
//  "name": "XSS-FUZZER",
  if (decodedJSON[@"name"]) {
    
  }
//  "version": "1.0",
  if (decodedJSON[@"version"]) {
    
  }
//  "description": "description.",
  if (decodedJSON[@"description"]) {
    
  }
//  "icons": {
  if (decodedJSON[@"icons"]) {
    
  }
//    "48": "assets/img/icon.svg",
//    "96": "assets/img/icon.svg"
//  },
//  "browser_action": {
  if (decodedJSON[@"browser_action"]) {
    
  }
//    "default_icon": {
//      "48": "assets/img/icon.svg",
//      "96": "assets/img/icon.svg"
//    },
//    "default_popup": "/assets/html/ui.html",
//    "default_title": "XSS-FUZZER"
//  },
//  "content_security_policy": "script-src 'self' 'wasm-eval'; object-src 'none'",
  if (decodedJSON[@"content_security_policy"]) {
    
  }
//  "permissions": [
  if (decodedJSON[@"permissions"]) {
    
  }
//    "<all_urls>",
//    "webRequest",
//    "webRequestBlocking",
//    "contextMenus"
//  ],
//  "incognito": "spanning",
  if (decodedJSON[@"incognito"]) {
    
  }
//  "background": {
  if (decodedJSON[@"background"]) {
    
  }
//    "scripts": ["assets/js/hook.js"]
//  }
//}
  return dict;
}

@end

