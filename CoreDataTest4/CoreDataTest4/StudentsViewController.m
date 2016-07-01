//
//  StudentsViewController.m
//  CoreDataTest4
//
//  Created by DmitryMini on 7/1/16.
//  Copyright © 2016 offsiteteam. All rights reserved.
//

#import "StudentsViewController.h"
#import "Course.h"
#import "Student.h"

@interface StudentsViewController ()

@end

@implementation StudentsViewController
@synthesize fetchedResultsController = _fetchedResultsController;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Student" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    [fetchRequest setFetchBatchSize:20];
    
    NSSortDescriptor *firstNameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"firstName" ascending:YES];
    NSSortDescriptor *lastNameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"lastName" ascending:YES];

    [fetchRequest setSortDescriptors:@[firstNameDescriptor, lastNameDescriptor]];
    
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"courses contains %@", self.course];
    [fetchRequest setPredicate:predicate];
    
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:@"university.name" cacheName:nil];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _fetchedResultsController;
}

#pragma mark - UITableViewDataSource

- (void)configureCell:(UITableViewCell *)cell withObject:(NSManagedObject *)object {
    Student* student = (Student*) object;
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", student.firstName, student.lastName];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%1@", student.score];
}

- (NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [sectionInfo name];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    Course* course = [self.fetchedResultsController objectAtIndexPath:indexPath];
//    StudentsViewController* vc = [[StudentsViewController alloc] init];
//    vc.course = course;
//    [self.navigationController pushViewController:vc animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
