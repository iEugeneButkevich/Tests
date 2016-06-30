//
//  Student+CoreDataProperties.h
//  CoreDataTest2
//
//  Created by DmitryMini on 6/30/16.
//  Copyright © 2016 offsiteteam. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Student.h"
#import "University.h"

NS_ASSUME_NONNULL_BEGIN

@interface Student (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *firstName;
@property (nullable, nonatomic, retain) NSString *lastName;
@property (nullable, nonatomic, retain) NSNumber *score;
@property (nullable, nonatomic, retain) NSDate *dateOfBirth;
@property (nullable, nonatomic, retain) Car *car;
@property (nullable, nonatomic, retain) University *university;

@end

NS_ASSUME_NONNULL_END
