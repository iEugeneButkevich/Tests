//
//  AppDelegate.m
//  KVCTest
//
//  Created by DmitryMini on 6/28/16.
//  Copyright © 2016 offsiteteam. All rights reserved.
//

#import "AppDelegate.h"
#import "Student.h"
#import "Group.h"

@interface AppDelegate ()
@property (strong, nonatomic) Student* student;
@property (strong, nonatomic) NSArray* groups;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

/*1    Student* student = [[Student alloc] init];
    
    [student addObserver:self
                   forKeyPath:@"name"
                      options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                      context:nil];
    
    student.name = @"Alex";
    student.age = 20;
    NSLog(@"%@", student);
    
    [student setValue:@"Roger" forKey:@"name"];
    [student setValue:@25 forKey:@"age"];
    NSLog(@"%@", student);

    NSLog(@"name1 = %@, name2 = %@", student.name, [student valueForKey:@"name"]);
    
    NSLog(@"%@", student);
    
    [student changeName];
    NSLog(@"%@", student);
    
    self.student = student;
 */
    
    //2
    Student* student1 = [[Student alloc] init];
    student1.name = @"Alex";
    student1.age = 20;
    Student* student2 = [[Student alloc] init];
    student2.name = @"Roger";
    student2.age = 25;
    Student* student3 = [[Student alloc] init];
    student3.name = @"Jack";
    student3.age = 22;
    Student* student4 = [[Student alloc] init];
    student4.name = @"Vova";
    student4.age = 28;
    Group* group1 = [[Group alloc] init];
    group1.students = [NSArray arrayWithObjects:student1, student2, student3, student4, nil];
//    [group1 addObserver:self
//              forKeyPath:@"students"
//                 options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
//                 context:nil];
    NSLog(@"%@", group1.students);
    NSMutableArray* array = [group1 mutableArrayValueForKey:@"students"];   // !
    [array removeLastObject];                                               // !
    NSLog(@"students:%@, array:%@", group1.students, array);                // !!
    
    //3
    self.student = student1;
    NSLog(@"name = %@", [self valueForKeyPath:@"student.name"]);    // Можно использовать данный метод вместо "valueForKey", у него больше возможностей
    
    //4
//    NSString* name = @"Alex111";
    NSNumber* name = @6;
    NSError* error = nil;
    if (![self.student validateValue:&name forKey:@"name" error:&error]) {
        NSLog(@"!!Error: %@!!", error);
    }
    
    //5
    Student* student5 = [[Student alloc] init];
    student5.name = @"Vasya";
    student5.age = 18;
    Student* student6 = [[Student alloc] init];
    student6.name = @"Kolya";
    student6.age = 24;
    Group* group2 = [[Group alloc] init];
    group2.students = [NSArray arrayWithObjects:student5, student6, nil];
    self.groups = @[group1, group2];
    NSLog(@"Groups count %@",[self valueForKeyPath:@"groups.@count"]);
    NSArray* allStudents1 = [self valueForKeyPath:@"groups.@distinctUnionOfArrays.students"]; // равноценные строчки
    NSArray* allStudents2 = [self.groups valueForKeyPath:@"@distinctUnionOfArrays.students"]; // равноценные строчки
    NSLog(@"All students1: %@", allStudents1);
    NSLog(@"All students2: %@", allStudents2);
    
    NSNumber* minAge = [allStudents1 valueForKeyPath:@"@min.age"];
    NSNumber* maxAge = [allStudents1 valueForKeyPath:@"@max.age"];
    NSNumber* sumAge = [allStudents1 valueForKeyPath:@"@sum.age"];
    NSNumber* avgAge = [allStudents1 valueForKeyPath:@"@avg.age"];
    NSLog(@"min age: %@", minAge);
    NSLog(@"max age: %@", maxAge);
    NSLog(@"sum age: %@", sumAge);
    NSLog(@"avg age: %@", avgAge);

    NSArray* allNames = [allStudents1 valueForKeyPath:@"@distinctUnionOfObjects.name"];
    NSLog(@"All names: %@", allNames);
    
    NSLog(@"name = %@", [self.student valueForKey:@"name"]);
    return YES;
}

- (void) dealloc {
//1    [self.student removeObserver:self forKeyPath:@"name"];
}

#pragma mark - NSKeyValueObserving

- (void)observeValueForKeyPath:(nullable NSString *)keyPath
                      ofObject:(nullable id)object
                        change:(nullable NSDictionary<NSString*, id> *)change
                       context:(nullable void *)context {
    NSLog(@"\nobserveValueForKeyPath: %@ \nofObject: %@ \nchange: %@", keyPath, object, change);
}

- (void)applicationWillResignActive:(UIApplication *)application {

}

- (void)applicationDidEnterBackground:(UIApplication *)application {

}

- (void)applicationWillEnterForeground:(UIApplication *)application {

}

- (void)applicationDidBecomeActive:(UIApplication *)application {

}

- (void)applicationWillTerminate:(UIApplication *)application {
    
}

@end
