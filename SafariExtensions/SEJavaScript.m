/*

  SEJavaScript.m

  This class adds JavaScript interpretability by reserving a static WKWebView
  for classes that have no instance of WKWebView.

*/

#import "SEJavaScript.h"

@implementation SEJavaScript

+(NSString *)sharedWebView {
  return @"WTF";
}

@end

