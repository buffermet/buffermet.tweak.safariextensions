/*
#import <CFNetwork/CFNetwork-Structs.h>
#import <CFNetwork/NSSecureCoding.h>
#import <CFNetwork/NSCopying.h>
#import <CFNetwork/NSMutableCopying.h>

@class NSURLRequestInternal, NSString, NSDictionary, NSData, NSInputStream, NSURL;

@interface NSURLRequest : NSObject <NSSecureCoding, NSCopying, NSMutableCopying> {
	NSURLRequestInternal* _internal;
}
@property (copy,readonly) NSString* HTTPMethod; 
@property (copy,readonly) NSDictionary* allHTTPHeaderFields; 
@property (copy,readonly) NSData* HTTPBody; 
@property (retain,readonly) NSInputStream* HTTPBodyStream; 
@property (readonly) bool HTTPShouldHandleCookies; 
@property (readonly) bool HTTPShouldUsePipelining; 
@property (copy,readonly) NSURL* URL; 
@property (readonly) unsignedlonglong cachePolicy; 
@property (readonly) double timeoutInterval; 
@property (copy,readonly) NSURL* mainDocumentURL; 
@property (readonly) unsignedlonglong networkServiceType; 
@property (readonly) bool allowsCellularAccess; 
+(id)getObjectKeyWithIndex:(long long)arg1 ;
+(bool)allowsAnyHTTPSCertificateForHost:(id)arg1 ;
+(void)setDefaultTimeoutInterval:(double)arg1 ;
+(double)defaultTimeoutInterval;
+(void)setAllowsAnyHTTPSCertificate:(bool)arg1 forHost:(id)arg2 ;
+(bool)supportsSecureCoding;
+(id)requestWithURL:(id)arg1 cachePolicy:(unsigned long long)arg2 timeoutInterval:(double)arg3 ;
+(id)requestWithURL:(id)arg1 ;
+(id)allowsSpecificHTTPSCertificateForHost:(id)arg1 ;
+(void)setAllowsSpecificHTTPSCertificate:(id)arg1 forHost:(id)arg2 ;
-(id)_startTimeoutDate;
-(double)_payloadTransmissionTimeout;
-(id)mainDocumentURL;
-(bool)_URLHasScheme:(id)arg1 ;
-(bool)_isSafeRequestForBackgroundDownload;
-(void)_removePropertyForKey:(id)arg1 ;
-(double)_timeWindowDelay;
-(double)_timeWindowDuration;
-(bool)_requiresShortConnectionTimeout;
-(id)_copyReplacingURLWithURL:(id)arg1 ;
-(id)boundInterfaceIdentifier;
-(id)HTTPContentType;
-(id)HTTPExtraCookies;
-(id)HTTPReferrer;
-(id)HTTPUserAgent;
-(bool)HTTPShouldUsePipelining;
-(id)contentDispositionEncodingFallbackArray;
-(unsigned long long)expectedWorkload;
-(unsigned long long)networkServiceType;
-(id)initWithURL:(id)arg1 cachePolicy:(unsigned long long)arg2 timeoutInterval:(double)arg3 ;
-(unsigned long long)cachePolicy;
-(double)timeoutInterval;
-(bool)HTTPShouldHandleCookies;
-(bool)allowsCellularAccess;
-(id)HTTPMethod;
-(id)HTTPBody;
-(id)allHTTPHeaderFields;
-(id)init;
-(id)initWithCoder:(id)arg1 ;
-(void)encodeWithCoder:(id)arg1 ;
-(void)dealloc;
-(bool)isEqual:(id)arg1 ;
-(unsigned long long)hash;
-(id)description;
-(id)initWithURL:(id)arg1 ;
-(id)copyWithZone:(NSZoneRef)arg1 ;
-(id)URL;
-(id)mutableCopyWithZone:(NSZoneRef)arg1 ;
-(id)valueForHTTPHeaderField:(id)arg1 ;
-(CFURLRequestRef)_CFURLRequest;
-(id)_initWithCFURLRequest:(CFURLRequestRef)arg1 ;
-(id)_propertyForKey:(id)arg1 ;
-(id)HTTPBodyStream;
-(void)_setProperty:(id)arg1 forKey:(id)arg2 ;
@end
*/



