//
//  EBAppDelegate.m
//  BlocksTest
//
//  Created by Eugene on 6/7/16.
//  Copyright (c) 2016 EugeneButkevich. All rights reserved.
//

#import "EBAppDelegate.h"
#import "EBObject.h"

typedef void (^OurTestBlock1) (void);

@interface EBAppDelegate()
@property (copy, nonatomic) OurTestBlock1 testBlock;
@end

@implementation EBAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    //1 example
    void (^testBlock)(void);
    testBlock = ^{
        NSLog(@"test block");
    };
    testBlock();
    testBlock();
    testBlock();
    
    //2 example
    void (^testBlockWithParams)(NSString*, NSInteger) = ^(NSString* string, NSInteger intValue) {
        NSLog(@"testBlockWithParams: %@, %d", string, intValue);
    };
    testBlockWithParams(@"str1",14);
    testBlockWithParams(@"str2",5);
    
    //3 example
    NSString* (^testBlockWithParamsAndReturnValue)(NSString*, NSInteger) = ^(NSString* string, NSInteger intValue) {
        return [NSString stringWithFormat:@"%@, %d", string, intValue];
    };
    NSString* result = testBlockWithParamsAndReturnValue(@"str3", 55);
    NSLog(@"result of testBlockWithParamsAndReturnValue = %@",result);
    
    //4 example
    __block NSString* testString = @"Is it possible??";                     // __block
    __block NSInteger i = 0;                                                // __block
    void (^testBlock2)(void);
    testBlock2 = ^{
        NSLog(@"test block2");
        i++;
        testString = [NSString stringWithFormat:@"It's possible! %d",i];    // "i" is changed
        NSLog(@"testString = %@", testString);
    };
    testBlock2();
    testBlock2();

    //5 example
    [self testBlocksMethod:^{
        NSLog(@"BLOCK!");
    }];
    
    //6 exaple
    EBObject* obj = [[EBObject alloc] init];
    obj.name = @"OBJECT";
    __weak EBObject* weakObj = obj;                                         //!!!
    self.testBlock = ^{
//        NSLog(@"obj: name = %@",obj.name);                              // EBObject wo't be deallocated
        NSLog(@"weakObj: name = %@",weakObj.name);                          // EBObject will be deallocated

    };
    self.testBlock();
    
    return YES;
}

-(void) testBlocksMethod:(OurTestBlock1) testBlock{                         // block as parameter
    NSLog(@"testBlocksMethod");
    testBlock();
    testBlock();
    testBlock();
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
