//
//  ServerManager.h
//  APITest
//
//  Created by Eugene Butkevich on 7/26/16.
//  Copyright © 2016 offsiteteam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface ServerManager : NSObject

@property (strong, nonatomic, readonly) User* currentUser;

+ (ServerManager*) sharedManager;

- (void) authorizeUser:(void(^)(User* user)) completion;

- (void) getFriendsWithOffset:(NSInteger) offset
                        count:(NSInteger) count
                    onSuccess:(void(^)(NSArray* friends)) success
                    onFailure:(void(^)(NSError* error)) failure;

- (void) getUser:(NSString*) userID
       onSuccess:(void(^)(User* user)) success
       onFailure:(void(^)(NSError* error)) failure;
@end
