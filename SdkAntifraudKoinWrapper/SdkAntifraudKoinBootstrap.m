#import "SdkAntifraudKoinBootstrap.h"

@interface SdkAntifraudKoin : NSObject
+ (void)register;
@end

@implementation SdkAntifraudKoinBootstrap

+ (void)load {
    [SdkAntifraudKoin register];
}

@end
