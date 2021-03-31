# performSelector

## performSelector和直接调用方法的区别

`performSelector: withObject:`是在iOS中的一种方法调用方式。它可以向一个对象传递任何消息，而不需要在编译的时候声明这些方法。所以这也是`runtime`的一种应用方式。

`performSelector`和直接调用方法的区别在于`runtime`。直接调用编译是会自动校验。如果方法不存在，那么直接调用 在编译时候就能够发现，编译器会直接报错。
但是使用`performSelector`一定是在运行时候才能发现，如果此方法不存在就会崩溃。所以如果使用`performSelector`的话他就会有个最佳伴侣`- (BOOL)respondsToSelector:(SEL)aSelector`来在运行时判断对象是否响应此方法。

## performSelector使用的四种方式

**第一种：无参数传递**

```objective-c
[self performSelector:@selector(selectorNoParameter)];

- (void)selectorNoParameter {
    NSLog(@"Selector with no parameter");
}
```

**第二种：传递一个参数**

```objective-c
[self performSelector:@selector(selectorOneParameter:) withObject:@"firstParameter"];

- (void)selectorOneParameter:(NSString *)first {
    NSLog(@"Selector with one parameter: %@", first);
}
```

**第三种：传递两个参数**

```objective-c
[self performSelector:@selector(selectorFirstParameter:secondParameter:) withObject:@"firstParameter" withObject:@"secondParameter"];

- (void)selectorFirstParameter:(NSString *)first secondParameter:(NSString *)second {
    NSLog(@"Selector with first parameter:%@, second parameter:%@", first, second);
}
```

**第四种：建立动态的函数，然后调用它们**

```objective-c
NSArray *objectArray = @[@{@"methodName": @"dynamicParameterString:", @"value": @"String"}, @{@"methodName": @"dynamicParameterNumber:", @"value": @2}];

for (NSDictionary *dic in objectArray) {       
    [self performSelector:NSSelectorFromString([dic objectForKey:@"methodName"]) withObject：[dic objectForKey:@"value"]];
}

- (void)dynamicParameterString:(NSString *)string{
    NSLog(@"Dynamic parameter string: %@",string);
}

- (void)dynamicParameterNumber:(NSNumber *)number{
    NSLog(@"Dynamic parameter number: %@",number);
}
```

**这里还有一些其他的类似的方法：**
`performSelectorOnMainThread:@selector() withObjects:object waitUntilDone:YES`
这个函数表示在主线程上执行方法，YES表示需要阻塞主线程，直到主线程将我们的代码块执行完毕。

## performSelector的应用

#### 传递三个及以上的参数

performSelector如何传递三个及以上的参数。

这里有三种方法，一种是使用NSInvocation，还有一种是把多个参数封装成一个参数。第三种是使用objc_msgSend，应该不算用performSelector这种方式，但是performSelector最后也还是用objc_msgSend这个方法进行消息转发的，所以姑且也写进来了。

第一种使用了runtime的反射机制，效率较低，可读性不高。第二种可读性高，效率稍微高点。

**第一种：NSInvocation**



```objective-c
- (id)performSelector:(SEL)selector withObjects:(NSArray *)objects
{
    // 方法签名(方法的描述)
    NSMethodSignature *signature = [[self class] instanceMethodSignatureForSelector:selector];
    if (signature == nil) {
        //可以抛出异常也可以不操作。
    }
    
    // NSInvocation : 利用一个NSInvocation对象包装一次方法调用（方法调用者、方法名、方法参数、方法返回值）
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.target = self;
    invocation.selector = selector;
    
    // 设置参数
    NSInteger paramsCount = signature.numberOfArguments - 2; // 除self、_cmd以外的参数个数
    paramsCount = MIN(paramsCount, objects.count);
    for (NSInteger i = 0; i < paramsCount; i++) {
        id object = objects[i];
        if ([object isKindOfClass:[NSNull class]]) continue;
        [invocation setArgument:&object atIndex:i + 2];
    }
    
    // 调用方法
    [invocation invoke];
    
    // 获取返回值
    id returnValue = nil;
    if (signature.methodReturnLength) { // 有返回值类型，才去获得返回值
        [invocation getReturnValue:&returnValue];
    }
    
    return returnValue;
}

NSString *str = @"字符串";
NSNumber *num = @20;
NSArray *arr = @[@"数组值1", @"数组值2"];
SEL sel = NSSelectorFromString(@"NSInvocationWithString:withNum:withArray:");
NSArray *objs = [NSArray arrayWithObjects:str, num, arr, nil];
    
[self performSelector:sel withObjects:objs];

- (void)NSInvocationWithString:(NSString *)string withNum:(NSNumber *)number withArray:(NSArray *)array {
    NSLog(@"%@, %@, %@", string, number, array[0]);
}
```

**第二种：把多个参数封装成一个参数**

比如可以把多个参数封装成NSDictionary，然后进行传递。

**第三种：objc_msgSend**

```objective-c
NSString *str = @"字符串objc_msgSend";
NSNumber *num = @20;
NSArray *arr = @[@"数组值1", @"数组值2"];
SEL sel = NSSelectorFromString(@"objcMsgSendWithString:num:array:");
    
((void (*) (id, SEL, NSString *, NSNumber *, NSArray *)) objc_msgSend) (self, sel, str, num, arr);

- (void)objcMsgSendWithString:(NSString *)string num:(NSNumber *)number array:(NSArray *)array {
    NSLog(@"%@, %@, %@", string, number, array[0]);
}
```

#### aSelector方法被延迟调用

performSelector里的aSelector方法被延迟调用问题。

`- (void)performSelector:(SEL)aSelector withObject:(id)arg; afterDelay:(NSTimeInterval)delay;`
这个方法其实是增加了一个定时器，而这时aSelector应该是被添加到了队列的最后面，所以要等当前调用此方法的函数执行完毕后，selector方法才会执行。如下：

```objectivec
- (void)mainMethod {   
    [self performSelector:@selector(delayMethod) withObject:nil afterDelay:1];
    NSLog(@"调用方法＝＝开始");
    sleep(5);
    NSLog(@"调用方法＝＝结束");
}

- (void)delayMethod {
    NSLog(@"执行延迟方法");
}

执行结果（注意log打印的顺序）：
调用方法＝＝开始
调用方法＝＝结束
执行延迟方法
```

那如果我要selector方法不用等待函数执行完再执行怎么办？其实只要不使用有`afterDelay:(NSTimeInterval)delay`这个参数的方法就可以了。

`- (void)performSelectorInBackground:(SEL)aSelector withObject:(id)arg`
这个方法是直接在后台线程运行。如果直接用这个上面例子的打印结果就是：

```bash
执行结果（注意log打印的顺序）：
调用方法＝＝开始
执行延迟方法
调用方法＝＝结束
```

`- (void)performSelectorOnMainThread:(SEL)aSelector withObject:(id)arg waitUntilDone:(BOOL)wait;`
这个方法是表示在主线程执行方法。然后参数wait如果为YES表示是否等待方法执行完毕再往下执行。那输出结果就是：

```bash
执行结果（注意log打印的顺序）：
执行延迟方法
调用方法＝＝开始
调用方法＝＝结束
```

如果为NO，还是跟原来使用`afterDelay:(NSTimeInterval)delay`方式一样，要等当前调用此方法的函数执行完毕后，selector方法才会执行，输出结果就是：

```bash
执行结果（注意log打印的顺序）：
调用方法＝＝开始
调用方法＝＝结束
执行延迟方法
```

`- (id)performSelector:(SEL)aSelector withObject:(id)object;`
这种是最简单的一种方式，输出结果是：

```bash
执行结果（注意log打印的顺序）：
执行延迟方法
调用方法＝＝开始
调用方法＝＝结束
```

但如果我要使用延时方法呢，可以使用`dispatch_after`在子线程上执行：

```objectivec
dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_global_queue(0, 0), ^{
        if ([self respondsToSelector:@selector(delayMethod)]) {
            [self performSelector:@selector(delayMethod) withObject:nil];
        }
});
    
NSLog(@"调用方法＝＝开始");
sleep(5);
NSLog(@"调用方法＝＝结束");
```

输出结果如下：

```bash
执行结果（注意log打印的顺序）：
调用方法＝＝开始
执行延迟方法
调用方法＝＝结束
```

#### 在子线程中无法调用selector方法

在子线程中无法调用selector方法这种情况是只有使用以下方法的时候才出现:

```
- (void)performSelector:(SEL)aSelector withObject:(id)arg afterDelay:(NSTimeInterval)delay;
```

这是为什么呢？原因如下：

1、afterDelay方式是使用当前线程的Run Loop中根据afterDelay参数创建一个Timer定时器在一定时间后调用SEL，NO AfterDelay方式是直接调用SEL。

2、子线程中默认是没有runloop的，需要手动创建，只要调用获取当前线程RunLoop方法即可创建。

所以解决方法有两种：

- 创建子线程的runloop

```objectivec
dispatch_async(dispatch_get_global_queue(0, 0), ^{
    [self performSelector:@selector(delayMethod) withObject:nil afterDelay:0];
    [[NSRunLoop currentRunLoop] run];
    NSLog(@"调用方法＝＝开始");
    sleep(5);
    NSLog(@"调用方法＝＝结束");
});
```

- 使用`dispatch_after`在子线程上执行

```objectivec
dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_global_queue(0, 0), ^{
        if ([self respondsToSelector:@selector(delayMethod)]) {
            [self performSelector:@selector(delayMethod) withObject:nil];
        }
});
    
NSLog(@"调用方法＝＝开始");
sleep(5);
NSLog(@"调用方法＝＝结束");
```

#### 防止按钮多次点击

这种方式是在0.2秒内取消之前的点击事件，以做到防止多次点击。

```objectivec
- (void)completeClicked:(UIButton *)sender {
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(buttonClick:) object:sender];
    [self performSelector:@selector(buttonClick:) withObject:sender afterDelay:0.2f];
}
```

这种方式是在点击后设为不可被点击的状态，1秒后恢复

```objectivec
- (void)buttonClicked:(id)sender{
    self.button.enabled = NO;
    [selfperformSelector:@selector(changeButtonStatus)withObject:nilafterDelay:1.0f];//防止重复点击
}

- (void)changeButtonStatus {
    self.button.enabled = YES;
}
```