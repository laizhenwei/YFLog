//
//  YFLogger.m
//  YFLog
//
//  Created by laizw on 2016/12/15.
//  Copyright © 2016年 laizw. All rights reserved.
//

#import "YFLogger.h"

NSString * const YFLoggerDefaultDomain = @"YFLogger";

static YFLoggerLevel levelMask;

@implementation YFLogger

+ (void)load {
#if DEBUG
    [self setAllLogsEnable:YES];
#else
    [self setAllLogsEnable:NO];
#endif
}

+ (void)setAllLogsEnable:(BOOL)enable {
    [self setLoggerLevelMask:enable ? YFLoggerLevelAll : YFLoggerLevelNone];
}

+ (void)setLoggerLevelMask:(YFLoggerLevel)mask {
    levelMask = mask;
}

+ (void)addLoggerDomain:(NSString *)domain {
    [self.domains addObject:domain];
}

+ (void)removeLoggerDomain:(NSString *)domain {
    [self.domains removeObject:domain];
}

+ (void)log:(YFLoggerLevel)level domain:(NSString *)domain message:(NSString *)format, ... {
    NSString *message;
    if (format.length > 0) {
        va_list args;
        va_start(args, format);
        message = [[NSString alloc] initWithFormat:format arguments:args];
        va_end(args);
    }
    [self logFunc:nil level:level domain:domain message:message];
}

+ (void)logFunc:(const char *)func line:(const int)line level:(YFLoggerLevel)level domain:(NSString *)domain message:(NSString *)format, ... {
    NSString *funcInfo = [NSString stringWithFormat:@"%d %s", line, func];
    NSString *message;
    if (format.length > 0) {
        va_list args;
        va_start(args, format);
        message = [[NSString alloc] initWithFormat:format arguments:args];
        va_end(args);
    }
    [self logFunc:funcInfo level:level domain:domain message:message];
}

+ (void)logFunc:(NSString *)func level:(YFLoggerLevel)level domain:(NSString *)domain message:(NSString *)message {
    if (domain.length <= 0 || ![self.domains containsObject:domain]) return;
    if (level & levelMask) {
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
        if (func) {
            NSLog(@"%@ %@", prefix, func);
        }
        if (message) {
            NSLog(@"%@ %@", func ? @"  " : prefix, message);
        }
    }
}

+ (NSMutableSet *)domains {
    static NSMutableSet *domains;
    if (!domains) {
        domains = [NSMutableSet setWithObject:YFLoggerDefaultDomain];
    }
    return domains;
}

@end
