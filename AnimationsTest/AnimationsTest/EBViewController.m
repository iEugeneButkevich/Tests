//
//  EBViewController.m
//  AnimationsTest
//
//  Created by Eugene on 6/11/16.
//  Copyright (c) 2016 EugeneButkevich. All rights reserved.
//

#import "EBViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface EBViewController ()
@property (weak, nonatomic) UIView* testView;
@property (weak, nonatomic) UIImageView* testImageView;
@end

@implementation EBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //Тест с UIView
//    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
//    view.backgroundColor = [UIColor greenColor];
//    [self.view addSubview:view];
//    self.testView = view;

    //Тест с UIImageView
    UIImageView* view = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    view.backgroundColor = [UIColor clearColor];
    UIImage* image1 = [UIImage imageNamed:@"1.jgp"];
    UIImage* image2 = [UIImage imageNamed:@"2.jgp"];
    UIImage* image3 = [UIImage imageNamed:@"3.jgp"];
    NSArray* images = [[NSArray alloc] initWithObjects:image1, image2, image1, image3, nil];
    view.animationImages = images;
    view.animationDuration = 1.f;
    [view startAnimating];
    [self.view addSubview:view];
    self.testImageView = view;
    
}

-(UIColor*) randomColor{
    CGFloat r = (CGFloat) (arc4random() % 256) / 255.f;
    CGFloat g = (CGFloat) (arc4random() % 256) / 255.f;
    CGFloat b = (CGFloat) (arc4random() % 256) / 255.f;
    return  [UIColor colorWithRed:r green:g blue:b alpha:1.f];
}

-(void) moveView:(UIView*) view{
    
    CGRect rect = self.view.bounds;
    rect = CGRectInset(rect, CGRectGetWidth(view.frame), CGRectGetHeight(view.frame));
    CGFloat x = arc4random() % (int) CGRectGetWidth(rect) + CGRectGetMinX(rect);
    CGFloat y = arc4random() % (int) CGRectGetHeight(rect) + CGRectGetMinY(rect);
    CGFloat s = (float) (arc4random() % 151) / 100 + 0.5f;             //генерируем масштаб от 0,5 до 2
    CGFloat r = (float) (arc4random() % (int) (M_PI * 2 * 10000)) / 10000 - M_PI;
    CGFloat d = (float) (arc4random() % 20001) / 10000 + 2.f;
    
    [UIView animateWithDuration:d
                          delay:1
                        options:UIViewAnimationOptionCurveEaseInOut //| UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse
                     animations:^{
                         view.center = CGPointMake(x,y);
                         view.backgroundColor = [self randomColor];
                         CGAffineTransform scale = CGAffineTransformMakeScale(s, s);
                         CGAffineTransform rotation = CGAffineTransformMakeRotation(r);
                         view.transform = CGAffineTransformConcat(scale, rotation);
                     }
                     completion:^(BOOL finished) {
                         NSLog(@"Animation finished! %d", finished);
                         NSLog(@"\nview frame = %@\nview bounds = %@", NSStringFromCGRect(view.frame),NSStringFromCGRect(view.bounds));
                         
                         __weak UIView* v = view;
                         [self moveView:v];
                     }];

}

-(void) testWithImageView{
    [self moveView:self.testImageView];
}

-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear: animated];
//    [self test1];
//    [self moveView:self.testView];
    [self testWithImageView];
}

-(void) test1{
    /*    [UIView animateWithDuration:5
     animations:^{
     self.testView.center = CGPointMake(CGRectGetWidth(self.view.bounds) - CGRectGetWidth(self.testView.frame) / 2, 150);
     }]; */
    
    [UIView animateWithDuration:10
                          delay:1
                        options:UIViewAnimationOptionCurveEaseInOut //| UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse
                     animations:^{
                         self.testView.center = CGPointMake(CGRectGetWidth(self.view.bounds) - CGRectGetWidth(self.testView.frame) / 2, 150);
                         self.testView.backgroundColor = [self randomColor];
                         CGAffineTransform scale = CGAffineTransformMakeScale(2, 0.5);
                         CGAffineTransform rotation = CGAffineTransformMakeRotation(M_PI);
                         self.testView.transform = CGAffineTransformConcat(scale, rotation);
                     }
                     completion:^(BOOL finished) {
                         NSLog(@"Animation finished! %d", finished);
                         NSLog(@"\nview frame = %@\nview bounds = %@", NSStringFromCGRect(self.testView.frame),NSStringFromCGRect(self.testView.bounds));

                     }];
    
    /*  double delayInSeconds = 6.0;
     dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
     dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
     [self.testView.layer removeAllAnimations];  //Чтобы юзать методы layer'a, надо подключить библиотеку "QuartzCore"
     
     [UIView animateWithDuration:4
     delay:0
     options:UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionBeginFromCurrentState
     animations:^{
     self.testView.center = CGPointMake(500, 500);
     }
     completion:^(BOOL finished) {
     NSLog(@"Animation finished! %d", finished);
     }];
     
     });*/
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
