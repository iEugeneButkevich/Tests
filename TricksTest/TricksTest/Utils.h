//
//  Utils.h
//  TricksTest
//
//  Created by Eugene Butkevich on 8/3/16.
//  Copyright © 2016 offsiteteam. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    ProgrammerTypeJunior,
    ProgrammerTypeMid,
    ProgrammerTypeSenior
} ProgrammerType;

#define APP_SHORT_NAME @"TRICKS"
#define PRODUCTION_BUILD
#define RGB(r,g,b,a) [UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:a/255.f]
//#define LOGS_ENABLED 1  // 1 is enabled, 0 is disabled       <- закомментили, т.к. прописали это в препроцессоре
#define LOGS_NOTIFICATIONS_ENABLED 1

extern NSString* const EBLogNotification;
extern NSString* const EBLogNotificationTextUserInfoKey;

NSString* fancyDateStringFromDate(NSDate* date);

BOOL iPad();
BOOL iPhone();

NSString* NSStringFromProgrammerType(ProgrammerType type);

void EBLog(NSString* format, ...);