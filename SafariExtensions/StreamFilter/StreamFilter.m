#import "StreamFilter.h"

@implementation StreamFilter

-(BOOL)checkAlive {
  return true;
}

-(void)close:(NSError *)error {}

-(void)connect {}

-(void)disconnect:(NSError *)error {}

-(void)finishConnect {}

-(void)fireDataEvent:(NSData *)data {}

-(void)fireErrorEvent:(NSString *)error {}

-(void)fireEvent:(NSString *)type {}

-(void)forgetActor {}

-(BOOL)isAllowedInContext:(JSContext *)context {
  return true;
}

-(BOOL)readTypedArrayData:(NSData *)data array:(NSArray *)array error:(NSError *)error {
  return true;
}

-(void)resume:(NSError *)error {}

//-(StreamFilterStatus *)status {}

-(void)suspend:(NSError *)error {}

-(void)write:(NSData *)data error:(NSError *)error {}

@end

