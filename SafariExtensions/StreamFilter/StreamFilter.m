#import "StreamFilter.h"

@implementation StreamFilter

+(instancetype)initWithParentID:() requestID:(uint64_t *)requestID addonID:(NSString *)addonID {}

-(BOOL)checkAlive {}

-(void)close:(NSError * error) {}

-(void)connect {}

-(void)disconnect:(NSError * error) {}

-(void)finishConnect {}

-(void)fireDataEvent:(uint8_t * data) {}

-(void)fireErrorEvent:(NSString * error) {}

-(void)fireEvent:(NSString * type) {}

-(void)forgetActor {}

-(BOOL)isAllowedInContext:(JSContext *)context {}

-(BOOL)readTypedArrayData(uint8_t & data, NSArray * array, NSError * error) {}

-(void)resume:(NSError * error) {}

-(StreamFilterStatus *)status {}

-(void)suspend:(NSError * error) {}

-(void)write:(uint8_t * data, NSError * error) {}

@end

