//
//  EBViewController.m
//  TableEditingTest
//
//  Created by Eugene on 6/15/16.
//  Copyright (c) 2016 EugeneButkevich. All rights reserved.
//

#import "EBViewController.h"
#import "EBStudent.h"
#import "EBGroup.h"

@interface EBViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) UITableView* tableView;
@property (strong, nonatomic) NSMutableArray* groups;
@end

@implementation EBViewController

-(void) loadView{
    [super loadView];
    
    CGRect frame = self.view.bounds;
    frame.origin = CGPointZero;
    UITableView* tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
    tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    tableView.delegate = self;
    tableView.dataSource = self;
    
    [self.view addSubview:tableView];
    self.tableView = tableView;
    tableView.editing = YES;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.groups = [NSMutableArray array];
    for (int i = 0; i < ((arc4random() % 6) + 5); i++) {    //j = 5..10
        EBGroup* group = [[EBGroup alloc] init];
        group.name = [NSString stringWithFormat:@"group #%d", i];
        NSMutableArray* array = [NSMutableArray array];

        for (int j = 0; j < ((arc4random() % 11) + 15); j++) {  //j = 15..25
            [array addObject: [EBStudent randomStudent]];
        }
        group.students = array;
        [self.groups addObject: group];
    }
    
    self.view.backgroundColor = [UIColor redColor];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.groups count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [[self.groups objectAtIndex:section] name];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    EBGroup* group = [self.groups objectAtIndex:section];
    return [group.students count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* identifier = @"Cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    EBGroup* group = [self.groups objectAtIndex:indexPath.section];
    EBStudent* student = [group.students objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@, %@", student.firstName, student.lastName];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%1.2f", student.averageGrade];
    if (student.averageGrade >= 4.f){
        cell.detailTextLabel.textColor = [UIColor greenColor];
    } else if (student.averageGrade >= 3.f){
        cell.detailTextLabel.textColor = [UIColor orangeColor];
    } else {
        cell.detailTextLabel.textColor = [UIColor redColor];
    }
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    EBGroup* sourceGroup = [self.groups objectAtIndex: sourceIndexPath.section];
    EBStudent* student = [sourceGroup.students objectAtIndex:sourceIndexPath.row];
    NSMutableArray* tempArray = [NSMutableArray arrayWithArray:sourceGroup.students];
    
    if (sourceIndexPath.section == destinationIndexPath.section){
        [tempArray exchangeObjectAtIndex:sourceIndexPath.row withObjectAtIndex:destinationIndexPath.row];
        sourceGroup.students = tempArray;
    } else {
        [tempArray removeObject:student];
        sourceGroup.students = tempArray;
        
        EBGroup* destinationGroup = [self.groups objectAtIndex: destinationIndexPath.section];
        tempArray = [NSMutableArray arrayWithArray:destinationGroup.students];
        [tempArray insertObject:student atIndex:destinationIndexPath.row];
        destinationGroup.students = tempArray;
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{ // рандомные значки слева
    return ((arc4random() % 1000) / 500) ? UITableViewCellEditingStyleInsert : UITableViewCellEditingStyleDelete;
}

@end
