//
//  PostCell.h
//  APITest3
//
//  Created by Eugene Butkevich on 8/2/16.
//  Copyright © 2016 offsiteteam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostCell : UITableViewCell

@property(strong, nonatomic) IBOutlet UILabel* postTextLabel;

+(CGFloat) heightForText:(NSString*) text;

@end
