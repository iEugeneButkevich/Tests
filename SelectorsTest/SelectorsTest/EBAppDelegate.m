//
//  EBAppDelegate.m
//  SelectorsTest
//
//  Created by Eugene on 6/7/16.
//  Copyright (c) 2016 EugeneButkevich. All rights reserved.
//

#import "EBAppDelegate.h"
#import "EBObject.h"

@implementation EBAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    SEL selector1 = @selector(testMethod);
    SEL selector2 = @selector(testMethod:);
    SEL selector3 = @selector(testMethod:parameter2:);
    
    [self performSelector:selector1];
    [self performSelector:selector2 withObject:@"testString" afterDelay:5.f];
    [self performSelector:selector3 withObject:@"testString1" withObject:@"testString2"];
    
    EBObject* obj = [[EBObject alloc] init];
    NSString* secretText = [obj performSelector:@selector(secretMethod)];
    NSLog(secretText);
    
    return YES;
}

-(void) testMethod{
    NSLog(@"testMethod is called");
}

-(void) testMethod:(NSString*) string{
    NSLog(@"testMethod with single parameter is called: %@", string);
}

-(void) testMethod:(NSString*) string1 parameter2:(NSString*) string2{
    NSLog(@"testMethod with two parameters is called: %@, %@", string1, string2);
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
