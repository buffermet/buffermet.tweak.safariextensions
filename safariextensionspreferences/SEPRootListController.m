#include "SEPRootListController.h"

@implementation SEPRootListController

-(NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self
      loadSpecifiersFromPlistName:@"Root"
      target:self];
	}
	return _specifiers;
}

-(void)openTwitterBuffermet {
  [[UIApplication sharedApplication]
    openURL:[NSURL
      URLWithString:@"https://twitter.com/buffermet"]];
}

-(void)openSourceGitHub {
  [[UIApplication sharedApplication]
    openURL:[NSURL
      URLWithString:@"https://github.com/buffermet/buffermet.tweak.safariextensions"]];
}

-(void)openDonateCoinbase {
  [[UIApplication sharedApplication]
    openURL:[NSURL
      URLWithString:@"https://commerce.coinbase.com/checkout/0a02280b-87f9-45b7-a0e5-a8535ca43900"]];
}

@end
