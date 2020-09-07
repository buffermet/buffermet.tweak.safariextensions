const int StreamFilterParentStateUninitialized = 0;
const int StreamFilterParentStateInitialized = 1;
const int StreamFilterParentStateTransferringData = 2;
const int StreamFilterParentStateSuspended = 3;
const int StreamFilterParentStateClosed = 4;
const int StreamFilterParentStateDisconnecting = 5;
const int StreamFilterParentStateDisconnected = 6;

@interface StreamFilterParent : NSObject {
  
}
-()create;
-()attach:()channel parentEndPoint:(ParentEndPoint *)endPoint;
@end
