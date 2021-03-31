# Objective-C高级编程 目录

第1章 自动引用计数　　1
1.1 　什么是自动引用计数　　2
1.2 　内存管理/引用计数　　2
1.2.1 　概要　　2
1.2.2 　内存管理的思考方式　　5
1.2.3 　alloc/retain/release/dealloc实现　　13
1.2.4 　苹果的实现　　17
1.2.5 　autorelease　　20
1.2.6 　autorelease实现　　24
1.2.7 　苹果的实现　　26
1.3 　ARC规则　　29
1.3.1 　概要　　29
1.3.2 　内存管理的思考方式　　30
1.3.3 　所有权修饰符　　30
1.3.4 　规则　　50
1.3.5 　属性　　62
1.3.6 　数组　　63
1.4 　ARC的实现　　65
1.4.1 　__strong修饰符　　65
1.4.2 　__weak修饰符　　67
1.4.3 　__autoreleasing修饰符　　75
1.4.4 　引用计数　　76
第2章 Blocks　　79
2.1 　Blocks概要　　80
2.1.1 　什么是Blocks　　80
2.2 　Blocks模式　　83
2.2.1 　Block语法　　83
2.2.2 　Block类型变量　　85
2.2.3 　截获自动变量值　　88
2.2.4 　__block说明符　　88
2.2.5 　截获的自动变量　　89
2.3 　Blocks的实现　　91
2.3.1 　Block的实质　　91
2.3.2 　截获自动变量值　　99
2.3.3 　__block说明符　　102
2.3.4 　Block存储域　　108
2.3.5 　__block变量存储域　　117
2.3.6 　截获对象　　121
2.3.7 　__block变量和对象　　126
2.3.8 　Block循环引用　　128
2.3.9 　copy/release　　134
第3章 Grand Central Dispatch　　137
3.1 　Grand Central Dispatch（GCD）概要　　138
3.1.1 　什么是GCD　　138
3.1.2 　多线程编程　　140
3.2 　GCD的API　　144
3.2.1 　Dispatch Queue　　144
3.2.2 　dispatch_queue_create　　147
3.2.3 　Main Dispatch Queue/Global Dispatch Queue　　150
3.2.4 　dispatch_set_target_queue　　153
3.2.5 　dispatch_after　　154
3.2.6 　Dispatch Group　　155
3.2.7 　dispatch_barrier_async　　157
3.2.8 　dispatch_sync　　160
3.2.9 　dispatch_apply　　161
3.2.10 　dispatch_suspend / dispatch_resume　　163
3.2.11 　Dispatch Semaphore　　164
3.2.12 　dispatch_once　　166
3.2.13 　Dispatch I/O　　167
3.3 　GCD实现　　169
3.3.1 　Dispatch Queue　　169
3.3.2 　Dispatch Source　　171
附录A 　ARC、Blocks、GCD使用范例　　176
附录B 　参考资料　　182