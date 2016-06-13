//
//  ViewController.m
//  ControlsTest
//
//  Created by DmitryMini on 6/13/16.
//  Copyright © 2016 EugeneButkevich. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

typedef enum {
    EBColorSchemeTypeRGB,
    EBColorSchemeTypeHSV
} EBColorSchemeType;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self refreshScreen];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private methods
-(void) refreshScreen{
    CGFloat firstComponent = self.firstComponentSlider.value;
    CGFloat secondComponent = self.secondComponentSlider.value;
    CGFloat thirdComponent = self.thirdComponentSlider.value;
    UIColor* color = nil;
    
    if (self.colorSchemeControl.selectedSegmentIndex == EBColorSchemeTypeRGB){
        color = [UIColor colorWithRed:firstComponent green:secondComponent blue:thirdComponent alpha:1.f];
    } else {
        color = [UIColor colorWithHue:firstComponent saturation:secondComponent brightness:thirdComponent alpha:1.f];
    }
    
    CGFloat hue, saturation, brightness, alpha;
    NSString* result = @"";
    if ([color getRed:&firstComponent green:&secondComponent blue:&thirdComponent alpha:&alpha]){
        result = [result stringByAppendingFormat:@"RGB:{%1.2f, %1.2f, %1.2f}",firstComponent, secondComponent, thirdComponent];
    } else {
        result = [result stringByAppendingFormat:@"RGB:{NO DATA}"];
    }
    if([color getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha]){
        result = [result stringByAppendingFormat:@"\tHSV:{%1.2f, %1.2f, %1.2f}",hue, saturation, brightness];
    } else {
        result = [result stringByAppendingFormat:@"\tHSV:{NO DATA}"];
    }
    
    self.infoLabel.text = result;
    self.view.backgroundColor = color;
}

#pragma mark - Actions
- (IBAction)actionSlider:(UISlider *)sender {
    [self refreshScreen];
}

- (IBAction)actionEnable:(UISwitch *)sender {
    self.firstComponentSlider.enabled = sender.isOn;
    self.secondComponentSlider.enabled = sender.isOn;
    self.thirdComponentSlider.enabled = sender.isOn;
    
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if ([[UIApplication sharedApplication] isIgnoringInteractionEvents]){
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        }
    });
}

@end
