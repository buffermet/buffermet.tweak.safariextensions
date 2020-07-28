#include "SEPExtensionsListController.h"

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
      detail:NSClassFromString(@"PSListItemsController")
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

