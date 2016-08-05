//
//  Student.m
//  BitsTest
//
//  Created by Eugene Butkevich on 8/5/16.
//  Copyright © 2016 offsiteteam. All rights reserved.
//

#import "Student.h"

@implementation Student

/*
 - (NSString *)description {
    return [NSString stringWithFormat:  @"Student studies:\n"
                                        "biology = %@\n"
                                        "math = %@\n"
                                        "development = %@\n"
                                        "engineering = %@\n"
                                        "art = %@\n"
                                        "phycology = %@\n"
                                        "anatomy = %@\n",
                                        self.studiesBiology ? @"yes" : @"no" ,
                                        self.studiesMath ? @"yes" : @"no" ,
                                        self.studiesDevelopment ? @"yes" : @"no" ,
                                        self.studiesEngineering ? @"yes" : @"no" ,
                                        self.studiesArt ? @"yes" : @"no" ,
                                        self.studiesPhycology ? @"yes" : @"no" ,
                                        self.studiesAnatomy ? @"yes" : @"no"];
}
*/

- (NSString *)description {
    return [NSString stringWithFormat:  @"Student studies:\n"
            "biology = %@\n"
            "math = %@\n"
            "development = %@\n"
            "engineering = %@\n"
            "art = %@\n"
            "phycology = %@\n"
            "anatomy = %@\n",
            [self answerByType:StudentSubjectTypeBiology],
            [self answerByType:StudentSubjectTypeMath],
            [self answerByType:StudentSubjectTypeDevelopment],
            [self answerByType:StudentSubjectTypeEngineering],
            [self answerByType:StudentSubjectTypeArt],
            [self answerByType:StudentSubjectTypePhycology],
            [self answerByType:StudentSubjectTypeAnatomy]];
}

-(NSString*) answerByType:(StudentSubjectType) type {
    return self.subjectType & type ? @"yes" : @"no";
}

@end
