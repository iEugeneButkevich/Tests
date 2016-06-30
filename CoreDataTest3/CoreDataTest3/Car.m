//
//  Car.m
//  CoreDataTest3
//
//  Created by DmitryMini on 6/30/16.
//  Copyright © 2016 offsiteteam. All rights reserved.
//

#import "Car.h"
#import "Student.h"

@implementation Car

// Insert code here to add functionality to your managed object subclass

- (BOOL)validateForDelete:(NSError * _Nullable __autoreleasing *)error {
    NSLog(@"Car validateForDelete");
    return YES;
}

@end
