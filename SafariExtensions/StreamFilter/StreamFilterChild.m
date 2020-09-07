#import "StreamFilterChild.h"

@implementation StreamFilterChild

-(void)cleanup:(NSError *)error {}

-(void)close:(NSError *)error {}

-(void)disconnect:(NSError *)error {}

-(NSString *)getState {}

-(void)recvInitialized:(BOOL)success {
  if (success) {
    state = StreamFilterChildStateUninitialized;
  } else {
    state = StreamFilterChildStateError;
    if (streamFilter) {
      [streamFilter fireErrorEvent:@"Invalid request ID"];
      streamFilter = nil;
    }
  }
}

-()recvStartRequest {}

-()recvStopRequest:(int)status {}

-(void)resume:(NSError *)error {}

-(void)suspend:(NSError *)error {}

-(void)suspend:(NSError *)error {}

-(void)suspend:(NSError *)error {}

-(NSString *)status {}

-(void)suspend:(NSError *)error {}

-(void)write:(NSData *)data error:(NSError *)error {
  switch (state) {
    case StreamFilterChildStateSuspending:
    case StreamFilterChildStateResuming:
      switch (nextState) {
        case StreamFilterChildStateSuspended:
        case StreamFilterChildStateTransferringData:
          break;
        default:
          // throw error
          return;
      }
      break;
    case StreamFilterChildStateSuspended:
    case StreamFilterChildStateTransferringData:
    case StreamFilterChildStateFinishedTransferringData:
      break;
    default:
      // throw error
      return;
  }

  // [? sendwrite: ?]
}

@end

