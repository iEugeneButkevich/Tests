//
//  ViewController.m
//  APITest
//
//  Created by Eugene Butkevich on 7/26/16.
//  Copyright © 2016 offsiteteam. All rights reserved.
//

#import "FriiendsTableViewController.h"
#import "ServerManager.h"
#import "User.h"
#import "UIImageView+AFNetworking.h"

@interface FriiendsTableViewController ()

@property (strong, nonatomic) NSMutableArray* friendsArray;
@property (assign, nonatomic) BOOL firstTimeAppear;

@end

@implementation FriiendsTableViewController

static NSInteger friendsInRequest = 20;

- (void)viewDidLoad {
    [super viewDidLoad];

    self.friendsArray = [NSMutableArray array];
//    [self getFriendsFromServer];
    
    self.firstTimeAppear = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (self.firstTimeAppear) {
        self.firstTimeAppear = NO;
        [[ServerManager sharedManager] authorizeUser:^(User *user) {
            NSLog(@"AUTHORIZED!");
            NSLog(@"%@ %@", user.firstName, user.lastName);
        }];
    }
}

#pragma mark - API

- (void) getFriendsFromServer {
    [[ServerManager sharedManager] getFriendsWithOffset:[self.friendsArray count]
                                                  count:friendsInRequest
                                              onSuccess:^(NSArray *friends) {
                                                        [self.friendsArray addObjectsFromArray:friends];
                                                        NSMutableArray* newPaths = [NSMutableArray array];
                                                        for (int i = (int) [self.friendsArray count] - (int) [friends count]; i < [self.friendsArray count]; i++) {
                                                                [newPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
                                                            }
                                                        [self.tableView beginUpdates];
                                                        [self.tableView insertRowsAtIndexPaths:newPaths withRowAnimation:UITableViewRowAnimationTop];
                                                        [self.tableView endUpdates];
                                              }
                                              onFailure:^(NSError *error) {
                                                  NSLog(@"error = %@", [error localizedDescription]);
                                              }];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.friendsArray count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* identifier = @"Cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if (indexPath.row == [self.friendsArray count]) {
        cell.textLabel.text = @"LOAD MORE";
        cell.imageView.image = nil;
    } else {
        User* friend = [self.friendsArray objectAtIndex:indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@ %@",  friend.firstName, friend.lastName];
//        [cell.imageView setImageWithURL:friend.imageURL];
        // or:
        NSURLRequest* request = [NSURLRequest requestWithURL:friend.imageURL];
        cell.imageView.image = nil;
        __weak UITableViewCell*  weakCell = cell;
        [cell.imageView setImageWithURLRequest:request
                              placeholderImage:nil
                                       success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
                                           weakCell.imageView.image = image;
                                           [weakCell layoutSubviews];
                                       } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
                                           
                                       }];
    }
    return  cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == [self.friendsArray count]) {
        [self getFriendsFromServer];
    }
}

@end
