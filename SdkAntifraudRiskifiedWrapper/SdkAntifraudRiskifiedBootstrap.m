#import "SdkAntifraudRiskifiedBootstrap.h"

@interface SdkAntifraudRiskified : NSObject
+ (void)register;
@end

@implementation SdkAntifraudRiskifiedBootstrap

+ (void)load {
    [SdkAntifraudRiskified register];
}

@end
