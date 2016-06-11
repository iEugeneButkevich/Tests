//
//  EBViewController.h
//  OutletsTest
//
//  Created by Eugene on 6/11/16.
//  Copyright (c) 2016 EugeneButkevich. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EBViewController : UIViewController
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *testViews;
@property (weak, nonatomic) IBOutlet UIView* testView;
@end
