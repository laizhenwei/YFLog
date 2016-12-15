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

// In this header, you should import all the public headers of your framework using statements like #import <YFLog/PublicHeader.h>
#import "YFLogger.h"

#define YFLoggerExec(__domain__, __level__, ...) \
[YFLogger logFunc:__func__ line:__LINE__ level:__level__ domain:__domain__ message:__VA_ARGS__];

#define YFLogVerbose(__domain__, ...) YFLoggerExec(__domain__, YFLoggerLevelVerbose, __VA_ARGS__)
#define YFLogWarning(__domain__, ...) YFLoggerExec(__domain__, YFLoggerLevelWarning, __VA_ARGS__)
#define YFLogError(__domain__, ...)   YFLoggerExec(__domain__, YFLoggerLevelError, __VA_ARGS__)

#define YFVerbose(...) YFLogVerbose(YFLoggerDefaultDomain, __VA_ARGS__)
#define YFWarning(...) YFLogVerbose(YFLoggerDefaultDomain, __VA_ARGS__)
#define YFError(...)   YFLogVerbose(YFLoggerDefaultDomain, __VA_ARGS__)
