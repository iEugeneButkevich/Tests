//
//  EBDirectoryViewController.m
//  FileManagerWithStoryboardTest
//
//  Created by DmitryMini on 6/22/16.
//  Copyright © 2016 offsiteteam. All rights reserved.
//

#import "EBDirectoryViewController.h"
#import "EBFileCell.h"
#import "UIView+UITableViewCell.h"

@interface EBDirectoryViewController ()
@property(strong, nonatomic) NSArray* contents;
@property(strong, nonatomic) NSString* selectedPath;
@end

@implementation EBDirectoryViewController

- (id) initWithFolderPath: (NSString*) path {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        self.path = path;
    }
    return self;
}

- (void) setPath:(NSString *)path {
    _path = path;
    
    NSError* error = nil;
    self.contents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path
                                                                        error:&error];
    if (error) {
        NSLog(@"Error: %@", [error localizedDescription]);
    }
    [self.tableView reloadData];
    
    //    self.navigationItem.title = [self.path lastPathComponent];    //Вместо "Back" будет название предыдущей папки

}

- (void) dealloc {
    NSLog(@"Controller with path %@ deallocated", self.path);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (!self.path) {
        self.path = @"/Users/dmitry/Downloads";
    }
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([self.navigationController.viewControllers count] > 1) {
        UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithTitle:@"Back to Root"
                                                                 style: UIBarButtonItemStylePlain
                                                                target:self
                                                                action:@selector(actionBackToRoot:)];
        self.navigationItem.rightBarButtonItem = item;
    }
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

#pragma mark - Actions

- (void) actionBackToRoot:(UIBarButtonItem*) sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction) actionInfoCell: (id)sender {
    NSLog(@"actionInfoCell");
    UITableViewCell* cell = [sender parentCell];
    if (cell) {
        NSIndexPath* indexPath = [self.tableView indexPathForCell:cell];
        UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"Yahoo!"
                                             message:[NSString stringWithFormat:@"action %ld %ld", (long)indexPath.section, (long)indexPath.row]
                                      preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* alertAction = [UIAlertAction actionWithTitle:@"OK"
                                                              style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction * _Nonnull action) {
                                                                [alertController dismissViewControllerAnimated:YES completion:nil];
                                                            }];
        [alertController addAction:alertAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

- (NSString*) fileSizeFromValue: (unsigned long long) size {
    
    static NSString* units[] = {@"B", @"KB",@"MB",@"GB", @"TB"};
    static int unitsCount = 5;
    double fileSize = (double) size;
    int index = 0;
    
    while (fileSize > 1024 && index < unitsCount) {
        fileSize /= 1024;
        index++;
    }
    return [NSString stringWithFormat:@"%.2f %@", fileSize, units[index]];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.contents count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* fileIdentifier = @"FileCell";
    static NSString* folderIdentifier = @"FolderCell";

    NSString* fileName = [self.contents objectAtIndex:indexPath.row];

    if ([self isDirectoryAtINdexPath:indexPath]) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: folderIdentifier];
        cell.textLabel.text = fileName;
        return cell;
    } else {
        NSString* path = [self.path stringByAppendingPathComponent:fileName];
        NSDictionary* attributes = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil];
        EBFileCell *cell = [tableView dequeueReusableCellWithIdentifier: fileIdentifier];
        cell.nameLabel.text = fileName;
        cell.sizeLabel.text = [self fileSizeFromValue:[attributes fileSize]];
        
        static NSDateFormatter* dateFormatter = nil;
        if (!dateFormatter) {
            dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"MM/dd/yyyy hh:mm a"];
        }
        cell.dateLabel.text = [dateFormatter stringFromDate:[attributes fileModificationDate]];
        return cell;
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self isDirectoryAtINdexPath:indexPath]) {
        return 44.f;
    } else {
        return 80.f;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self isDirectoryAtINdexPath:indexPath]) {
        NSString* folderName = [self.contents objectAtIndex:indexPath.row];
        NSString* path = [self.path stringByAppendingPathComponent:folderName];

//        EBDirectoryViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"EBDirectoryViewController"];
//        vc.path = path;
//        [self.navigationController pushViewController:vc animated:YES];
        
        self.selectedPath = path;
        
        [self performSegueWithIdentifier:@"navigateDeep" sender:nil];
    }
}

#pragma mark - Segue

- (BOOL) shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    NSLog(@"shouldPerformSegueWithIdentifier: %@", identifier);
    return  YES;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"prepareForSegue: %@", segue.identifier);
    EBDirectoryViewController* vc = segue.destinationViewController;
    vc.path = self.selectedPath;
}

@end
