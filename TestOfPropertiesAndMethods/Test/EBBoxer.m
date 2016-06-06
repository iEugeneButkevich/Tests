//
//  EBBoxer.m
//  Test
//
//  Created by Eugene on 6/4/16.
//  Copyright (c) 2016 Eugene. All rights reserved.
//

#import "EBBoxer.h"

@interface EBBoxer()
@property (assign, nonatomic) NSInteger nameCount; //it's category for private properties
@end

@implementation EBBoxer
@synthesize name=_name;

- (id)init
{
    self = [super init];
    if (self) {
        _nameCount = 0;
        self.name = @"defaultName";
        _age = 1;
        self.height = 0.5f;
        _weight = 5.f;
    }
    return self;
}

+(void) tellAboutYourself{
    NSLog(@"I am %@", self);
}


-(void) setName:(NSString*)name {
    _name=name;
}

- (NSString*) name{
    self.nameCount++;
    NSLog(@"name getter is called %d times", self.nameCount);
    return _name;
}

-(NSInteger) age{
    return ++_age;
}

-(void) say{
    NSLog(@"I am boxer");
}

-(void) say:(NSString*) string1{
    NSLog(@"I am boxer and %@",string1);
}

-(void) say:(NSString*) string1 and:(NSString*) string2{
    NSLog(@"I am boxer,%@ and %@",string1,string2);
}

-(void) beat{
    NSLog(@"I beat you with hist");
}

-(void) dealloc{
    NSLog(@"EBBoxer is deallocated");
}

@end
