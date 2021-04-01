# SDK开发

> SDK：Software Development Kit

## 基础知识

1. 静态库与动态库

   * 静态库：链接时完整的拷贝到可执行文件，多次使用多次拷贝，造成冗余，使包变的更大。

   * 动态库：链接时不复制，程序运行时由系统加在到内存中，供系统调用，系统加在一次，多次使用，共用节省内存。

   * iOS静态库：.framework和.a
   * iOS动态库：.framework和.dylib

2. Framework与.a

   * .a 是单纯的二进制文件，.framework是二进制文件+资源文件。
   * 其中.a 不能直接使用，需要 .h文件配合，而.framework则可以直接使用。
   * .framework = .a + .h + sourceFile(资源文件)

## 开发流程

### 一、创建SDK

1. 创建Project：File->New->Project,选择Cocoa Touch Framework或Cocoa Touch Static Library。
2. 设置Deployment Target 为iOS8.0及以上，开发相关功能。
3. 设置Build Settings参数,Architectures添加armv7s支持。
4. 设置Build Phases中Headers，将需要暴露的.h文件添加到Public中。

### 二、编译

1. 编辑Scheme:Edit Schemes->Run->Build Configuration，改为Release。
2. 选择任意模拟器，Build；选择Generic iOS Device，Build。
3. 使用lipo合并framework或.a库，使其支持指令集：i386 x86_64 armv7 armv7s arm64 。

## Tips

### Mach-O Type

在制作Framework时，可以设置framework中的Mach-O Type，不手动修改的默认配置即为 Dynamic Library，在SDK中默认使用的是 Relocatable Object File。

| 类型                    | 说明                         |
| ----------------------- | ---------------------------- |
| Dynamic Library         | 动态库                       |
| Executable              | 可执行二进制文件             |
| Bundle                  | 非独立二进制文件，显示加载   |
| Static Library          | 静态库                       |
| Relocatable Object File | 可重定位的目标文件，中间结果 |


