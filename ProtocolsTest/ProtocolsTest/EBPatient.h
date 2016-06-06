//
//  EBPatient.h
//  ProtocolsTest
//
//  Created by Eugene on 6/6/16.
//  Copyright (c) 2016 EugeneButkevich. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol EBPatient <NSObject>

@required
@property (strong, nonatomic) NSString* name;

-(BOOL) areYouOk;
-(void) takePill;
-(void) makeShot;

@optional
-(NSString*) howIsYourFamily;
-(NSString*) howIsYourJob;

@end
