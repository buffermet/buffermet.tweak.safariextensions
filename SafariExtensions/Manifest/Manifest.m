#import "Manifest.h"

// https://developer.mozilla.org/en-US/docs/Mozilla/Add-ons/WebExtensions/manifest.json

/*

 Notes about manifest.json keys:
  - "manifest_version", "version", and "name" are the only mandatory keys.
  - "default_locale" must be present if the "_locales" directory is present, and must be absent otherwise.
  - "browser_specific_settings" is not supported in Google Chrome.

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
  if (decodedJSON[@"author"]) {}
  if (decodedJSON[@"background"]) {}
  if (decodedJSON[@"browser_action"]) {}
  if (decodedJSON[@"browser_specific_settings"]) {}
  if (decodedJSON[@"chrome_settings_overrides"]) {}
  if (decodedJSON[@"chrome_url_overrides"]) {}
  if (decodedJSON[@"commands"]) {}
  /**
   * https://developer.mozilla.org/en-US/docs/Mozilla/Add-ons/WebExtensions/manifest.json/content_scripts
   *
   * "content_scripts": [
   *   {
   *     "matches": ["*://example.org"],
   *     "js": ["borderify.js"]
   *   }
   * ]
   */
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
  return dict;
}

@end

