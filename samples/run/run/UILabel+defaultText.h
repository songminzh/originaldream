//
//  UILabel+defaultText.h
//  run
//
//  Created by zm on 2021/3/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (defaultText)

//  Runtime应用
//  关联对象(Objective-C Associated Objects)给分类增加属性

/// 添加自定义属性：默认文本
@property (nonatomic, copy) NSString * defaultText;

@end

NS_ASSUME_NONNULL_END
