//
//  EBGovernment.h
//  NotificationsTest
//
//  Created by Eugene on 6/7/16.
//  Copyright (c) 2016 EugeneButkevich. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString* const EBGovernmentTaxLevelDIdChangeNotification;
extern NSString* const EBGovernmentSalaryDIdChangeNotification;
extern NSString* const EBGovernmentPensionDIdChangeNotification;
extern NSString* const EBGovernmentAveragePriceDIdChangeNotification;

extern NSString* const EBGovernmentTaxLevelUserInfoKey;
extern NSString* const EBGovernmentSalaryUserInfoKey;
extern NSString* const EBGovernmentPensionUserInfoKey;
extern NSString* const EBGovernmentAveragePriceUserInfoKey;

@interface EBGovernment : NSObject

@property (assign, nonatomic) CGFloat taxLevel;
@property (assign, nonatomic) CGFloat salary;
@property (assign, nonatomic) CGFloat pension;
@property (assign, nonatomic) CGFloat averagePrice;

@end
