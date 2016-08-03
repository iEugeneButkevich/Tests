//
//  GroupWallViewController.m
//  APITest3
//
//  Created by Eugene Butkevich on 8/2/16.
//  Copyright © 2016 offsiteteam. All rights reserved.
//

#import "GroupWallViewController.h"
#import "ServerManager.h"
#import "Post.h"
#import "User.h"
#import "PostCell.h"

@interface GroupWallViewController ()

@property (strong, nonatomic) NSMutableArray* postsArray;
@property (assign, nonatomic) BOOL firstTimeAppear;

@end

@implementation GroupWallViewController

static NSInteger postsInRequest = 20;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.postsArray = [NSMutableArray array];
    self.firstTimeAppear = YES;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;  //Линии между строками в таблице убираются
    UIRefreshControl* refresh = [[UIRefreshControl alloc] init];
    [refresh addTarget:self action:@selector(refreshWall) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refresh;
    UIBarButtonItem* plus = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                          target:self
                                                                          action:@selector(postOnWall:)];
    self.navigationItem.rightBarButtonItem = plus;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - API

- (void) getPostsFromServer {
    [[ServerManager sharedManager] getGroupWall:@"58860049"
                                     withOffset: [self.postsArray count]
                                          count:postsInRequest
                                      onSuccess:^(NSArray *posts) {
                                          [self.postsArray addObjectsFromArray:posts];
                                          NSMutableArray* newPaths = [NSMutableArray array];
                                          for (int i = (int) [self.postsArray count] - (int) [posts count]; i < [self.postsArray count]; i++) {
                                              [newPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
                                          }
                                          [self.tableView beginUpdates];
                                          [self.tableView insertRowsAtIndexPaths:newPaths withRowAnimation:
                                           UITableViewRowAnimationTop];
                                          [self.tableView endUpdates];
                                      }
                                      onFailure:^(NSError *error) {
                                          NSLog(@"error = %@", [error localizedDescription]);
                                      }];
    
}

-(void) refreshWall {
    [[ServerManager sharedManager] getGroupWall:@"58860049"
                                     withOffset: 0
                                          count:MAX(postsInRequest, [self.postsArray count])
                                      onSuccess:^(NSArray *posts) {
                                          [self.postsArray removeAllObjects];
                                          [self.postsArray addObjectsFromArray:posts];
                                          [self.tableView reloadData];
                                          [self.refreshControl endRefreshing];
                                      }
                                      onFailure:^(NSError *error) {
                                          NSLog(@"error = %@", [error localizedDescription]);
                                          [self.refreshControl endRefreshing];
                                      }];
}

-(void) postOnWall:(id) sender {
    [[ServerManager sharedManager] postText:@"Сори за оффтоп. Урок номер 47 делаю :)"
                                onGroupWall:@"58860049"
                                  onSuccess:^(id result) {
                                      
                                  } onFailure:^(NSError *error) {
                                      
                                  }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.postsArray count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    if (indexPath.row == [self.postsArray count]) {
        static NSString* identifier = @"Cell";
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.textLabel.text = @"LOAD MORE";
        cell.imageView.image = nil;
        return  cell;
    } else {
        static NSString* identifier = @"PostCell";
        PostCell* postCell = [tableView dequeueReusableCellWithIdentifier:identifier];
        Post* post = [self.postsArray objectAtIndex:indexPath.row];
        postCell.postTextLabel.text = post.text;
        return  postCell;
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == [self.postsArray count]) {
        [self getPostsFromServer];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == [self.postsArray count]) {
        return 44.f;
    } else {
        Post* post = [self.postsArray objectAtIndex:indexPath.row];
        return [PostCell heightForText:post.text];
    }
}

@end
