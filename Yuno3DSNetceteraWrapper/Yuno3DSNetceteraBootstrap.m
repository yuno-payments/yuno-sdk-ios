#import "Yuno3DSNetceteraBootstrap.h"

__attribute__((objc_runtime_name("_TtC16Yuno3DSNetcetera16Yuno3DSNetcetera")))
@interface Yuno3DSNetcetera : NSObject
+ (void)register;
@end

@implementation Yuno3DSNetceteraBootstrap

+ (void)load {
    [Yuno3DSNetcetera register];
}

@end
