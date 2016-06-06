//
//  EBDancer.m
//  ProtocolsTest
//
//  Created by Eugene on 6/6/16.
//  Copyright (c) 2016 EugeneButkevich. All rights reserved.
//

#import "EBDancer.h"

@implementation EBDancer

-(void) dance{
    
}

#pragma mark - EBPatient

-(BOOL) areYouOk{
    BOOL result = arc4random() % 2;
    NSLog(@"Is dancer %@ ok? %@", self.name, result ? @"YES" : @"NO");
    return result;
}

-(void) takePill{
    NSLog(@"Dancer %@ takes a pill", self.name);
}

-(void) makeShot{
    NSLog(@"Dancer %@ makes a shot", self.name);
}

@end
