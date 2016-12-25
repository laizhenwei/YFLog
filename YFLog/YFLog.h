//
//  YFLog.h
//  YFLog
//
//  Created by laizw on 2016/12/15.
//  Copyright © 2016年 laizw. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for YFLog.
FOUNDATION_EXPORT double YFLogVersionNumber;

//! Project version string for YFLog.
FOUNDATION_EXPORT const unsigned char YFLogVersionString[];

#import "YFLogger.h"

#define YFLoggerExec(__flag__, __domain__, __level__, __frmt__, ...) \
[YFLogger logDomain:__domain__ func:__flag__ ? __func__ : NULL line:__LINE__ level:__level__ message:__frmt__, ##__VA_ARGS__];

#define YFFlagInfo(flag, __domain__, frmt, ...)    YFLoggerExec(flag, __domain__, YFLoggerLevelInfo, frmt, ##__VA_ARGS__)
#define YFFlagError(flag, __domain__, frmt, ...)   YFLoggerExec(flag, __domain__, YFLoggerLevelError, frmt, ##__VA_ARGS__)
#define YFFlagDebug(flag, __domain__, frmt, ...)   YFLoggerExec(flag, __domain__, YFLoggerLevelDebug, frmt, ##__VA_ARGS__)
#define YFFlagWarning(flag, __domain__, frmt, ...) YFLoggerExec(flag, __domain__, YFLoggerLevelWarning, frmt, ##__VA_ARGS__)
#define YFFlagVerbose(flag, __domain__, frmt, ...) YFLoggerExec(flag, __domain__, YFLoggerLevelVerbose, frmt, ##__VA_ARGS__)

#define YFInfo(frmt, ...)    YFFlagInfo(NO, YFLoggerDefaultDomain, frmt, ##__VA_ARGS__)
#define YFError(frmt, ...)   YFFlagError(NO, YFLoggerDefaultDomain, frmt, ##__VA_ARGS__)
#define YFDebug(frmt, ...)   YFFlagDebug(NO, YFLoggerDefaultDomain, frmt, ##__VA_ARGS__)
#define YFWarning(frmt, ...) YFFlagWarning(NO, YFLoggerDefaultDomain, frmt, ##__VA_ARGS__)
#define YFVerbose(frmt, ...) YFFlagVerbose(NO, YFLoggerDefaultDomain, frmt, ##__VA_ARGS__)

#define YFLogInfo(frmt, ...)    YFFlagInfo(YES, YFLoggerDefaultDomain, frmt, ##__VA_ARGS__)
#define YFLogError(frmt, ...)   YFFlagError(YES, YFLoggerDefaultDomain, frmt, ##__VA_ARGS__)
#define YFLogDebug(frmt, ...)   YFFlagDebug(YES, YFLoggerDefaultDomain, frmt, ##__VA_ARGS__)
#define YFLogWarning(frmt, ...) YFFlagWarning(YES, YFLoggerDefaultDomain, frmt, ##__VA_ARGS__)
#define YFLogVerbose(frmt, ...) YFFlagVerbose(YES, YFLoggerDefaultDomain, frmt, ##__VA_ARGS__)
#define YFLogTrace()            YFFlagVerbose(YES, YFLoggerDefaultDomain, nil)

