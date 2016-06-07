//
//  EBAppDelegate.m
//  NotificationsTest
//
//  Created by Eugene on 6/7/16.
//  Copyright (c) 2016 EugeneButkevich. All rights reserved.
//

#import "EBAppDelegate.h"
#import "EBGovernment.h"
#import "EBDoctor.h"

@interface EBAppDelegate()

@property (strong, nonatomic) EBGovernment* government;

@end

@implementation EBAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    self.government = [[EBGovernment alloc] init];
    
    EBDoctor* doctor1 = [[EBDoctor alloc] init];
    EBDoctor* doctor2 = [[EBDoctor alloc] init];
    EBDoctor* doctor3 = [[EBDoctor alloc] init];
    EBDoctor* doctor4 = [[EBDoctor alloc] init];
    EBDoctor* doctor5 = [[EBDoctor alloc] init];

    doctor1.salary = doctor2.salary = doctor3.salary = doctor4.salary = doctor5.salary = self.government.salary;
    doctor1.averagePrice = doctor2.averagePrice = doctor3.averagePrice = doctor4.averagePrice = doctor5.averagePrice = self.government.salary;

    
    self.government.taxLevel = 7.f;
    self.government.salary = 1000;
    self.government.pension = 600;
    self.government.averagePrice = 10.f;
    
    NSLog(@"Government is changing salary:");
    self.government.salary = 1100;
    self.government.salary = 1000;
    self.government.salary = 1050;
    
    NSLog(@"Government is changing average price:");
    self.government.averagePrice = 11.f;
    self.government.averagePrice = 11.5f;
    self.government.averagePrice = 11.f;
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
