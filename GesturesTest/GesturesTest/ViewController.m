//
//  ViewController.m
//  GesturesTest
//
//  Created by Eugene Butkevich on 8/8/16.
//  Copyright © 2016 offsiteteam. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIGestureRecognizerDelegate>

@property(weak, nonatomic) UIView* testView;
@property(assign, nonatomic) CGFloat testViewScale;
@property(assign, nonatomic) CGFloat testViewRotation;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.view.bounds) - 50,
                                                            CGRectGetMidY(self.view.bounds) - 50, 100, 100)];
    view.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |
                            UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    view.backgroundColor = [UIColor greenColor];
    [self.view addSubview:view];
    self.testView = view;
    
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self.view addGestureRecognizer:tapGesture];
    
    UITapGestureRecognizer* doubleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    doubleTapGesture.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:doubleTapGesture];
    [tapGesture requireGestureRecognizerToFail:doubleTapGesture];
    
    UITapGestureRecognizer* doubleTapDoubleTouchGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTapDoubleTouch:)];
    doubleTapDoubleTouchGesture.numberOfTapsRequired = 2;
    doubleTapDoubleTouchGesture.numberOfTouchesRequired = 2;
    [self.view addGestureRecognizer:doubleTapDoubleTouchGesture];
    
    UIPinchGestureRecognizer* pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
    [self.view addGestureRecognizer:pinchGesture];
    
    UIRotationGestureRecognizer* rotationGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotation:)];
    [self.view addGestureRecognizer:rotationGesture];
    
    UIPanGestureRecognizer* panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(hadlePan:)];
    [self.view addGestureRecognizer:panGesture];
    
    UISwipeGestureRecognizer* swipeVerticalGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(hadleVerticalSwipe:)];
    swipeVerticalGesture.direction = UISwipeGestureRecognizerDirectionUp | UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:swipeVerticalGesture];
    
    UISwipeGestureRecognizer* swipeHorizontalGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(hadleHorizontalSwipe:)];
    swipeHorizontalGesture.direction = UISwipeGestureRecognizerDirectionRight | UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeHorizontalGesture];
    
    pinchGesture.delegate = self;
    rotationGesture.delegate = self;
    panGesture.delegate = self;
    swipeVerticalGesture.delegate = self;
    swipeHorizontalGesture.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Methods

-(UIColor*) randomColor {
    CGFloat r =  (float)(arc4random() % 256) / 255.f;
    CGFloat g =  (float)(arc4random() % 256) / 255.f;
    CGFloat b =  (float)(arc4random() % 256) / 255.f;
    return [UIColor colorWithRed:r green:g blue:b alpha:1.f];
}

#pragma mark - Gestures

-(void) handleTap:(UITapGestureRecognizer*) tapGesture {
    self.testView.backgroundColor = [self randomColor];
    NSLog(@"Tap: %@", NSStringFromCGPoint([tapGesture locationInView:self.view]));
}

-(void) handleDoubleTap:(UITapGestureRecognizer*) tapGesture {
    CGAffineTransform currentTransform = self.testView.transform;
    [UIView animateWithDuration:0.3 animations:^{
        self.testView.transform = CGAffineTransformScale(currentTransform, 1.2f, 1.2f);

    }];
    self.testViewScale = 1.2f;
    NSLog(@"Double Tap: %@", NSStringFromCGPoint([tapGesture locationInView:self.view]));
}

-(void) handleDoubleTapDoubleTouch:(UITapGestureRecognizer*) tapGesture {
    CGAffineTransform currentTransform = self.testView.transform;
    [UIView animateWithDuration:0.3 animations:^{
        self.testView.transform = CGAffineTransformScale(currentTransform, 0.8f, 0.8f);
        
    }];
    self.testViewScale = 0.8f;
    NSLog(@"Double Tap Double Touch: %@", NSStringFromCGPoint([tapGesture locationInView:self.view]));
}

-(void) handlePinch:(UIPinchGestureRecognizer*) pinchGesture {
    
    if (pinchGesture.state == UIGestureRecognizerStateBegan) {
        self.testViewScale = 1.f;
    }
    CGFloat newScale = 1.f + pinchGesture.scale - self.testViewScale;
    CGAffineTransform currentTransform = self.testView.transform;
    self.testView.transform = CGAffineTransformScale(currentTransform, newScale, newScale);
    self.testViewScale = pinchGesture.scale;
    NSLog(@"handlePinch %1.3f", pinchGesture.scale);
}

-(void) handleRotation:(UIRotationGestureRecognizer*) rotationGesture {
    if (rotationGesture.state == UIGestureRecognizerStateBegan) {
        self.testViewRotation = 0;
    }
    CGFloat newRotation = rotationGesture.rotation - self.testViewRotation;
    CGAffineTransform currentTransform = self.testView.transform;
    self.testView.transform = CGAffineTransformRotate(currentTransform, newRotation);
    self.testViewRotation = rotationGesture.rotation;
    NSLog(@"handleRotation %1.3f", rotationGesture.rotation);
}

-(void) hadlePan: (UIPanGestureRecognizer*) panGesture {
    self.testView.center = [panGesture locationInView:self.view];
    NSLog(@"hadlePan");
}

-(void) hadleVerticalSwipe: (UISwipeGestureRecognizer*) swipeGesture {
    NSLog(@"hadleVerticalSwipe");
}

-(void) hadleHorizontalSwipe: (UISwipeGestureRecognizer*) swipeGesture {
    NSLog(@"hadleHorizontalSwipe");
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] && [otherGestureRecognizer isKindOfClass:[UISwipeGestureRecognizer class]]);
}

@end
