/*

  SEJSContext.m

  JavaScript thread handlers.

*/

#import "SEJSContext.h"
#import <JavaScriptCore/JavaScriptCore.h>

@implementation SEJSContext

+(id)sharedInstance {
  static JSContext * jsContext = nil;
//  if (!jsContext) {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//      jsContext = [[JSContext alloc] init];
//    });
//  }
  return jsContext;
}

@end

