//
//  Student.m
//  CoreDataTest3
//
//  Created by DmitryMini on 6/30/16.
//  Copyright © 2016 offsiteteam. All rights reserved.
//

#import "Student.h"
#import "Car.h"
#import "Course.h"
#import "University.h"

@implementation Student

// Insert code here to add functionality to your managed object subclass

- (BOOL)validateForDelete:(NSError * _Nullable __autoreleasing *)error {
    NSLog(@"Student validateForDelete");
    return YES;
}

@end
