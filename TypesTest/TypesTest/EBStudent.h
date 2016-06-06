//
//  EBStudent.h
//  TypesTest
//
//  Created by Eugene on 6/5/16.
//  Copyright (c) 2016 Eugene. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    EBGenderMale,
    EBGenderFemale
} EBGender;

@interface EBStudent : NSObject

@property (strong, nonatomic) NSString* name;
@property (assign, nonatomic) EBGender gender;

@end
