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

/**
 根据 domain 获取一个 logger
 
 @param domain domain
 @return logger
 */
+ (id)loggerWithDomain:(NSString *)domain;

/**
 添加一个 logger，每个 logger 绑定一个 domain

 @param domain domain
 */
+ (void)addLoggerWithDomain:(NSString *)domain;

/**
 根据 domain 删除一个 logger

 @param domain domain
 */
+ (void)removeLoggerWithDomain:(NSString *)domain;

/**
 打印

 @param domain domain
 @param func 方法 __func__
 @param line 行号 __LINE__
 @param level YFLoggerLevel
 @param format 打印信息
 */
+ (void)logDomain:(NSString *)domain func:(const char *)func line:(const int)line level:(YFLoggerLevel)level message:(NSString *)format, ...;

/**
 开启打印，默认开启

 @param enable enable
 */
- (void)setAllLogsEnable:(BOOL)enable;

/**
 设置 log 等级

 @param mask YFLoggerLevel
 */
- (void)setLoggerLevelMask:(YFLoggerLevel)mask;

@end
