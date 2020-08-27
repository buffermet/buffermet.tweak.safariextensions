#include "SEPExtensionsListController.h"

/*
NSDictionary * const extensions = @{
  @"0": @{
    @"manifest": @{
      @"manifest_version": @2,
      @"name": @"HTTPS or BYE",
      @"version": @"1.0",
      @"description": @"A strict HTTPS enforcer.",
      @"icons": @{
        @"48": @"assets/img/icon.svg",
        @"96": @"assets/img/icon.svg"
      },
      @"permissions": @[
        @"<all_urls>",
        @"webRequest",
        @"webRequestBlocking",
        @"contextMenus"
      ],
      @"background": @{
        @"scripts": @[
          @"assets/js/hook.js"
        ]
      }
    },
    @"webRequest": @{
      @"onAuthRequired": @{},
      @"onBeforeRequest": @{},
      @"onBeforeSendHeaders": @{},
      @"onHeadersReceived": @{}
    }
  }
};
*/

//const NSString * const PATH_EXTENSIONS_LIST = @"";
//const NSString * const PATH_EXTENSION_ = @"";
//const NSString * const PATH_EXTENSIONS_LIST = @"";

@implementation SEPExtensionsListController

-(NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self
      loadSpecifiersFromPlistName:@"My Extensions"
      target:self];
	}
  /* debug */
  const NSArray * const x = @[
    @"HTTPS or BYE",
    @"Dark Mode",
  ];
  int index = 1;
  for (NSString * extensionName in x) {
    PSSpecifier * specifier = [PSSpecifier
      preferenceSpecifierNamed:extensionName
      target:self
      set:NULL
      get:NULL
      detail:NSClassFromString(@"SEExtensionOptionsListController")
      cell:PSLinkListCell
      edit:Nil];
    [specifier setProperty:@YES forKey:@"enabled"];
    [specifier setProperty:@"0" forKey:@"default"];		
    //specifier.shortTitleDictionary = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"T1",@"T@",@"T3",nil] forKeys:specifier.values];
    [specifier
      setProperty:@"kListValue"
      forKey:@"key"];
    [_specifiers
      insertObject:specifier
      atIndex:index];
    index++;
  }
	return _specifiers;
}

@end

