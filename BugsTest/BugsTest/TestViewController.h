//
//  TestViewController.h
//  BugsTest
//
//  Created by Eugene Butkevich on 8/4/16.
//  Copyright © 2016 offsiteteam. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^TestBlock)(void);

@interface TestViewController : UIViewController

@property(copy, nonatomic) TestBlock testBlock;

-(void) testMethod;

@end
