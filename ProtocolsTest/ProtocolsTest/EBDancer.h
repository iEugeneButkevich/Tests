//
//  EBDancer.h
//  ProtocolsTest
//
//  Created by Eugene on 6/6/16.
//  Copyright (c) 2016 EugeneButkevich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EBPatient.h"

@interface EBDancer : NSObject <EBPatient>

@property(strong, nonatomic) NSString* favouriteDance;
@property (strong, nonatomic) NSString* name;

-(void) dance;

@end
