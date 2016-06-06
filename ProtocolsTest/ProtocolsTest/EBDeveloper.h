//
//  EBDeveloper.h
//  ProtocolsTest
//
//  Created by Eugene on 6/6/16.
//  Copyright (c) 2016 EugeneButkevich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EBPatient.h"

@interface EBDeveloper : NSObject <EBPatient>

@property(assign, nonatomic) CGFloat experience;
@property (strong, nonatomic) NSString* name;

-(void) work;

@end
