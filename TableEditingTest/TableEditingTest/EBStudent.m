//
//  EBStudent.m
//  TableEditingTest
//
//  Created by Eugene on 6/15/16.
//  Copyright (c) 2016 EugeneButkevich. All rights reserved.
//

#import "EBStudent.h"

@implementation EBStudent

static NSString* firstNames[] = {@"Leo", @"John", @"Eden", @"Roberto", @"Branislav",};
static NSString* lastNames[] = {@"Messi", @"Terry", @"Hazard", @"Firmino", @"Ivanovich",};

static int namesCount = 5;

+(EBStudent*) randomStudent{
    EBStudent* student = [[EBStudent alloc] init];
    student.firstName = firstNames[arc4random() % namesCount];
    student.lastName = lastNames[arc4random() % namesCount];
    student.averageGrade = ((CGFloat)(arc4random() % 301 + 200)) / 100;
    return student;
}

@end
