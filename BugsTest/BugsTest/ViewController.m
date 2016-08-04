//
//  ViewController.m
//  BugsTest
//
//  Created by Eugene Butkevich on 8/4/16.
//  Copyright © 2016 offsiteteam. All rights reserved.
//

#import "ViewController.h"
#import "TestViewController.h"

@interface ViewController () <UIPopoverControllerDelegate>

@property(strong, nonatomic) UIPopoverController* popover;
//@property(weak, nonatomic) id shmelegate;     // Не будет краша
@property(assign, nonatomic) id shmelegate;     // Будет краш


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
    self.popover = nil;
    // Когда у нас баг bad_access, можно включить зомби, тогда проще отлавливается сам баг (Edit scheme->diagnostics)
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.shmelegate dismissPopoverAnimated:YES];
    });
}

#pragma MARK - Actions

-(IBAction)ActionTest:(UIButton*)sender {
    TestViewController* vc = [[TestViewController alloc] init];
    UIPopoverController* popover = [[UIPopoverController alloc] initWithContentViewController:vc];
    [popover setPopoverContentSize:CGSizeMake(300, 400)];
    popover.delegate = self;
    [popover presentPopoverFromRect:sender.bounds
                             inView:sender
           permittedArrowDirections:UIPopoverArrowDirectionAny
                           animated:YES];
    self.popover = popover;
    
    // Создали утечку памяти:
    vc.testBlock=^{
        [vc testMethod];
    };
    
    self.shmelegate = popover;
}

@end
