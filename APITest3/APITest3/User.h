//
//  User.h
//  APITest
//
//  Created by Eugene Butkevich on 7/26/16.
//  Copyright © 2016 offsiteteam. All rights reserved.
//

#import "ServerObject.h"

@interface User : ServerObject

@property (strong, nonatomic) NSString* firstName;
@property (strong, nonatomic) NSString* lastName;
@property (strong, nonatomic) NSURL* imageURL;

@end
