//
//  AppDelegate.m
//  TimeTest
//
//  Created by Eugene Butkevich on 8/8/16.
//  Copyright © 2016 offsiteteam. All rights reserved.
//

#import "AppDelegate.h"
#import "EBObject.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    
    //1
    NSDate* date1 = [NSDate date];
    NSLog(@"1) Now: %@", date1);
    
    //2
    NSDate* date2 = [date1 dateByAddingTimeInterval: 50000];
    NSLog(@"2.1) %@", date2);
    NSLog(@"2.2) %@", [date1 dateByAddingTimeInterval: -50000]);
    
    //3
    NSLog(@"3) Comparing: %ld",(long)[date1 compare:date2]);
    
    //4
    NSDate* date3 = [NSDate dateWithTimeIntervalSinceReferenceDate:10];
    NSLog(@"4) %@",date3);
    
    //5
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    NSLog(@"5.1) %@", [dateFormatter stringFromDate:date1]);
    
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    NSLog(@"5.2) %@", [dateFormatter stringFromDate:date1]);
    
    [dateFormatter setDateStyle:NSDateFormatterLongStyle];
    NSLog(@"5.3) %@", [dateFormatter stringFromDate:date1]);
    
    [dateFormatter setDateStyle:NSDateFormatterFullStyle];
    NSLog(@"5.4) %@", [dateFormatter stringFromDate:date1]);
    
    [dateFormatter setDateFormat:@"yyyy M MM MMM MMMMM MMMMMM"];
    NSLog(@"5.5.1) %@", [dateFormatter stringFromDate:date1]);
    
    [dateFormatter setDateFormat:@"E EE EEE EEEE EEEEE"];
    NSLog(@"5.5.2) %@", [dateFormatter stringFromDate:date1]);
    
    [dateFormatter setDateFormat:@"HH:mm hh:mm:SSS a"];
    NSLog(@"5.5.3) %@", [dateFormatter stringFromDate:date1]);
    
    [dateFormatter setDateFormat:@"W w"];               // Какая сейчас неделя месяца / года
    NSLog(@"5.5.4) %@", [dateFormatter stringFromDate:date1]);
    
    //6
    [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm:SSS"];
    NSDate* date4 = [dateFormatter dateFromString:@"2016/08/08 12:04:187"];
    NSLog(@"6) %@", date4);
    
    //7
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:[NSDate date]];
    NSInteger hour = components.hour;
    NSLog(@"7) %ld", (long) hour);
    
    //8
    NSDate* date5 = [NSDate date];
    NSDate* date6 = [NSDate dateWithTimeIntervalSinceNow:1000000];
    NSDateComponents* components2 = [calendar components:NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute fromDate:date6 toDate:date5 options:0];
    NSLog(@"8) %@", components2);
    
    //9
    EBObject* obj = [[EBObject alloc] init];    //- утечка памяти, т.к. таймер будет держать этот объект, пока мы не удалим первого методом "invalidate".
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
