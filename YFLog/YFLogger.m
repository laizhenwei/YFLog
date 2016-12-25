//
//  YFLogger.m
//  YFLog
//
//  Created by laizw on 2016/12/15.
//  Copyright © 2016年 laizw. All rights reserved.
//

#import "YFLogger.h"

NSString * const YFLoggerDefaultDomain = @"YFLogger";

@interface YFLogger ()
@property (nonatomic, copy) NSString *domain;
@property (nonatomic, assign) YFLoggerLevel levelMask;
@end

@implementation YFLogger

+ (void)load {
    [YFLogger addLoggerWithDomain:YFLoggerDefaultDomain];
    [[YFLogger logger] setLoggerLevelMask:YFLoggerLevelAll];
}

#pragma mark - Class Method
+ (id)loggerWithDomain:(NSString *)domain {
    return self.loggers[domain];
}

+ (instancetype)logger {
    return [self loggerWithDomain:YFLoggerDefaultDomain];
}

+ (void)addLoggerWithDomain:(NSString *)domain {
    YFLogger *logger = [self loggerWithDomain:domain];
    if (!logger) {
        logger = [[YFLogger alloc] init];
        logger.domain = domain;
        [logger setAllLogsEnable:YES];
        self.loggers[domain] = logger;
    }
}

+ (void)removeLoggerWithDomain:(NSString *)domain {
    if (self.loggers[domain]) {
        [self.loggers removeObjectForKey:domain];
    }
}

+ (void)logDomain:(NSString *)domain func:(const char *)func line:(const int)line level:(YFLoggerLevel)level message:(NSString *)format, ... {
    YFLogger *logger = [self loggerWithDomain:domain];
    if (!logger) return;
    if (!(level & logger.levelMask)) return;
    
    NSString *message;
    if (format) {
        va_list args;
        va_start(args, format);
        message = [[NSString alloc] initWithFormat:format arguments:args];
        va_end(args);
    }
    [logger logLevel:level func:func line:line message:message];
}

#pragma mark - Instance Method
- (void)setAllLogsEnable:(BOOL)enable {
    [self setLoggerLevelMask:enable ? YFLoggerLevelAll : YFLoggerLevelNone];
}

- (void)setLoggerLevelMask:(YFLoggerLevel)mask {
    self.levelMask = mask;
}

#pragma mark - Private
- (void)logLevel:(YFLoggerLevel)level func:(const char *)func line:(const int)line message:(NSString *)message {
    NSString *prefix;
    switch (level) {
        case YFLoggerLevelError:
            prefix = @"❤️";
            break;
        case YFLoggerLevelWarning:
            prefix = @"💛";
            break;
        case YFLoggerLevelDebug:
            prefix = @"💚";
            break;
        case YFLoggerLevelInfo:
            prefix = @"💙";
            break;
        case YFLoggerLevelVerbose:
            prefix = @"💜";
        default:
            break;
    }
    
    if (!message) message = @"";
    if (func) {
        fprintf(stderr, "%s %s %d %s  %s\n", [[self.formatter stringFromDate:[NSDate date]] UTF8String], prefix.UTF8String, line, func, message.UTF8String);
    } else {
        fprintf(stderr, "%s %s %s\n", [[self.formatter stringFromDate:[NSDate date]] UTF8String], prefix.UTF8String, message.UTF8String);
    }
}

#pragma mark - Getter
+ (NSMutableDictionary *)loggers {
    static NSMutableDictionary *_loggers;
    if (!_loggers) {
        _loggers = @{}.mutableCopy;
    }
    return _loggers;
}

- (NSDateFormatter *)formatter {
    static NSDateFormatter *formatter;
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"HH:mm:ss.SSSS";
    });
    return formatter;
}

@end
