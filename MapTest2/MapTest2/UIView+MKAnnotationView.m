//
//  UIView+MKAnnotationView.m
//  MapTest2
//
//  Created by Eugene Butkevich on 8/10/16.
//  Copyright © 2016 offsiteteam. All rights reserved.
//

#import "UIView+MKAnnotationView.h"
#import <MapKit/MKAnnotationView.h>

@implementation UIView (MKAnnotationView)

-(MKAnnotationView*) superAnnotationView {
    if ([self isKindOfClass:[MKAnnotationView class]]) {
        return (MKAnnotationView*) self;
    }
    if (!self.superview) {
        return  nil;
    }
    return [self.superview superAnnotationView];
}

@end
