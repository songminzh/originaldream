//
//  UIControl+Extension.h
//  run
//
//  Created by zm on 2021/3/31.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIControl (Extension)

/// 时间间隔
@property (nonatomic, assign) NSTimeInterval cs_eventInterval;

/// 按钮点击事件是否失效
@property (nonatomic, assign) BOOL cs_eventInvalid;

@end

NS_ASSUME_NONNULL_END
