//
//  EBDoctor.m
//  DelegatesTest
//
//  Created by Eugene on 6/6/16.
//  Copyright (c) 2016 EugeneButkevich. All rights reserved.
//

#import "EBDoctor.h"

@implementation EBDoctor

#pragma mark - EBPatientDelegate

-(void) patientFeelsBad:(EBPatient*) patient{
    NSLog(@"Patient %@ feels bad", patient.name);
    if(patient.temperature >= 37.f & patient.temperature <= 39.f){
        [patient takePill];
    } else if (patient.temperature > 39.f){
        [patient makeInjection];
    } else{
        NSLog(@"Patient %@ should rest", patient.name);
    }
}

-(void) patient:(EBPatient*) patient hasQuestion:(NSString*) question{
    NSLog(@"Patient %@ has a question: %@",patient.name, question);
}

@end
