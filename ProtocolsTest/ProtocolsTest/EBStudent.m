//
//  EBStudent.m
//  ProtocolsTest
//
//  Created by Eugene on 6/6/16.
//  Copyright (c) 2016 EugeneButkevich. All rights reserved.
//

#import "EBStudent.h"

@implementation EBStudent

-(void) study{
    
}

#pragma mark - EBPatient

-(BOOL) areYouOk{
    BOOL result = arc4random() % 2;
    NSLog(@"Is student %@ ok? %@", self.name, result ? @"YES" : @"NO");
    return result;
}

-(void) takePill{
    NSLog(@"Student %@ takes a pill", self.name);
}

-(void) makeShot{
    NSLog(@"Student %@ makes a shot", self.name);
}

-(NSString*) howIsYourFamily{
    return @"My family is doing well!";
}

@end
