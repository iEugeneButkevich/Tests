//
//  Post.m
//  APITest3
//
//  Created by Eugene Butkevich on 8/2/16.
//  Copyright © 2016 offsiteteam. All rights reserved.
//

#import "Post.h"

@implementation Post

- (id) initWithServerResponse:(NSDictionary*) responseObject
{
    self = [super initWithServerResponse:responseObject];
    if (self) {
        self.text = [responseObject objectForKey:@"text"];
        self.text = [self.text stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"];
    }
    return self;
}

@end
