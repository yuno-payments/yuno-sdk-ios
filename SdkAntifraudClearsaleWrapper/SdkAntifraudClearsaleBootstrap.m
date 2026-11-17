#import "SdkAntifraudClearsaleBootstrap.h"

@interface SdkAntifraudClearsale : NSObject
+ (void)register;
@end

@implementation SdkAntifraudClearsaleBootstrap

+ (void)load {
    [SdkAntifraudClearsale register];
}

@end
