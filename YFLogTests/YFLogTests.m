//
//  YFLogTests.m
//  YFLogTests
//
//  Created by laizw on 2016/12/15.
//  Copyright © 2016年 laizw. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "YFLog.h"

@interface YFLogTests : XCTestCase

@end

@implementation YFLogTests

- (void)setUp {
    [super setUp];
//    [YFLogger setAllLogsEnable:YES];
}

- (void)tearDown {
    [super tearDown];
//    [YFLogger setAllLogsEnable:NO];
}

- (void)testLogStyle {
    YFDebug(@"↓ YFLog 有 5 个 Level，分别对应不同的颜色");
    YFError(@"YFLogLevelError");
    YFWarning(@"YFLogLevelWarning");
    YFInfo(@"YFLogLevelInfo");
    YFDebug(@"YFLogLevelDebug");
    YFVerbose(@"YFLogLevelVerbose");
    YFDebug(@"↑ ------- ↑");
}

- (void)testLogEnable {
    YFLogDebug(@"测试 Log 控制");
    YFLogVerbose(@"测试 开关 控制，默认开启");
    for (int i = 0; i < 10; i++) {
        if (i == 5) [[YFLogger logger] setAllLogsEnable:NO];
        YFInfo(@"第 %d", i);
    }
    [[YFLogger logger] setAllLogsEnable:YES];
    YFLogError(@"可以看到上面的 Log 信息中只有前 5 个，后面因为打印开关关闭而停止了 log");
}

- (void)testLogLevel {
    YFLogDebug(@"测试 Log 的 Level 控制");
    YFLogDebug(@"默认 Log 的 Level 是 YFLogLevelAll，允许输出所有 Log");
    
    for (int i = 0; i < 5; i++) {
        if (i == 1) [[YFLogger logger] setLoggerLevelMask:YFLoggerLevelNone];
        if (i == 4) [[YFLogger logger] setLoggerLevelMask:YFLoggerLevelError];
        YFError(@"第 %d", i);
    }
    
    [[YFLogger logger] setLoggerLevelMask:YFLoggerLevelAll];
    for (int i = 0; i < 5; i++) {
        if (i == 1) [[YFLogger logger] setLoggerLevelMask:YFLoggerLevelNone];
        if (i == 4) [[YFLogger logger] setLoggerLevelMask:YFLoggerLevelWarning];
        YFWarning(@"第 %d", i);
    }
    
    [[YFLogger logger] setLoggerLevelMask:YFLoggerLevelAll];
    for (int i = 0; i < 5; i++) {
        if (i == 1) [[YFLogger logger] setLoggerLevelMask:YFLoggerLevelNone];
        if (i == 4) [[YFLogger logger] setLoggerLevelMask:YFLoggerLevelDebug];
        YFDebug(@"第 %d", i);
    }
    
    [[YFLogger logger] setLoggerLevelMask:YFLoggerLevelAll];
    for (int i = 0; i < 5; i++) {
        if (i == 1) [[YFLogger logger] setLoggerLevelMask:YFLoggerLevelNone];
        if (i == 4) [[YFLogger logger] setLoggerLevelMask:YFLoggerLevelInfo];
        YFInfo(@"第 %d", i);
    }
    
    [[YFLogger logger] setLoggerLevelMask:YFLoggerLevelAll];
    for (int i = 0; i < 5; i++) {
        if (i == 1) [[YFLogger logger] setLoggerLevelMask:YFLoggerLevelNone];
        if (i == 4) [[YFLogger logger] setLoggerLevelMask:YFLoggerLevelVerbose];
        YFVerbose(@"第 %d", i);
    }
    
    [[YFLogger logger] setLoggerLevelMask:YFLoggerLevelAll];
    YFLogDebug(@"↑");
}


- (void)testQuickLog {
    YFError(@"便捷操作~");
    YFWarning(@"使用这一类宏是不会输出方法和行号");
    YFDebug(@"试一下带参 %@", @"我是参数");
    YFInfo(@"来，换一种颜色");
    YFVerbose(@"打印空字符串");
    YFWarning(@"1");
    YFWarning(@"2 打印 nil");
    YFWarning(nil);
    YFWarning(@"4 nil 看不到了");
    YFWarning(@"5 ");
}

- (void)testCompletedLog {
    YFLogError(@"这是完整的 Log");
    YFLogWarning(@"使用这一类宏，会追踪当前的方法");
    YFLogDebug(@"这一类宏会打印log标志(爱心)和Log的行号+方法名");
    YFLogInfo(@"后面才会显示你打印的信息")
    YFLogVerbose(@"↓ 下面这个是追踪方法 (FuncTrace)");
    YFLogTrace()
}

- (void)testDomainLog {
    NSString *domain = @"YFTestDomain";
    [YFLogger addLoggerWithDomain:domain];
    YFFlagError(YES, domain, @"这是一个高级用法，可以控制是否打印方法，并且需要绑定一个 domain");
    YFFlagVerbose(NO, domain, @"不打印方法和行号");
    YFFlagWarning(NO, domain, @"如果 domain 没有绑定，那么使用该 domain 的 Log 信息是不会输出的");
    YFFlagDebug(YES, domain, @"目前的 domain 是: %@", domain);
    YFFlagInfo(YES, domain, @"下面会用一个没有注册的 domain 来测试打印 --> YFFlagVerbose(YES, @\"OtherDomain\", @\"看不到我看不到我看不到我\");");
    YFFlagVerbose(YES, @"OtherDomain", @"看不到我看不到我看不到我");
    YFFlagInfo(YES, domain, @"看行号，发现少了一行，因为上一个没有注册 domain 没有打印");
}


@end
