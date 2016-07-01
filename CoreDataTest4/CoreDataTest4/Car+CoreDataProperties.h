//
//  Car+CoreDataProperties.h
//  CoreDataTest3
//
//  Created by DmitryMini on 6/30/16.
//  Copyright © 2016 offsiteteam. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Car.h"

NS_ASSUME_NONNULL_BEGIN

@interface Car (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *model;
@property (nullable, nonatomic, retain) Student *owner;

@end

NS_ASSUME_NONNULL_END
