//
//  UIControl+Extension.m
//  run
//
//  Created by zm on 2021/3/31.
//  防止按钮重复点击
//  利用Runtime特性，交换UIButton的事件响应方法，从而控制响应时间间隔

#import "UIControl+Extension.h"
#import <objc/runtime.h>
#import <objc/message.h>

static const char * kSWEventIntervalKey = "EventIntervalKey";
static const char * kSWEventInvalidKey  = "EventInvalidKey";

@interface UIControl (Extension)

/// 按钮点击事件是否失效
@property (nonatomic, assign) BOOL sw_eventInvalid;

@end

@implementation UIControl (Extension)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL clickSelector = @selector(sendAction:to:forEvent:);
        SEL sw_clickSelector = @selector(sw_sendAction:to:forEvent:);
        
        Method clickMethod = class_getInstanceMethod([self class], clickSelector);
        Method sw_clickMethod = class_getInstanceMethod([self class], sw_clickSelector);
        
        BOOL didAddMethod = class_addMethod([self class], clickSelector, method_getImplementation(sw_clickMethod), method_getTypeEncoding(sw_clickMethod));
        if (didAddMethod) {
            class_replaceMethod([self class], sw_clickSelector, method_getImplementation(clickMethod), method_getTypeEncoding(clickMethod));
        }
        else {
            method_exchangeImplementations(clickMethod, sw_clickMethod);
        }
    });
}

- (void)sw_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    if (!self.sw_eventInvalid) {
        self.sw_eventInvalid = YES;
        [self sw_sendAction:action to:target forEvent:event];
        NSTimeInterval timeInterval = self.sw_eventInterval > 0 ? self.sw_eventInterval : 2.0; // 设置默认值
        [self performSelector:@selector(setSw_eventInvalid:) withObject:@(NO) afterDelay:timeInterval];
    }
}

#pragma mark - Getter & Setter

- (void)setSw_eventInterval:(NSTimeInterval)sw_eventInterval {
    objc_setAssociatedObject(self, kSWEventIntervalKey, @(sw_eventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSTimeInterval)sw_eventInterval {
    return [objc_getAssociatedObject(self, kSWEventIntervalKey) doubleValue];
}

- (void)setSw_eventInvalid:(BOOL)sw_eventInvalid {
    objc_setAssociatedObject(self, kSWEventInvalidKey, @(sw_eventInvalid), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)sw_eventInvalid {
    return [objc_getAssociatedObject(self, kSWEventInvalidKey) boolValue];
}


@end
