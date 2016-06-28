//
//  ViewController.h
//  WebViewTest
//
//  Created by DmitryMini on 6/28/16.
//  Copyright © 2016 offsiteteam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIWebViewDelegate>

@property(weak, nonatomic) IBOutlet UIWebView* webView;
@property(weak, nonatomic) IBOutlet UIActivityIndicatorView* indicator;
@property(weak, nonatomic) IBOutlet UIBarButtonItem* backButtonItem;
@property(weak, nonatomic) IBOutlet UIBarButtonItem* forwardButtonItem;

-(IBAction)actionBack:(id)sender;
-(IBAction)actionForward:(id)sender;
-(IBAction)actionRefresh:(id)sender;

@end

