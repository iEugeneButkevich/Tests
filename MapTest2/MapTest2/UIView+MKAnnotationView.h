//
//  UIView+MKAnnotationView.h
//  MapTest2
//
//  Created by Eugene Butkevich on 8/10/16.
//  Copyright © 2016 offsiteteam. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MKAnnotationView;

@interface UIView (MKAnnotationView)

-(MKAnnotationView*) superAnnotationView;

@end
