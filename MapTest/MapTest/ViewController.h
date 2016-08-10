//
//  ViewController.h
//  MapTest
//
//  Created by Eugene Butkevich on 8/9/16.
//  Copyright © 2016 offsiteteam. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MKMapView;

@interface ViewController : UIViewController

@property(weak, nonatomic) IBOutlet MKMapView* mapView;

@end

