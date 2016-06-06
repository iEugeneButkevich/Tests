//
//  EBAppDelegate.m
//  TestOfArrays
//
//  Created by Eugene on 6/5/16.
//  Copyright (c) 2016 Eugene. All rights reserved.
//

#import "EBAppDelegate.h"
#import "EBObject.h"
#import "EBChild.h"

@implementation EBAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [self test1];
    [self test2];
    
    return YES;
}

-(void) test1{
    //    NSArray* array = [[NSArray alloc] initWithObjects:@"str1", @"str2", @"str3", nil];
    //    NSArray* array = [NSArray arrayWithObjects:@"str1", @"str2", @"str3", nil]; //It's the same as the previous row
    NSArray* array = @[@"str1", @"str2", @"str3"]; //It's the same as the previous row
    
    
    //    for (int i = 0; i<[array count]; i++) {
    //        NSLog(@"index = %d", i);
    //        NSLog(@"%@",[array objectAtIndex:i]);
    //    }
    
    for(NSString* string in array){
        NSLog(@"index = %d", [array indexOfObject:string]);
        NSLog(@"%@",string);
    }
}

-(void) test2{
    EBObject* obj1 = [[EBObject alloc] init];
    EBObject* obj2 = [[EBObject alloc] init];
    EBChild* obj3 = [[EBChild alloc] init];
    
    obj1.name = @"name1";
    obj2.name = @"name2";
    obj3.name = @"name3";
    obj3.lastName = @"LastName";

    NSArray* array = [NSArray arrayWithObjects: obj1, obj2, obj3, nil];

    for(EBObject* obj in array){
        NSLog(@"name of object №%d is %@", [array indexOfObject:obj]+1, obj.name);
        [obj action];
        
        if ([obj isKindOfClass:[EBChild class]]) {
            EBChild* child = (EBChild*) obj;
            NSLog(@"last name = %@", child.lastName);
        }
    }

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
