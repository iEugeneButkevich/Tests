//
//  TestViewController.m
//  BugsTest
//
//  Created by Eugene Butkevich on 8/4/16.
//  Copyright © 2016 offsiteteam. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    CGRect r = self.view.bounds;
    r.origin = CGPointZero;
    UIImageView* imageView = [[UIImageView alloc] initWithFrame:r];
    imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
//    imageView.image = [UIImage imageNamed:@"image.jpg"];    // Таким образом картинка хешируется и проблем не будет
    // Поэтому используем другой способ для вопроизведения ошибки:
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"image" ofType:@"jpg"];
    imageView.image = [UIImage imageWithContentsOfFile: filePath];
    [self.view addSubview:imageView];
    
    // 1.Создали утечку памяти:
  /*  CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddEllipseInRect(path, &CGAffineTransformIdentity, CGRectZero);*/
//    CGPathRelease(path);  // если раскомментить, то утечки не будет
    
    // Это не утечка, но многократно вызывая этот метод постоянно будет увеличиваться память:
    [[NSNotificationCenter defaultCenter] addObserverForName:@"TestNotification"
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:^(NSNotification * _Nonnull note) {
                                                      [self testMethod];
                                                  }];
    
}

- (void)dealloc
{
    NSLog(@"TestViewController deallocated");
}

-(void) testMethod{
    NSLog(@"testMethod");
}

@end
