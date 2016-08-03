//
//  LoginViewController.h
//  APITest2
//
//  Created by Eugene Butkevich on 7/27/16.
//  Copyright © 2016 offsiteteam. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AccessToken;

typedef void(^LoginCompletionBlock)(AccessToken* token);

@interface LoginViewController : UIViewController

- (id) initWithCompletionBlock:(LoginCompletionBlock) completionBlock;

@end
