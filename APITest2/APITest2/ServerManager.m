//
//  ServerManager.m
//  APITest
//
//  Created by Eugene Butkevich on 7/26/16.
//  Copyright © 2016 offsiteteam. All rights reserved.
//

#import "ServerManager.h"
#import "AFNetworking.h"
#import "LoginViewController.h"
#import "AccessToken.h"

@interface ServerManager ()
@property (strong, nonatomic) AFHTTPSessionManager* sessionManager;
@property (strong, nonatomic) AccessToken* accessToken;
@end

@implementation ServerManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSURL* url = [NSURL URLWithString:@"https://api.vk.com/method"];
        self.sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
    }
    return self;
}

+ (ServerManager*) sharedManager {
    static ServerManager* manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ServerManager alloc] init];
    });
    return manager;
}

- (void) authorizeUser:(void(^)(User* user)) completion {
    LoginViewController* vc = [[LoginViewController alloc] initWithCompletionBlock:^(AccessToken *token) {
        self.accessToken = token;
        if (token) {
            [self getUser:self.accessToken.userID
                onSuccess:^(User *user) {
                    if (completion) {
                        completion(user);
                    }
                } onFailure:^(NSError *error) {
                    if (completion) {
                        completion(nil);
                    }
                }];
        } else if (completion) {
            completion(nil);
        }
    }];
    UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:vc];
    UIViewController* mainVC = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    [mainVC presentViewController:nav animated:YES completion:nil];
    
}

- (void) getFriendsWithOffset:(NSInteger) offset
                        count:(NSInteger) count
                    onSuccess:(void(^)(NSArray* friends)) success
                    onFailure:(void(^)(NSError* error)) failure {
    
    NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:  @"4111910", @"user_id",
                                                                        @"name", @"order",
                                                                        @(count), @"count",
                                                                        @(offset), @"offset",
                                                                        @"photo_50", @"fields",
                                                                        @"nom", @"name_case", nil];
    
    [self.sessionManager GET:@"friends.get"
                  parameters:params
                    progress:^(NSProgress * _Nonnull downloadProgress) {
                        
                    }
                     success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary* responseObject) {
                         NSLog(@"JSON: %@", responseObject);
                         NSArray* dictionaryArray = [responseObject objectForKey:@"response"];
                         NSMutableArray* objectsArray = [NSMutableArray array];
                         for (NSDictionary* dictionary in dictionaryArray) {
                             User* user = [[User alloc] initWithServerResponse:dictionary];
                             [objectsArray addObject:user];
                         }
                         if (success) {
                             success(objectsArray);
                         }
                     }
                     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                         NSLog(@"Error: %@", error);
                         if (failure) {
                             failure(error);
                         }
                     }];
}

- (void) getUser:(NSString*) userID
       onSuccess:(void(^)(User* user)) success
       onFailure:(void(^)(NSError* error)) failure {
    NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:  userID, @"user_ids",
                            @"photo_50", @"fields",
                            @"nom", @"name_case", nil];
    
    [self.sessionManager GET:@"users.get"
                  parameters:params
                    progress:^(NSProgress * _Nonnull downloadProgress) {
                        
                    }
                     success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary* responseObject) {
                         NSLog(@"JSON: %@", responseObject);
                         NSArray* dictionaryArray = [responseObject objectForKey:@"response"];
                         if ([dictionaryArray count] > 0) {
                             User* user = [[User alloc] initWithServerResponse:[dictionaryArray firstObject]];
                             if (success) {
                                 success(user);
                             }
                         } else if (failure) {
                             failure(nil);
                         }
                     }
                     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                         NSLog(@"Error: %@", error);
                         if (failure) {
                             failure(error);
                         }
                     }];
}

@end
