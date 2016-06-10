//
//  EBViewController.m
//  ViewControllersTest
//
//  Created by Eugene on 6/9/16.
//  Copyright (c) 2016 EugeneButkevich. All rights reserved.
//

#import "EBViewController.h"

@interface EBViewController ()

@end

@implementation EBViewController

#pragma mark - Loading

-(void) loadView{
    [super loadView];
    NSLog(@"loadView");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	NSLog(@"viewDidLoad");
    NSLog(@"");
    self.view.backgroundColor = [UIColor blueColor];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        NSLog(@"iPad");
    } else {
        NSLog(@"iPhone");
    }
}

#pragma mark - Views

- (void)viewWillAppear:(BOOL)animated{      //Data initialization
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear");
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"viewDidAppear");
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    NSLog(@"viewWillLayoutSubviews");
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    NSLog(@"viewDidLayoutSubviews");
}

//- (void)viewWillDisappear:(BOOL)animated; // Called when the view is dismissed, covered or otherwise hidden. Default does nothing
//- (void)viewDidDisappear:(BOOL)animated;  // Called after the view was dismissed, covered or otherwise hidden. Default does nothing

#pragma mark - Orientation


- (BOOL)shouldAutorotate NS_AVAILABLE_IOS(6_0){
//    return NO;
    return YES;
}
- (NSUInteger)supportedInterfaceOrientations NS_AVAILABLE_IOS(6_0){
    return UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskPortrait;
}

//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation NS_AVAILABLE_IOS(6_0); - orientation for new window
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    NSLog(@"willRotateToInterfaceOrientation from %d to %d",self.interfaceOrientation, toInterfaceOrientation);
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    NSLog(@"didRotateFromInterfaceOrientation from %d to %d", fromInterfaceOrientation, self.interfaceOrientation);
}


#pragma mark - Memory

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
