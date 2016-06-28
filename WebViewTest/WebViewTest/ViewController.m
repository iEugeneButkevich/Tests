//
//  ViewController.m
//  WebViewTest
//
//  Created by DmitryMini on 6/28/16.
//  Copyright © 2016 offsiteteam. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1 part
/*    NSString* urlString = @"https://vk.com/iosdevcourse";
    NSURL* url = [NSURL URLWithString:urlString];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request]; */
    
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"1" ofType:@"pdf"];
    
    //2 part
    // Не совсем правильный способ работы с файлами
    NSData* fileData = [NSData dataWithContentsOfFile: filePath];

/*    [self.webView loadData:fileData
                  MIMEType:@"application/pdf"
          textEncodingName:@"UTF-8"
                   baseURL:nil]; */
    
    // Способ работы с файлами через url
/*    NSURL* fileUrl = [NSURL fileURLWithPath: filePath];
    NSURLRequest* request = [NSURLRequest requestWithURL:fileUrl];
    [self.webView loadRequest:request];*/
    
    //3 part
    NSString* htmlString = @"<html>"
                                "<body>"
                                    "<p style = \"font-size: 500%%; text-align: center\"> Hello World! </p>"
                                    "<a href = \"https://vk.com/iosdevcourse\"><p>iOS Dev Course</p></a>"
                                    "<a href = \"cmd:show_alert\">Test button</a>"
                                "</body>"
                            "</html>";
    [self.webView loadHTMLString:htmlString baseURL:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

-(IBAction)actionBack:(id)sender {
    if ([self.webView canGoBack]) {
        [self.webView stopLoading];
        [self.webView goBack];
    }
}

-(IBAction)actionForward:(id)sender {
    if ([self.webView canGoForward]) {
        [self.webView stopLoading];
        [self.webView goForward];
    }
}

-(IBAction)actionRefresh:(id)sender {
    [self.webView stopLoading];
    [self.webView reload];
}

- (void) refreshButtons {
    self.backButtonItem.enabled = [self.webView canGoBack];
    self.forwardButtonItem.enabled = [self.webView canGoForward];
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSLog(@"shouldStartLoadWithRequest %@", [request debugDescription]);
    
    NSString* urlString = [request.URL absoluteString];
    
    if ([urlString hasPrefix:@"cmd:"]) {
        NSString* command = [urlString substringFromIndex:4];
        if ([command isEqualToString:@"show_alert"]) {
            UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"Hello World!"
                                                                                     message:@"Hi there"
                                                                              preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* alertAction = [UIAlertAction actionWithTitle:@"OK"
                                                                  style:UIAlertActionStyleDefault
                                                                handler:^(UIAlertAction * _Nonnull action) {
                                                                    [alertController dismissViewControllerAnimated:YES completion:nil];
                                                                }];
            [alertController addAction:alertAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        return NO;  // Т.к. это наша внутрення команда
    }
    
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"webViewDidStartLoad");
    [self.indicator startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"webViewDidFinishLoad");
    [self.indicator stopAnimating];
    
    [self refreshButtons];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error {
    NSLog(@"didFailLoadWithError");
    [self.indicator stopAnimating];
    
    [self refreshButtons];
}

@end
