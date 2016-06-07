//
//  EBDoctor.m
//  NotificationsTest
//
//  Created by Eugene on 6/7/16.
//  Copyright (c) 2016 EugeneButkevich. All rights reserved.
//

#import "EBDoctor.h"
#import "EBGovernment.h"

@implementation EBDoctor

#pragma mark - Initialization
- (id)init
{
    self = [super init];
    if (self) {
        NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
        [nc addObserver:self
               selector:@selector(salaryChangedNotification:)
                   name:EBGovernmentSalaryDIdChangeNotification
                 object:nil];
        
        [nc addObserver:self
               selector:@selector(averagePriceChangedNotification:)
                   name:EBGovernmentAveragePriceDIdChangeNotification
                 object:nil];
    }
    return self;
}

-(void) dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Notifications

-(void) salaryChangedNotification:(NSNotification*) notification{
    NSNumber* value = [notification.userInfo objectForKey:EBGovernmentSalaryUserInfoKey];
    CGFloat salary = [value floatValue];
    if(salary < self.salary){
        NSLog(@"Doctors are NOT happy");
    } else {
        NSLog(@"Doctors are happy");
    }
    self.salary = salary;
}

-(void) averagePriceChangedNotification:(NSNotification*) notification{
    NSNumber* value = [notification.userInfo objectForKey:EBGovernmentAveragePriceUserInfoKey];
    CGFloat averagePrice = [value floatValue];
    if(averagePrice > self.averagePrice){
        NSLog(@"Doctors are NOT happy");
    } else {
        NSLog(@"Doctors are happy");
    }
    self.averagePrice = averagePrice;
}

@end
