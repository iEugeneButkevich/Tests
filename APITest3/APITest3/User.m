//
//  User.m
//  APITest
//
//  Created by Eugene Butkevich on 7/26/16.
//  Copyright © 2016 offsiteteam. All rights reserved.
//

#import "User.h"

@implementation User

- (id) initWithServerResponse:(NSDictionary*) responseObject
{
    self = [super initWithServerResponse:responseObject];
    if (self) {
        self.firstName = [responseObject objectForKey:@"first_name"];
        self.lastName = [responseObject objectForKey:@"last_name"];
        NSString* urlString = [responseObject objectForKey:@"photo_50"];
        if (urlString) {
            self.imageURL = [NSURL URLWithString:urlString];
        }
    }
    return self;
}

@end
