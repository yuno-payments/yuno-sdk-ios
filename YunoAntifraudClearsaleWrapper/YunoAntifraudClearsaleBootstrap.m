#import "YunoAntifraudClearsaleBootstrap.h"

__attribute__((objc_runtime_name("_TtC22YunoAntifraudClearsale22YunoAntifraudClearsale")))
@interface YunoAntifraudClearsale : NSObject
+ (void)register;
@end

@implementation YunoAntifraudClearsaleBootstrap

+ (void)load {
    [YunoAntifraudClearsale register];
}

@end
