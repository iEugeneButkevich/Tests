//
//  AppDelegate.m
//  CoreDataTest
//
//  Created by DmitryMini on 6/29/16.
//  Copyright © 2016 offsiteteam. All rights reserved.
//

#import "AppDelegate.h"
#import "Student.h"
#import "Car.h"
#import "University.h"
#import "Course.h"

@interface AppDelegate ()

@end

static NSString* firstNames[] = {@"Leo", @"John", @"Eden", @"Roberto", @"Branislav",};
static NSString* lastNames[] = {@"Messi", @"Terry", @"Hazard", @"Firmino", @"Ivanovich",};
static NSString* carModelNames[] = {@"Bugatti", @"Audi", @"Citroen", @"Toyota", @"BMW",};

@implementation AppDelegate

- (Student*) addRandomStudent {
    Student* student = [NSEntityDescription insertNewObjectForEntityForName:@"Student"
                                                     inManagedObjectContext:self.managedObjectContext];
    student.score = @((float)(arc4random_uniform(200)) / 100.f + 2);
    student.dateOfBirth = [NSDate dateWithTimeIntervalSince1970:60*60*24*365*arc4random_uniform(31)];
    student.firstName = firstNames[arc4random_uniform(5)];
    student.lastName = lastNames[arc4random_uniform(5)];
    return student;
}

- (Car*) addRandomCar {
    Car* car = [NSEntityDescription insertNewObjectForEntityForName:@"Car"
                                                     inManagedObjectContext:self.managedObjectContext];
    car.model = carModelNames[arc4random_uniform(5)];
    return car;
}

- (University*) addUniversity {
    University* university = [NSEntityDescription insertNewObjectForEntityForName:@"University"
                                             inManagedObjectContext:self.managedObjectContext];
    university.name = @"BNTU";
    return university;
}

- (Course*) addCourseWithName:(NSString*) name {
    Course* course = [NSEntityDescription insertNewObjectForEntityForName:@"Course"
                                                           inManagedObjectContext:self.managedObjectContext];
    course.name = name;
    return course;
}

- (NSArray*) allObjects {
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    NSEntityDescription* description = [NSEntityDescription entityForName:@"EBObject"
                                                   inManagedObjectContext:self.managedObjectContext];
    [request setEntity:description];
    NSError* requestError = nil;
    NSArray* resultArray = [self.managedObjectContext executeFetchRequest:request error:&requestError];
    if (requestError) {
        NSLog(@"%@", [requestError localizedDescription]);
    }
    return resultArray;
}

- (void) printArray:(NSArray*) array {
     for (id obj in array) {
        if ([obj isKindOfClass:[Car class]]) {
            Car* car = (Car*) obj;
            NSLog(@"CAR: %@, OWNER: %@ %@", car.model, car.owner.firstName, car.owner.lastName);
        } else if ([obj isKindOfClass:[Student class]]) {
            Student* student = (Student*) obj;
            NSLog(@"STUDENT: %@ %@, SCORE: %1.2f, COURSES: %lu", student.firstName, student.lastName, [student.score floatValue], [student.courses count]);
        } else if ([obj isKindOfClass:[University class]]) {
            University* university = (University*) obj;
            NSLog(@"UNIVERSITY: %@ , STUDENTS COUNT: %lu", university.name, [university.students count]);
        } else if ([obj isKindOfClass:[Course class]]) {
            Course* course = (Course*) obj;
            NSLog(@"COURSE: %@ , STUDENTS COUNT: %lu", course.name, [course.students count]);
        }
    }
}

- (void) printAllObjects {
    NSArray* allObjects = [self allObjects];
    [self printArray:allObjects];
}

- (void) deleteFirstStudent {
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    NSEntityDescription* description = [NSEntityDescription entityForName:@"Student"
                                                   inManagedObjectContext:self.managedObjectContext];
    [request setEntity:description];
    NSError* requestError = nil;
    NSArray* resultArray = [self.managedObjectContext executeFetchRequest:request error:&requestError];
    if ([resultArray count] > 0) {
        Student* student = [resultArray firstObject];
        NSLog(@"Student to delete: %@", student);
        [self.managedObjectContext deleteObject:student];
        [self.managedObjectContext save:nil];
    }
}

- (void) deleteFirstCar {
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    NSEntityDescription* description = [NSEntityDescription entityForName:@"Car"
                                                   inManagedObjectContext:self.managedObjectContext];
    [request setEntity:description];
    NSError* requestError = nil;
    NSArray* resultArray = [self.managedObjectContext executeFetchRequest:request error:&requestError];
    if ([resultArray count] > 0) {
        Car* car = [resultArray firstObject];
        NSLog(@"Car to delete, model: %@, owner:%@ %@", car.model, car.owner.firstName, car.owner.lastName);
        [self.managedObjectContext deleteObject:car];
        [self.managedObjectContext save:nil];
    }
}

- (void) deleteUniversity {
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    NSEntityDescription* description = [NSEntityDescription entityForName:@"University"
                                                   inManagedObjectContext:self.managedObjectContext];
    [request setEntity:description];
    NSError* requestError = nil;
    NSArray* resultArray = [self.managedObjectContext executeFetchRequest:request error:&requestError];
    if ([resultArray count] > 0) {
        University* university = [resultArray firstObject];
        NSLog(@"University to delete!!");
        [self.managedObjectContext deleteObject:university];
        [self.managedObjectContext save:nil];
    }
}

- (void) deleteAllObjects {
    NSArray* allObjects = [self allObjects];
    for (id obj in allObjects) {
        [self.managedObjectContext deleteObject: obj];
    }
    [self.managedObjectContext save:nil];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [self deleteAllObjects];
    
    NSError* error = nil;
    NSArray* courses = @[[self addCourseWithName:@"iOs"],
                         [self addCourseWithName:@"Android"],
                         [self addCourseWithName:@"PHP"],
                         [self addCourseWithName:@"Javascript"],
                         [self addCourseWithName:@"HTML"]];
    University* university = [self addUniversity];
    [university addCourses:[NSSet setWithArray:courses]];
    for (int i = 0; i < 100; i++) {
        Student* student = [self addRandomStudent];
        if (arc4random_uniform(1000) < 500) {
            Car* car = [self addRandomCar];
            student.car = car;
        }
        NSInteger number = arc4random_uniform(5) + 1;
        while ([student.courses count] < number) {
            Course* course = [courses objectAtIndex:arc4random_uniform(5)];
            if (![student.courses containsObject:course]) {
                [student addCoursesObject:course];
            }
        }
        [university addStudentsObject:student];
    }
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"%@", [error localizedDescription]);
    }
  
//    [self workWithStudent];
//    [self workWithCourse];

//    [self workWithFetchRequestCreatedInModel];
    
    [self workWithFetchedProperty];
   
/*    [self printAllObjects];
    [self deleteUniversity];
    [self printAllObjects];
*/

/*    [self printAllObjects];
    [self deleteFirstStudent];
    [self deleteFirstCar];
    [self printAllObjects];
*/
    
    return YES;
}

- (void) workWithStudent {
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    NSEntityDescription* description = [NSEntityDescription entityForName:@"Student"
                                                   inManagedObjectContext:self.managedObjectContext];
    [request setEntity:description];
    //    [request setFetchBatchSize:20];     // Загружается с БД по 20 объектов.
    //    [request setFetchLimit:35];         // Всего загрузится с БД 35 объектов
    //    [request setFetchOffset:10];        // Объекты будут загружаться, начиная с 10го
    [request setRelationshipKeyPathsForPrefetching:@[@"courses"]];    // Предзагрузка всех курсов. Если это не использовать, то курс будет загружаться непосредственно во время обращения к нему как к полю студента
    NSSortDescriptor* firstNameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"firstName" ascending:YES];
    NSSortDescriptor* lastNameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"lastName" ascending:YES];
    [request setSortDescriptors:@[firstNameDescriptor, lastNameDescriptor]];
    NSArray* validNames = @[@"Eden", @"Leo", @"Roberto"];
    NSPredicate* predicate = [NSPredicate predicateWithFormat:
                               @"score > %f AND score <= 3.5 AND "
                               "courses.@count >= 3 AND firstName IN %@", 3.0, validNames];
    [request setPredicate:predicate];
    NSError* requestError = nil;
    NSArray* resultArray = [self.managedObjectContext executeFetchRequest:request error:&requestError];
    
    [self printArray:resultArray];
    NSLog(@"COUNT = %lu", (unsigned long)[resultArray count]);
}

- (void) workWithCourse {
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    NSEntityDescription* description = [NSEntityDescription entityForName:@"Course"
                                                   inManagedObjectContext:self.managedObjectContext];
    [request setEntity:description];
    NSSortDescriptor* nameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    [request setSortDescriptors:@[nameDescriptor]];
//    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"@avg.students.score > %f", 3.0];
//    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"@sum.students.score > %f", 190.f];
    NSPredicate* predicate = [NSPredicate predicateWithFormat:
                              @"SUBQUERY(students, $student, $student.car.model == %@).@count >= %d", @"BMW", 10];
    [request setPredicate:predicate];
    NSError* requestError = nil;
    NSArray* resultArray = [self.managedObjectContext executeFetchRequest:request error:&requestError];
    
    [self printArray:resultArray];
    NSLog(@"COUNT = %lu", (unsigned long)[resultArray count]);
}

- (void) workWithFetchRequestCreatedInModel {
    // Можно использовать FetchRequest, созданный в модели (юзать, когда часто нужен один и тот же request):
    //    NSFetchRequest* request = [self.managedObjectModel fetchRequestTemplateForName:@"FetchStudents"];
    
    // Чтобы добавить дескрипторы к такому request необходимо его скопировать, т.е.:
    NSFetchRequest* request = [[self.managedObjectModel fetchRequestTemplateForName:@"FetchStudents"] copy];
    NSSortDescriptor* firstNameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"firstName" ascending:YES];
    NSSortDescriptor* lastNameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"lastName" ascending:YES];
    [request setSortDescriptors:@[firstNameDescriptor, lastNameDescriptor]];
    NSArray* resultArray = [self.managedObjectContext executeFetchRequest:request error:nil];
    [self printArray:resultArray];
}

- (void) workWithFetchedProperty {
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    NSEntityDescription* description = [NSEntityDescription entityForName:@"Course"
                                                   inManagedObjectContext:self.managedObjectContext];
    [request setEntity:description];
    NSArray* resultArray = [self.managedObjectContext executeFetchRequest:request error:nil];
    for (Course* course in resultArray) {
        NSLog(@"COURSE NAME = %@", course.name);
        NSLog(@"BEST STUDENTS: ");
        [self printArray:course.bestStudents];
        NSLog(@"BUSY STUDENTS: ");
        [self printArray:course.studentsWithManyCourses];
    }
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
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.offsiteteam.CoreDataTest" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"CoreDataTest3" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"CoreDataTest.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        
        //        [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil];
        //        [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error];
        
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
