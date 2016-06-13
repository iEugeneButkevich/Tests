//
//  ViewController.h
//  ControlsTest
//
//  Created by DmitryMini on 6/13/16.
//  Copyright © 2016 EugeneButkevich. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UISlider *firstComponentSlider;
@property (weak, nonatomic) IBOutlet UISlider *secondComponentSlider;
@property (weak, nonatomic) IBOutlet UISlider *thirdComponentSlider;
@property (weak, nonatomic) IBOutlet UISegmentedControl *colorSchemeControl;


- (IBAction)actionSlider:(UISlider *)sender;

- (IBAction)actionEnable:(UISwitch *)sender;
@end

