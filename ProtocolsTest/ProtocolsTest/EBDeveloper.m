//
//  EBDeveloper.m
//  ProtocolsTest
//
//  Created by Eugene on 6/6/16.
//  Copyright (c) 2016 EugeneButkevich. All rights reserved.
//

#import "EBDeveloper.h"

@implementation EBDeveloper

-(void) work{
    
}

#pragma mark - EBPatient

-(BOOL) areYouOk{
    BOOL result = arc4random() % 2;
    NSLog(@"Is developer %@ ok? %@", self.name, result ? @"YES" : @"NO");
    return result;
}

-(void) takePill{
    NSLog(@"Developer %@ takes a pill", self.name);
}

-(void) makeShot{
    NSLog(@"Developer %@ makes a shot", self.name);
}

-(NSString*) howIsYourJob{
    return @"My job is awesome!!!";
}

@end
