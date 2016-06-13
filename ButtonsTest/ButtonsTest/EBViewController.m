//
//  EBViewController.m
//  ButtonsTest
//
//  Created by Eugene on 6/12/16.
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
    
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(200, 200, 200, 200);
    button.backgroundColor = [UIColor lightGrayColor];
//    [button setTitle:@"Button" forState:UIControlStateNormal];
//    [button setTitle:@"Button Pressed" forState:UIControlStateHighlighted];
//    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//    [button setTitleColor:[UIColor greenColor] forState:UIControlStateHighlighted];
    
    NSDictionary* attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:30],
                                 NSForegroundColorAttributeName: [UIColor orangeColor]};
    NSAttributedString* title = [[NSAttributedString alloc] initWithString:@"button" attributes:attributes];
    [button setAttributedTitle:title forState:UIControlStateNormal];
    NSDictionary* attributes2 = @{NSFontAttributeName: [UIFont systemFontOfSize:20],
                                 NSForegroundColorAttributeName: [UIColor redColor]};
    NSAttributedString* title2 = [[NSAttributedString alloc] initWithString:@"button pressed" attributes:attributes2];
    [button setAttributedTitle:title2 forState:UIControlStateHighlighted];

    UIEdgeInsets insets =  UIEdgeInsetsMake(100, 100, 0, 0);
    button.titleEdgeInsets = insets;
    
    [self.view addSubview:button];
    [button addTarget:self action:@selector(actionTestInside:) forControlEvents:UIControlEventTouchUpInside];
    [button addTarget:self action:@selector(actionTestUpside:) forControlEvents:UIControlEventTouchUpOutside];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma MARK - Actions
-(void) actionTestInside: (UIButton*) button{
    NSLog(@"Button pressed Inside!!!");
}

-(void) actionTestUpside: (UIButton*) button{
    NSLog(@"Button pressed Outside!!!");
}

-(IBAction)actionTest2:(UIButton*) sender{
    NSLog(@"actionTest2 with tag = %d!!", sender.tag);
}

-(IBAction)actionTest2TouchDown:(UIButton*) sender{
    NSLog(@"actionTest2TouchDown");
}

@end
