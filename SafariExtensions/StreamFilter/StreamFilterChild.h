#import "StreamFilter.h"

const int StreamFilterChildStateUninitialized = 0;
const int StreamFilterChildStateInitialized = 1;
const int StreamFilterChildStateTransferringData = 2;
const int StreamFilterChildStateFinishedTransferringData = 3;
const int StreamFilterChildStateSuspending = 4;
const int StreamFilterChildStateSuspended = 5;
const int StreamFilterChildStateResuming = 6;
const int StreamFilterChildStateClosing = 7;
const int StreamFilterChildStateClosed = 8;
const int StreamFilterChildStateDisconnecting = 8;
const int StreamFilterChildStateDisconnected = 9;
const int StreamFilterChildStateError = 10;

@interface StreamFilterChild : NSObject {
  int nextState;
  int state;
  const StreamFilter * streamFilter;
}
-(void)cleanup:(NSError *)error;
-(void)close:(NSError *)error;
-(void)disconnect:(NSError *)error;
-(NSInteger *)getState;
-(void)recvInitialized:(BOOL)success;
-(void)resume:(NSError *)error;
-(void)suspend:(NSError *)error;
-(NSString *)status;
-(void)write:(NSData *)data error:(NSError *)error;
@end

