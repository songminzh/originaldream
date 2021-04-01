//
//  UIControl+Extension.m
//  run
//
//  Created by zm on 2021/3/31.
//  防止按钮重复点击
//  利用Runtime特性，交换UIButton的事件响应方法，从而控制响应时间间隔

#import "UIControl+Extension.h"
#import <objc/runtime.h>

static const char * kCSEventIntervalKey = "CSEventIntervalKey";
static const char * kCSEventInvalidKey  = "CSEventInvalidKey";

@interface UIControl (Extension)

/// 按钮点击事件是否失效
@property (nonatomic, assign) BOOL cs_eventInvalid;

@end

@implementation UIControl (Extension)

+ (void)load {
    Method clickMethod = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
    Method cs_clickMethod = class_getInstanceMethod(self, @selector(cs_sendAction:to:forEvent:));
    method_exchangeImplementations(clickMethod, cs_clickMethod);
}

- (void)cs_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    if (!self.cs_eventInvalid) {
        self.cs_eventInvalid = YES;
        [self cs_sendAction:action to:target forEvent:event];
        NSTimeInterval timeInterval = self.cs_eventInterval > 0 ? self.cs_eventInterval : 2.0; // 设置默认值
        [self performSelector:@selector(setCs_eventInvalid:) withObject:@(NO) afterDelay:timeInterval];
    }
}

#pragma mark - Getter & Setter

- (void)setCs_eventInterval:(NSTimeInterval)cs_eventInterval {
    objc_setAssociatedObject(self, kCSEventIntervalKey, @(cs_eventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSTimeInterval)cs_eventInterval {
    return [objc_getAssociatedObject(self, kCSEventIntervalKey) doubleValue];
}

- (void)setCs_eventInvalid:(BOOL)cs_eventInvalid {
    objc_setAssociatedObject(self, kCSEventInvalidKey, @(cs_eventInvalid), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)cs_eventInvalid {
    return [objc_getAssociatedObject(self, kCSEventInvalidKey) boolValue];
}


@end
