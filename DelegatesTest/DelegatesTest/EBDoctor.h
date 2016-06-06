//
//  EBDoctor.h
//  DelegatesTest
//
//  Created by Eugene on 6/6/16.
//  Copyright (c) 2016 EugeneButkevich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EBPatient.h"

@interface EBDoctor : NSObject <EBPatientDelegate>

@end
