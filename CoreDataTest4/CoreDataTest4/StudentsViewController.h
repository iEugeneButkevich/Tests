//
//  StudentsViewController.h
//  CoreDataTest4
//
//  Created by DmitryMini on 7/1/16.
//  Copyright © 2016 offsiteteam. All rights reserved.
//

#import "CoreDataViewController.h"

@class Course;

@interface StudentsViewController : CoreDataViewController

@property (strong, nonatomic) Course* course;

@end
