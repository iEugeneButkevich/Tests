//
//  EBViewController.m
//  OutletsTest
//
//  Created by Eugene on 6/11/16.
//  Copyright (c) 2016 EugeneButkevich. All rights reserved.
//

#import "EBViewController.h"

@interface EBViewController ()

@end

@implementation EBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CGFloat) randomFromZeroToOne{
    return (float) (arc4random() % 256) / 255;
}

-(UIColor*) randomColor{
    CGFloat r = [self randomFromZeroToOne];
    CGFloat g = [self randomFromZeroToOne];
    CGFloat b = [self randomFromZeroToOne];
    return  [UIColor colorWithRed:r green:g blue:b alpha:1.f];
}

-(void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    self.testView.backgroundColor = [self randomColor];
    
    for(UIView* v in self.testViews){
    v.backgroundColor = [self randomColor];
    }
}


@end
