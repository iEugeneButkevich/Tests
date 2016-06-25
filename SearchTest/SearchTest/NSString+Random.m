//
//  NSString+Random.m
//  SearchTest
//
//  Created by Eugene on 6/25/16.
//  Copyright (c) 2016 EugeneButkevich. All rights reserved.
//

#import "NSString+Random.h"

@implementation NSString (Random)

+ (NSString*) randomAlphanumericString {
    int length = arc4random() % 11 + 5;
    return [self randomAlphanumericStringWithLength:length];
}

+ (NSString*) randomAlphanumericStringWithLength: (NSInteger) length {
    
    NSString* letters = @"abcdefghijklmnopqrstuvwxyz";    //ABCDEFGHIJKLMNOPQRSTUVWXYZ012345689
    NSMutableString* randomString = [NSMutableString stringWithCapacity:length];
    for ( int i = 0; i < length; i++) {
        [randomString appendFormat:@"%C", [letters characterAtIndex:arc4random() % [letters length]]];
    }
    return randomString;
}

@end
