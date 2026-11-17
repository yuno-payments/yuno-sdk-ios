#import "SdkPaymentsNetceteraBootstrap.h"

@interface SdkPaymentsNetcetera : NSObject
+ (void)register;
@end

@implementation SdkPaymentsNetceteraBootstrap

+ (void)load {
    [SdkPaymentsNetcetera register];
}

@end
