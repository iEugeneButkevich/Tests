//
//  EBPatient.h
//  DelegatesTest
//
//  Created by Eugene on 6/6/16.
//  Copyright (c) 2016 EugeneButkevich. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol EBPatientDelegate;

@interface EBPatient : NSObject
@property (strong, nonatomic) NSString* name;
@property (assign, nonatomic) NSInteger temperature;
@property (weak, nonatomic) id <EBPatientDelegate> delegate;

-(BOOL) howAreYou;
-(void) takePill;
-(void) makeInjection;
@end

@protocol EBPatientDelegate <NSObject>
@required
-(void) patientFeelsBad:(EBPatient*) patient;
-(void) patient:(EBPatient*) patient hasQuestion:(NSString*) question;
@end