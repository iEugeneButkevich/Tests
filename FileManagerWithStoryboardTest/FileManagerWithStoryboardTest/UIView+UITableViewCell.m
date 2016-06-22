//
//  UIView+UITableViewCell.m
//  FileManagerWithStoryboardTest
//
//  Created by DmitryMini on 6/22/16.
//  Copyright © 2016 offsiteteam. All rights reserved.
//

#import "UIView+UITableViewCell.h"

@implementation UIView (UITableViewCell)

- (UITableViewCell*) parentCell {
    if (!self.superview) {
        return nil;
    }
    if ([self.superview isKindOfClass:[UITableViewCell class]]) {
        return (UITableViewCell*) self.superview;
    }
    return [self.superview parentCell];
}

@end
