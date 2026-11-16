#import "YunoAntifraudKoinBootstrap.h"

__attribute__((objc_runtime_name("_TtC17YunoAntifraudKoin17YunoAntifraudKoin")))
@interface YunoAntifraudKoin : NSObject
+ (void)register;
@end

@implementation YunoAntifraudKoinBootstrap

+ (void)load {
    [YunoAntifraudKoin register];
}

@end
