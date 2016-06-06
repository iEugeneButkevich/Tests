//
//  EBStudent.h
//  ProtocolsTest
//
//  Created by Eugene on 6/6/16.
//  Copyright (c) 2016 EugeneButkevich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EBPatient.h"

@interface EBStudent : NSObject <EBPatient>

@property (strong, nonatomic) NSString* universityName;
@property (strong, nonatomic) NSString* name;

-(void) study;

@end
