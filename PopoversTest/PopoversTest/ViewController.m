//
//  ViewController.m
//  PopoversTest
//
//  Created by Eugene Butkevich on 7/19/16.
//  Copyright © 2016 offsiteteam. All rights reserved.
//

#import "ViewController.h"
#import "DetailsViewController.h"

@interface ViewController () <UIPopoverControllerDelegate>
@property (strong, nonatomic) UIPopoverController* popover;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc
{
    NSLog(@"Our controller deallocated");
}

#pragma mark - Actions

- (void) showControllerAsModal:(UIViewController*) vc{
    [self presentViewController:vc
                       animated:YES
                     completion:^{
                         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                             [self dismissViewControllerAnimated:YES completion:nil];
                         });
                     }];
}

- (void) showController:(UIViewController*) vc inPopoverFromSender: (id) sender {
    if (!sender) {
        return;
    }
    vc.preferredContentSize = CGSizeMake(300, 300);
    UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:vc];
    UIPopoverController* popover = [[UIPopoverController alloc] initWithContentViewController:nav];
    popover.delegate = self;
    self.popover = popover;
    if ([sender isKindOfClass:[UIBarButtonItem class]]) {
        [popover presentPopoverFromBarButtonItem:sender
                        permittedArrowDirections:UIPopoverArrowDirectionUp | UIPopoverArrowDirectionRight
                                        animated:YES];
    } else if ([sender isKindOfClass:[UIButton class]]) {
        [popover presentPopoverFromRect:[(UIButton*)sender frame]
                                 inView:self.view
               permittedArrowDirections:UIPopoverArrowDirectionLeft | UIPopoverArrowDirectionRight
                               animated:YES];
    }
}

- (IBAction)actionAdd:(UIBarButtonItem*)sender {
    
    DetailsViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailsViewController"];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        [self showController:vc inPopoverFromSender:sender];
    } else {
        [self showControllerAsModal:vc];
    }
}

- (IBAction)actionPressMe:(UIButton*)sender {
    DetailsViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailsViewController"];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        [self showController:vc inPopoverFromSender:sender];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.popover dismissPopoverAnimated:YES];
            self.popover = nil;
        });
    } else {
        [self showControllerAsModal:vc];
    }
}

#pragma mark - UIPopoverControllerDelegate

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
    self.popover = nil;
}

#pragma mark - Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"prepareForSegue %@ %@", segue.identifier, NSStringFromClass([segue.destinationViewController class]));
}

@end
