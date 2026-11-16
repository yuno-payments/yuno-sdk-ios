#import "YunoAntifraudRiskifiedBootstrap.h"

__attribute__((objc_runtime_name("_TtC22YunoAntifraudRiskified22YunoAntifraudRiskified")))
@interface YunoAntifraudRiskified : NSObject
+ (void)register;
@end

@implementation YunoAntifraudRiskifiedBootstrap

+ (void)load {
    [YunoAntifraudRiskified register];
}

@end
