//
//  ViewController.m
//  TricksTest
//
//  Created by Eugene Butkevich on 8/3/16.
//  Copyright © 2016 offsiteteam. All rights reserved.
//

#import "ViewController.h"
#import "Utils.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSLog(@"%@", fancyDateStringFromDate([NSDate date]));
    
    if (iPad()) {
        NSLog(@"iPad!");
    } else {
        NSLog(@"iPhone!");
    }
    
    NSLog(@"%@", NSStringFromProgrammerType(ProgrammerTypeSenior));
    
#ifdef PRODUCTION_BUILD
    NSLog(@"macro PRODUCTION_BUILD exists");
#else
    NSLog(@"macro PRODUCTION_BUILD doesn't exist");
#endif
    
#ifndef PRODUCTION_BUILD
    NSLog(@"macro PRODUCTION_BUILD doesn't exist");
#endif
    
    self.view.backgroundColor = RGB(155, 200, 120, 250);
    
    [[NSNotificationCenter defaultCenter] addObserverForName:EBLogNotification
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:^(NSNotification * _Nonnull notification) {
                                                      self.consoleView.text = [NSString stringWithFormat:@"%@\n%@",self.consoleView.text, [notification.userInfo objectForKey:EBLogNotificationTextUserInfoKey]];
                                                  }];
    
}

-(IBAction)actionTest:(id)sender {
    EBLog(@"actionTest");
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
//    return UIInterfaceOrientationMaskPortrait |
//    UIInterfaceOrientationMaskLandscapeLeft |
//    UIInterfaceOrientationMaskLandscapeRight;
//}
//
//- (BOOL)shouldAutorotate {
//    if ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortrait) {
//        NSLog(@"PORTRAIT");
//        return YES;
//    } else {
//        return NO;
//    }
//}

@end
