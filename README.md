# YFLog

[![License](https://img.shields.io/github/license/mashape/apistatus.svg)](https://img.shields.io/github/license/laichanwai/YFLog.svg) &nbsp; [![Support](https://img.shields.io/badge/support-iOS%208%2B%20-blue.svg?style=flat)](https://www.apple.com/nl/ios/) &nbsp; [![CI Status](https://travis-ci.org/laichanwai/YFLog.svg?branch=master)](https://travis-ci.org/laizw/YFLog) &nbsp; [![Pod](https://img.shields.io/cocoapods/v/YFLog.svg?style=flat)](https://img.shields.io/cocoapods/v/YFLog.svg?style=flat)

一个简单美的控制台日志工具

以前都是使用 XcodeColors + CocoaLumberjack，奈何 Xcode 8 不能再使用插件了，只好自己来撸一个了~

## Usage

`YFLog` 的宏默认使用的 domain

```objc
extern NSString * const YFLoggerDefaultDomain;

[YFLogger logger]; // 使用默认 domain 创建的 logger
```

### YFLog 有 5 个 Level，分别对应不同的颜色

```objc
typedef enum : NSUInteger {
    YFLoggerLevelNone    = 0,
    YFLoggerLevelError   = 1,      // ❤️
    YFLoggerLevelWarning = 1 << 1, // 💛
    YFLoggerLevelDebug   = 1 << 2, // 💚
    YFLoggerLevelInfo    = 1 << 3, // 💙
    YFLoggerLevelVerbose = 1 << 4, // 💜
    YFLoggerLevelAll     = NSUIntegerMax,
} YFLoggerLevel;

// 默认是 YFLoggerLevelAll
[[YFLogger logger] setLoggerLevelMask:YFLoggerLevelAll];

// 如果只想看到 Error 和 Warning 
[[YFLogger logger] setLoggerLevelMask:YFLoggerLevelError | YFLoggerLevelWarning];
```

### YFLog 总开关

```objc
// 默认开启
[[YFLogger logger] setAllLogsEnable:YES];
```

### YFLog 宏

#### 快捷宏

```objc
YFError(@"YFLogLevelError");
YFWarning(@"YFLogLevelWarning");
YFInfo(@"YFLogLevelInfo");
YFDebug(@"YFLogLevelDebug");
YFVerbose(@"YFLogLevelVerbose");
```

![2016122539481WX20161225-161742@2x.png](http://7xlykq.com1.z0.glb.clouddn.com/2016122539481WX20161225-161742@2x.png)

#### 追踪方法（建议使用）

```objc
YFLogError(@"这是完整的 Log");
YFLogWarning(@"使用这一类宏，会追踪当前的方法");
YFLogDebug(@"这一类宏会打印log标志(爱心)和Log的行号+方法名");
YFLogInfo(@"后面才会显示你打印的信息")
YFLogVerbose(@"↓ 下面这个是追踪方法 (FuncTrace)");
YFLogTrace()
```

![2016122564838WX20161225-162030@2x.png](http://7xlykq.com1.z0.glb.clouddn.com/2016122564838WX20161225-162030@2x.png)

#### 高级宏

```objc
NSString *domain = @"YFTestDomain";
[YFLogger addLoggerWithDomain:domain];
YFFlagError(YES, domain, @"这是一个高级用法，可以控制是否打印方法，并且需要绑定一个 domain");
YFFlagVerbose(NO, domain, @"不打印方法和行号");
YFFlagWarning(NO, domain, @"如果 domain 没有绑定，那么使用该 domain 的 Log 信息是不会输出的");
YFFlagDebug(YES, domain, @"目前的 domain 是: %@", domain);
YFFlagInfo(YES, domain, @"下面会用一个没有注册的 domain 来测试打印 --> YFFlagVerbose(YES, @\"OtherDomain\", @\"看不到我看不到我看不到我\");");
YFFlagVerbose(YES, @"OtherDomain", @"看不到我看不到我看不到我");
YFFlagInfo(YES, domain, @"看行号，发现少了一行，因为上一个没有注册 domain 没有打印");
```

![2016122595287WX20161225-162407@2x.png](http://7xlykq.com1.z0.glb.clouddn.com/2016122595287WX20161225-162407@2x.png)

## Installation

```ruby
pod "YFLog"
```

## Author

laizw, i@laizw.cn

## License

YFLog is available under the MIT license. See the LICENSE file for more info.


