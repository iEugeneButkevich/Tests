//
//  EBDirectoryViewController.h
//  FileManagerWithStoryboardTest
//
//  Created by DmitryMini on 6/22/16.
//  Copyright © 2016 offsiteteam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EBDirectoryViewController : UITableViewController

@property(strong, nonatomic) NSString* path;

- (id) initWithFolderPath: (NSString*) path;

- (IBAction) actionInfoCell: (id)sender;

@end
