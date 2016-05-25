#import <Foundation/Foundation.h>
#import <Availability.h>
@interface ActivationInfo : NSObject<NSXMLParserDelegate> {
	BOOL isReadingAuthToken;
}

@property (strong, nonatomic) NSString* installationID;

- (id)initWithData:(NSData*)data;

@end
