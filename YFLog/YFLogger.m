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

+ (void)logFunc:(const char *)func line:(const int)line level:(YFLoggerLevel)level domain:(NSString *)domain message:(NSString *)format, ... {
    if (domain.length <= 0 || ![self.domains containsObject:domain]) return;
    if (level & levelMask) {
        NSString *prefix = @"💜";
        switch (level) {
            case YFLoggerLevelVerbose:
                prefix = @"💙";
                break;
            case YFLoggerLevelWarning:
                prefix = @"💛";
                break;
            case YFLoggerLevelError:
                prefix = @"❤️";
                break;
            default:
                break;
        }
        va_list args;
        va_start(args, format);
        NSString *message = [[NSString alloc] initWithFormat:format arguments:args];
        va_end(args);
        NSLog(@"%@ %d %s %@", prefix, line, func, message);
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
