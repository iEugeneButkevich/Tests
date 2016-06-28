//
//  Student.h
//  KVCTest
//
//  Created by DmitryMini on 6/28/16.
//  Copyright © 2016 offsiteteam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Student : NSObject
@property (strong, nonatomic) NSString* name;
@property (assign, nonatomic) NSInteger age;

- (void) changeName;

@end
