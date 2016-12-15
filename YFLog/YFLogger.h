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

+ (void)setAllLogsEnable:(BOOL)enable;
+ (void)setLoggerLevelMask:(YFLoggerLevel)mask;
+ (void)addLoggerDomain:(NSString *)domain;
+ (void)removeLoggerDomain:(NSString *)domain;
+ (void)log:(YFLoggerLevel)level domain:(NSString *)domain message:(NSString *)format, ...;
+ (void)logFunc:(const char *)func line:(const int)line level:(YFLoggerLevel)level domain:(NSString *)domain message:(NSString *)format, ...;

@end
