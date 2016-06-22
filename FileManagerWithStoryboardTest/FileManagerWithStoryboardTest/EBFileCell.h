//
//  EBFileCell.h
//  FileManagerWithStoryboardTest
//
//  Created by DmitryMini on 6/22/16.
//  Copyright © 2016 offsiteteam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EBFileCell : UITableViewCell

@property(weak, nonatomic) IBOutlet UILabel* nameLabel;
@property(weak, nonatomic) IBOutlet UILabel* sizeLabel;
@property(weak, nonatomic) IBOutlet UILabel* dateLabel;

@end
