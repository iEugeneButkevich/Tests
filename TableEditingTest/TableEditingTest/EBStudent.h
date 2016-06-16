//
//  EBStudent.h
//  TableEditingTest
//
//  Created by Eugene on 6/15/16.
//  Copyright (c) 2016 EugeneButkevich. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EBStudent : NSObject

@property (strong, nonatomic) NSString* firstName;
@property (strong, nonatomic) NSString* lastName;
@property (assign, nonatomic) CGFloat averageGrade;

+(EBStudent*) randomStudent;

@end
