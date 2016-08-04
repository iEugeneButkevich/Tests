//
//  Utils.m
//  TricksTest
//
//  Created by Eugene Butkevich on 8/3/16.
//  Copyright © 2016 offsiteteam. All rights reserved.
//

#import "Utils.h"
#import <UIKit/UIKit.h>

NSString* const EBLogNotification = @"by.butkevich.EBLogNotification";
NSString* const EBLogNotificationTextUserInfoKey = @"by.butkevich.EBLogNotificationTextUserInfoKey";

NSString* fancyDateStringFromDate(NSDate* date) {
    static NSDateFormatter* formatter = nil;
    if (!formatter) {
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"-- dd : MM : yyyy --"];
    }
    return [formatter stringFromDate:date];
}

BOOL iPad() {
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
}

BOOL iPhone() {
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone);
}

NSString* NSStringFromProgrammerType(ProgrammerType type) {
    switch (type) {
        case ProgrammerTypeJunior:  return @"ProgrammerTypeJunior";
        case ProgrammerTypeMid:     return @"ProgrammerTypeMid";
        case ProgrammerTypeSenior:  return @"ProgrammerTypeSenior";
        default:                    break;
    }
}

void EBLog(NSString* format, ...) {
#if LOGS_ENABLED
    va_list argumentList;
    va_start(argumentList, format);
    NSLogv(format, argumentList);
#if LOGS_NOTIFICATIONS_ENABLED
    NSString* log = [[NSString alloc] initWithFormat:format arguments:argumentList];
    [[NSNotificationCenter defaultCenter] postNotificationName:EBLogNotification
                                                        object:nil
                                                      userInfo:@{EBLogNotificationTextUserInfoKey: log}];
#endif
    va_end(argumentList);
#endif
}