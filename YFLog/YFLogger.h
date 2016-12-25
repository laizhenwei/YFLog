//
//  YFLogger.h
//  YFLog
//
//  Created by laizw on 2016/12/15.
//  Copyright © 2016年 laizw. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const YFLoggerDefaultDomain;

typedef enum : NSUInteger {
    YFLoggerLevelNone    = 0,
    YFLoggerLevelError   = 1,      // ❤️
    YFLoggerLevelWarning = 1 << 1, // 💛
    YFLoggerLevelDebug   = 1 << 2, // 💚
    YFLoggerLevelInfo    = 1 << 3, // 💙
    YFLoggerLevelVerbose = 1 << 4, // 💜
    YFLoggerLevelAll     = NSUIntegerMax,
} YFLoggerLevel;

@interface YFLogger : NSObject

/**
 快速获取一个单例（DefaultDomain）

 @return logger 单例
 */
+ (instancetype)logger;

+ (id)loggerWithDomain:(NSString *)domain;

+ (void)addLoggerWithDomain:(NSString *)domain;

+ (void)removeLoggerWithDomain:(NSString *)domain;

+ (void)logDomain:(NSString *)domain func:(const char *)func line:(const int)line level:(YFLoggerLevel)level message:(NSString *)format, ...;

- (void)setAllLogsEnable:(BOOL)enable;

- (void)setLoggerLevelMask:(YFLoggerLevel)mask;

@end
