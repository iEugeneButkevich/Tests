//
//  EBAppDelegate.m
//  ThreadsTest
//
//  Created by Eugene on 6/8/16.
//  Copyright (c) 2016 EugeneButkevich. All rights reserved.
//

#import "EBAppDelegate.h"

@interface EBAppDelegate()
@property (strong, nonatomic) NSMutableArray* array;
@end

@implementation EBAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    //1
//    [self performSelectorInBackground:@selector(testThread1) withObject:nil];
    
    //2
//    NSThread* thread = [[NSThread alloc] init];
//    [thread start];
    
//    BOOL isMainThread = [[NSThread currentThread] isMainThread];
    
    //3 Creating 10 threads
//    for (int i = 0; i < 10; i++) {
//        NSThread* thread = [[NSThread alloc] initWithTarget:self selector:@selector(testThread2) object:nil];
//        thread.name = [NSString stringWithFormat:@"Thread #%d", i+1];
//        [thread start];
//    }
    
    //4
//    self.array = [NSMutableArray array];
//    NSThread* thread1 = [[NSThread alloc] initWithTarget:self selector:@selector(addStringToArray1:) object:@"X"];
//    NSThread* thread2 = [[NSThread alloc] initWithTarget:self selector:@selector(addStringToArray1:) object:@"0"];
//    thread1.name = @"Thread #1";
//    thread2.name = @"Thread #2";
//    [thread1 start];
//    [thread2 start];
//    [self performSelector:@selector(printArray) withObject:nil afterDelay:5];
    
    //5 GRAND CENTRAL DISPATCH. It's an easier way for working with threads
    
    self.array = [NSMutableArray array];
    dispatch_queue_t queue = dispatch_queue_create("by.eugenebutkevich.threadstest.queue", DISPATCH_QUEUE_SERIAL);
    __weak id weakSelf = self;
    dispatch_async(queue, ^{
        [weakSelf addStringToArray2:@"0"];
    });
    dispatch_async(queue, ^{
        [weakSelf addStringToArray2:@"X"];
    });
    [self performSelector:@selector(printArray) withObject:nil afterDelay:3];
    
    return YES;
}

-(void) testThread1{
    @autoreleasepool {
        for (int i = 0; i < 10000; i++) {
            NSLog(@"%d",i);
        }
    }
}

-(void) testThread2{
    @autoreleasepool {
        NSLog(@"%@ started", [[NSThread currentThread] name]);
        for (int i = 0; i < 200000000; i++) {
        }
        NSLog(@"%@ finished", [[NSThread currentThread] name]);
    }
}

-(void) addStringToArray1:(NSString*) string{
    @autoreleasepool {
        NSLog(@"%@ started", [[NSThread currentThread] name]);
        @synchronized(self){
            for (int i = 0; i < 200000; i++) {
                [self.array addObject:string];
            }
        }
        NSLog(@"%@ finished", [[NSThread currentThread] name]);
    }
}

-(void) addStringToArray2:(NSString*) string{
    NSLog(@"started");
    for (int i = 0; i < 200000; i++) {
        [self.array addObject:string];
    }
    NSLog(@"finished");
}

-(void) printArray{
    NSLog(@"%@", self.array);
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
