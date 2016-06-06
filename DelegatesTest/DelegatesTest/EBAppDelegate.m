//
//  EBAppDelegate.m
//  DelegatesTest
//
//  Created by Eugene on 6/6/16.
//  Copyright (c) 2016 EugeneButkevich. All rights reserved.
//

#import "EBAppDelegate.h"
#import "EBPatient.h"
#import "EBDoctor.h"

@implementation EBAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    EBPatient* patient1 = [[EBPatient alloc] init];
    patient1.name = @"Vasya";
    patient1.temperature = 37.5f;
    
    EBPatient* patient2 = [[EBPatient alloc] init];
    patient2.name = @"Petya";
    patient2.temperature = 36.7f;
    
    EBPatient* patient3 = [[EBPatient alloc] init];
    patient3.name = @"Oleg";
    patient3.temperature = 38.3f;
    
    EBPatient* patient4 = [[EBPatient alloc] init];
    patient4.name = @"Dima";
    patient4.temperature = 40.f;
    
    EBDoctor* doctor = [[EBDoctor alloc] init];
    
    patient1.delegate = doctor;
    patient2.delegate = doctor;
    patient3.delegate = doctor;
    patient4.delegate = doctor;
    
    NSLog(@"%@ are you ok?", patient1.name);
    [patient1 howAreYou];
    NSLog(@"%@ are you ok?", patient2.name);
    [patient2 howAreYou];
    NSLog(@"%@ are you ok?", patient3.name);
    [patient3 howAreYou];
    NSLog(@"%@ are you ok?", patient4.name);
    [patient4 howAreYou];


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
