//
//  EBDirectoryViewController.m
//  FileManagerTest
//
//  Created by DmitryMini on 6/21/16.
//  Copyright © 2016 offsiteteam. All rights reserved.
//

#import "EBDirectoryViewController.h"

@interface EBDirectoryViewController ()
@property(strong, nonatomic) NSString* path;
@property(strong, nonatomic) NSArray* contents;
@end

@implementation EBDirectoryViewController

- (id) initWithFolderPath: (NSString*) path {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        self.path = path;
        
        NSError* error = nil;
        self.contents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path
                                                                            error:&error];
        if (error) {
            NSLog(@"Error: %@", [error localizedDescription]);
        }
    }
    return self;
}

- (void) dealloc {
    NSLog(@"Controller with path %@ deallocated", self.path);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.navigationItem.title = [self.path lastPathComponent];    //Вместо "Back" будет название предыдущей папки
    
    if ([self.navigationController.viewControllers count] > 1) {
        UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithTitle:@"Back to Root"
                                                                 style: UIBarButtonItemStylePlain
                                                                target:self
                                                                action:@selector(actionBackToRoot:)];
        self.navigationItem.rightBarButtonItem = item;
    }
}

#pragma mark - Actions

- (void) actionBackToRoot:(UIBarButtonItem*) sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSLog(@"path = %@", self.path);
    NSLog(@"view controllers on stack: %lu",[self.navigationController.viewControllers count]);
    NSLog(@"index on stack: %lu", [self.navigationController.viewControllers indexOfObject:self]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL) isDirectoryAtINdexPath:(NSIndexPath*) indexPath {
    NSString* fileName = [self.contents objectAtIndex:indexPath.row];
    BOOL isDirectory = NO;
    NSString* filePath = [self.path stringByAppendingPathComponent:fileName];
    [[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&isDirectory];
    return isDirectory;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.contents count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSString* fileName = [self.contents objectAtIndex:indexPath.row];

    if ([self isDirectoryAtINdexPath:indexPath]) {
        cell.imageView.image = [UIImage imageNamed:@"folder.png"];
    } else {
        cell.imageView.image = [UIImage imageNamed:@"file.png"];
    }
    cell.textLabel.text = fileName;
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self isDirectoryAtINdexPath:indexPath]) {
        NSString* folderName = [self.contents objectAtIndex:indexPath.row];
        NSString* path = [self.path stringByAppendingPathComponent:folderName];
        EBDirectoryViewController* vc = [[EBDirectoryViewController alloc] initWithFolderPath:path];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
