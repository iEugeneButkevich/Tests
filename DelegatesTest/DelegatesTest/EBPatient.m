//
//  EBPatient.m
//  DelegatesTest
//
//  Created by Eugene on 6/6/16.
//  Copyright (c) 2016 EugeneButkevich. All rights reserved.
//

#import "EBPatient.h"

@implementation EBPatient

-(BOOL) howAreYou{
    BOOL iFeelGood = arc4random() % 2;
    if(!iFeelGood){
        NSLog(@"%@: NO", self.name);
        [self.delegate patientFeelsBad: self];
    } else{
        NSLog(@"%@: YES", self.name);
    }
    return iFeelGood;
}

-(void) takePill{
    NSLog(@"%@ takes a pill",self.name);
}

-(void) makeInjection{
     NSLog(@"%@ makes a shot",self.name);
}

@end
