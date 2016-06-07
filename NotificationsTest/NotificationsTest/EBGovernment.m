//
//  EBGovernment.m
//  NotificationsTest
//
//  Created by Eugene on 6/7/16.
//  Copyright (c) 2016 EugeneButkevich. All rights reserved.
//

#import "EBGovernment.h"

NSString* const EBGovernmentTaxLevelDIdChangeNotification = @"EBGovernmentTaxLevelDIdChangeNotification";
NSString* const EBGovernmentSalaryDIdChangeNotification = @"EBGovernmentSalaryDIdChangeNotification";
NSString* const EBGovernmentPensionDIdChangeNotification = @"EBGovernmentPensionDIdChangeNotification";
NSString* const EBGovernmentAveragePriceDIdChangeNotification = @"EBGovernmentAveragePriceDIdChangeNotification";

NSString* const EBGovernmentTaxLevelUserInfoKey = @"EBGovernmentTaxLevelUserInfoKey";
NSString* const EBGovernmentSalaryUserInfoKey = @"EBGovernmentSalaryUserInfoKey";
NSString* const EBGovernmentPensionUserInfoKey = @"EBGovernmentPensionUserInfoKey";
NSString* const EBGovernmentAveragePriceUserInfoKey = @"EBGovernmentAveragePriceUserInfoKey";

@implementation EBGovernment

- (id)init
{
    self = [super init];
    if (self) {
        self.taxLevel = 5.f;
        self.salary = 1010;
        self.pension = 500;
        self.averagePrice = 10.f;
    }
    return self;
}

-(void) setTaxLevel:(CGFloat)taxLevel{
    _taxLevel = taxLevel;
    
    NSDictionary* dictionary = [NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:taxLevel] forKey:EBGovernmentTaxLevelUserInfoKey];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:EBGovernmentTaxLevelDIdChangeNotification object:nil userInfo:dictionary];
}

-(void) setSalary:(CGFloat)salary{
    _salary = salary;
    
    NSDictionary* dictionary = [NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:salary] forKey:EBGovernmentSalaryUserInfoKey];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:EBGovernmentSalaryDIdChangeNotification object:nil userInfo:dictionary];
}

-(void) setPension:(CGFloat)pension{
    _pension = pension;
    
    NSDictionary* dictionary = [NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:pension] forKey:EBGovernmentPensionUserInfoKey];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:EBGovernmentPensionDIdChangeNotification object:nil userInfo:dictionary];
}

-(void) setAveragePrice:(CGFloat)averagePrice{
    _averagePrice = averagePrice;
    
    NSDictionary* dictionary = [NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:averagePrice] forKey:EBGovernmentAveragePriceUserInfoKey];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:EBGovernmentAveragePriceDIdChangeNotification object:nil userInfo:dictionary];
}

@end
