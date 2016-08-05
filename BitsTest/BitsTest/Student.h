//
//  Student.h
//  BitsTest
//
//  Created by Eugene Butkevich on 8/5/16.
//  Copyright © 2016 offsiteteam. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    StudentSubjectTypeBiology       = 1 << 0,
    StudentSubjectTypeMath          = 1 << 1,
    StudentSubjectTypeDevelopment   = 1 << 2,
    StudentSubjectTypeEngineering   = 1 << 3,
    StudentSubjectTypeArt           = 1 << 4,
    StudentSubjectTypePhycology     = 1 << 5,
    StudentSubjectTypeAnatomy       = 1 << 6
} StudentSubjectType;

@interface Student : NSObject
/*
@property(assign, nonatomic) BOOL studiesBiology;
@property(assign, nonatomic) BOOL studiesMath;
@property(assign, nonatomic) BOOL studiesDevelopment;
@property(assign, nonatomic) BOOL studiesEngineering;
@property(assign, nonatomic) BOOL studiesArt;
@property(assign, nonatomic) BOOL studiesPhycology;
@property(assign, nonatomic) BOOL studiesAnatomy;
*/

@property(assign, nonatomic) StudentSubjectType subjectType;


@end
