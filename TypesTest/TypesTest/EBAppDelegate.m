//
//  EBAppDelegate.m
//  TypesTest
//
//  Created by Eugene on 6/5/16.
//  Copyright (c) 2016 Eugene. All rights reserved.
//

#import "EBAppDelegate.h"
#import "EBStudent.h"

@implementation EBAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    NSLog(@"-----TEST1-----");
    [self test1];
    NSLog(@"-----TEST2-----");
    [self test2];
    NSLog(@"-----TEST3-----");
    [self test3];
    NSLog(@"-----TEST4-----");
    [self test4];
    NSLog(@"-----TEST5-----");
    [self test5];

    return YES;
}

-(void) test1{
    BOOL boolVar = YES;
    NSInteger intVar = -10;
    NSUInteger uIntVar = 20;
    CGFloat floatVar = 2.5;
    double doubleVar = 40.7;
    
    NSLog(@"boolVar = %d, intVar = %d, uIntVar = %d, floatVar = %f, doubleVar = %f", boolVar, intVar, uIntVar, floatVar, doubleVar);
    NSLog(@"Size: boolVar = %ld, intVar = %ld, uIntVar = %ld, floatVar = %ld, doubleVar = %ld", sizeof(boolVar), sizeof(intVar), sizeof(uIntVar), sizeof(floatVar), sizeof(doubleVar));
}

-(void) test2{
    NSInteger a = 10;
    NSInteger b = a;
    b = 5;
    NSLog(@"a = %d, b = %d", a, b);
    //but:
    NSInteger* c = &a; // Pointer is creating
    *c = 20;
    NSLog(@"a = %d, b = %d", a, b);
}

-(void) test3{
    NSInteger t = 0;
    NSInteger result = [self test:55 testPointer:&t];
    
    NSLog(@"t = %d, result = %d", t, result);
    
    EBStudent* student = [[EBStudent alloc] init];
    student.gender = EBGenderMale;
}

-(NSInteger) test:(NSInteger) tt testPointer:(NSInteger*) testPointer{
    *testPointer = 7;
    return tt;
}

-(void) test4{
    //it's the most popular structures
    CGPoint point;
    point.x = 10;
    point.y = -3.5;
    //or
//    CGPoint point1 = CGPointMake(10, -3.5);
    
    CGSize size;
    size.height = 10.3;
    size.width = 5.8;
    //or
//    CGSize size1 = CGSizeMake(10.3, 5.8);
    
    CGRect rect;
    rect.origin = point;
    rect.size = size;
    //or
//    CGRect rect1 = CGRectMake(10, -3.5, 10.3, 5.8);
    
//    BOOL result = CGRectContainsPoint(rect, point);
}

-(void) test5{
    //wrapping of primitive type
    BOOL boolVar = YES;
    NSInteger intVar = -10;
    NSUInteger uIntVar = 20;
    CGFloat floatVar = 2.5;
    double doubleVar = 40.7;
    
    NSNumber* boolObject = [NSNumber numberWithBool:boolVar];
    NSNumber* intObject = [NSNumber numberWithInt:intVar];
    NSNumber* uIntObject = [NSNumber numberWithUnsignedInt:uIntVar];
    NSNumber* floatObject = [NSNumber numberWithFloat:floatVar];
    NSNumber* doubleObject = [NSNumber numberWithDouble:doubleVar];
    
    NSArray* array = [NSArray arrayWithObjects: boolObject, intObject, uIntObject, floatObject,doubleObject, nil];
    NSLog(@"boolVar = %d, intVar = %d, uIntVar = %d, floatVar = %f, doubleVar = %f",
          [[array objectAtIndex:0] boolValue],
          [[array objectAtIndex:1] integerValue],
          [[array objectAtIndex:2] unsignedIntValue],
          [[array objectAtIndex:3] floatValue],
          [[array objectAtIndex:4] doubleValue]);    
}

-(void) test6{
    // wrapping of other popular structures (point, size, rect)
    CGPoint point1 = CGPointMake(1, 5);
    CGPoint point2 = CGPointMake(3, 7);
    CGPoint point3 = CGPointMake(5, 2);
    CGPoint point4 = CGPointMake(9, 1);
    CGPoint point5 = CGPointMake(8, 6);
    
    NSArray* array = [NSArray arrayWithObjects:
                      [NSValue valueWithCGPoint:point1],
                      [NSValue valueWithCGPoint:point2],
                      [NSValue valueWithCGPoint:point3],
                      [NSValue valueWithCGPoint:point4],
                      [NSValue valueWithCGPoint:point5],
                      nil];

    for(NSValue* value in array){
        CGPoint point = [value CGPointValue];
        NSLog(@"point = %@", NSStringFromCGPoint(point));
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
