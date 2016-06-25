//
//  NSString+Random.h
//  SearchTest
//
//  Created by Eugene on 6/25/16.
//  Copyright (c) 2016 EugeneButkevich. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Random)

+ (NSString*) randomAlphanumericString;
+ (NSString*) randomAlphanumericStringWithLength: (NSInteger) length;
@end
