//
//  EBViewController.m
//  ViewsTest
//
//  Created by Eugene on 6/10/16.
//  Copyright (c) 2016 EugeneButkevich. All rights reserved.
//

#import "EBViewController.h"

@interface EBViewController ()
@property (weak, nonatomic) UIView* testView;
@end

@implementation EBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UIView* view1 = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 200, 50)];
    view1.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.8];
    [self.view addSubview:view1];
    
    UIView* view2 = [[UIView alloc] initWithFrame:CGRectMake(80, 80, 30, 250)];
    view2.backgroundColor = [[UIColor greenColor] colorWithAlphaComponent:0.8];
//    view2.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:view2];
    self.testView = view2;
    
//    [self.view bringSubviewToFront:view1];

}

-(NSUInteger) supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskAll;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
//    NSLog(@"\nframe = %@\nbounds = %@",NSStringFromCGRect(self.testView.frame), NSStringFromCGRect(self.testView.bounds));
    //frame показывает положение view относительно super view
    //bounds показывает положение view относительно своего собственного положения
    
    NSLog(@"\nframe = %@\nbounds = %@",NSStringFromCGRect(self.view.frame), NSStringFromCGRect(self.view.bounds));
    
    CGPoint origin = CGPointZero;
    origin = [self.view convertPoint:origin toView:self.view.window];
    NSLog(@"origin = %@", NSStringFromCGPoint(origin));
    
//    CGRect r = self.view.frame;
    CGRect r = self.view.bounds;
    r.origin.y = 0;
    r.origin.x = CGRectGetWidth(r) - 100;
    r.size = CGSizeMake(100, 100);
    UIView* v = [[UIView alloc] initWithFrame:r];
    v.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.8];
    [self.view addSubview:v];
}

@end
