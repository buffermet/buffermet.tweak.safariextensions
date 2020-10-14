#import "Manifest.h"

/**
 * Documentation: https://developer.mozilla.org/en-US/docs/Mozilla/Add-ons/WebExtensions/manifest.json
 */

/**
 * Notes about manifest.json keys:
 *   - "manifest_version", "version", and "name" are the only mandatory keys.
 *   - "default_locale" must be present if the "_locales" directory is present, and must be absent otherwise.
 *   - "browser_specific_settings" is not supported in Google Chrome.
 */

@implementation Manifest

+(NSDictionary *)parseManifest:(NSString *)encodedJSON {
  NSMutableDictionary * const retvalManifest = [NSMutableDictionary new];
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
   * Documentation: https://developer.mozilla.org/en-US/docs/Mozilla/Add-ons/WebExtensions/manifest.json/content_scripts
   * Source: https://searchfox.org/mozilla-central/source/toolkit/components/extensions/ExtensionContent.jsm
   *
   * "content_scripts": [
   *   {
   *     "matches": ["*://example.org/test"],
   *     "js": ["borderify.js"]
   *   }
   * ]
   */
  if (decodedJSON[@"content_scripts"]) {
    NSMutableArray * retvalContentScripts = [NSMutableArray array];
    NSArray * contentScripts = decodedJSON[@"content_scripts"];
    // all_frames
    for (NSDictionary * contentScript in contentScripts) {
      NSMutableDictionary * retvalContentScript = [NSMutableDictionary new];
      if (contentScript[@"all_frames"]) {
        retvalContentScript[@"all_frames"] = contentScript[@"all_frames"];
      }
      if (contentScript[@"css"]) {
        retvalContentScript[@"css"] = contentScript[@"css"];
      }
      if (contentScript[@"exclude_globs"]) {
        retvalContentScript[@"exclude_globs"] = contentScript[@"exclude_globs"];
      }
      if (contentScript[@"exclude_matches"]) {
        retvalContentScript[@"exclude_matches"] = contentScript[@"exclude_matches"];
      }
      if (contentScript[@"include_globs"]) {
        retvalContentScript[@"include_globs"] = contentScript[@"include_globs"];
      }
      if (contentScript[@"js"]) {
        retvalContentScript[@"js"] = contentScript[@"js"];
      }
      if (contentScript[@"match_about_blank"]) {
        retvalContentScript[@"match_about_blank"] = contentScript[@"match_about_blank"];
      }
      if (contentScript[@"matches"]) {
        retvalContentScript[@"matches"] = contentScript[@"matches"];
      }
      if (contentScript[@"run_at"]) {
        retvalContentScript[@"run_at"] = contentScript[@"run_at"];
      }
    }
    // css
    // exclude_globs
    // exclude_matches
    // include_globs
    // js
    // match_about_blank
    // matches
    // run_at
    retvalManifest[@"content_scripts"] = retvalContentScripts;
  }
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
  return retvalManifest;
}

@end

