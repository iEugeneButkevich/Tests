//
//  EBObject.m
//  TimeTest
//
//  Created by Eugene Butkevich on 8/8/16.
//  Copyright © 2016 offsiteteam. All rights reserved.
//

#import "EBObject.h"

@implementation EBObject

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSTimer* timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerTest:) userInfo:nil repeats:YES];
        [timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:5]];
        NSLog(@"EBObject is initialized");
    }
    return self;
}

-(void) timerTest:(NSTimer*) timer {
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss:SSS"];
    NSLog(@" %@", [dateFormatter stringFromDate:[NSDate date]]);
}

- (void)dealloc
{
    NSLog(@"EBObject is deallocated");
}

@end
