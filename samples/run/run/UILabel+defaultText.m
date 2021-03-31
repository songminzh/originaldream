//
//  UILabel+defaultText.m
//  run
//
//  Created by zm on 2021/3/25.
//

#import "UILabel+defaultText.h"
#import <objc/runtime.h>

static NSString *kDefaultTextKey = @"defaultText";

@implementation UILabel (defaultText)

- (void)setDefaultText:(NSString *)defaultText {
    /*
     id object：被关联的对象
     const void *key：关联的key，要求唯一
     id value：关联的对象
     objc_AssociationPolicy policy：内存管理的策略
     */
    objc_setAssociatedObject(self, &kDefaultTextKey, defaultText, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)defaultText {
    /*
     id object：被关联的对象
     const void *key：关联的key，要求唯一
     */
    return objc_getAssociatedObject(self, &kDefaultTextKey);
}

@end
