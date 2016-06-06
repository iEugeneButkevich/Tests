//
//  EBBoxer.h
//  Test
//
//  Created by Eugene on 6/4/16.
//  Copyright (c) 2016 Eugene. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EBBoxer : NSObject

@property (strong, nonatomic) NSString* name;
@property (assign, nonatomic) NSInteger age;
@property (assign, nonatomic) CGFloat height;
@property (assign, nonatomic) CGFloat weight;

+(void) tellAboutYourself;

-(void) beat;
-(void) say;
-(void) say:(NSString*) string1;
-(void) say:(NSString*) string1 and:(NSString*) string2;
-(void) dealloc;

@end
