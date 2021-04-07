#import "ViewController.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "UILabel+defaultText.h"
#import "UIControl+Extension.h"

@interface ViewController ()

@end

@implementation ViewController

+ (void)load {
    /**
     Runtime应用2
     使用方法魔法（Method Swizzling）添加和替换方法的实现
     */
    static dispatch_once_t oneToken;
     
    dispatch_once(&oneToken, ^{
        Class class = [self class];
        
        SEL originalSelector = @selector(viewDidLoad);
        SEL swizzledSelector = @selector(swViewDidLoad);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        /**
         *  使用一个给定的名称和实现向类添加方法
         *
         *  cls 添加方法的类
         *  name 指定添加方法名称的选择器
         *  imp 新方法的实现功能
         *  types 描述该方法参数类型的字符数组
         *
         *  返回是否添加成功
         */
        BOOL didAddMethod = class_addMethod(class,
                                            originalSelector,
                                            (IMP)method_getImplementation(swizzledMethod),
                                            method_getTypeEncoding(swizzledMethod));
        if (didAddMethod) {
            /**
             * 替换给定类方法的实现
             *
             * @param cls 目标类
             * @param name 识别要替换其实现的方法的选择器
             * @param imp 标识的类名称识别方法的新实现
             * @param types 描述该方法参数类型的字符数组
             */
            class_replaceMethod(class,
                                swizzledSelector,
                                (IMP)method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            /**
             * 交换两个方法的实现
             *
             * @param m1 原方法
             * @param m2 替换的方法
             */
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *label = [[UILabel alloc] init];
    label.defaultText = @"label init";
    NSLog(@"default text of label:%@", label.defaultText);
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.text = @"tapme";
    btn.frame = self.view.bounds;
    [self.view addSubview:btn];
    
    [btn addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)clickAction {
    NSLog(@"tap me~~~");
}

- (void)swViewDidLoad {
    [super viewDidLoad];
    
    [self swViewDidLoad];
    NSLog(@"替换的viewDidLoad方法");
}

@end
