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
    tableView.editing = NO;
//    tableView.allowsSelectionDuringEditing = YES;   // Теперь можно выделять ячейку и в режиме редактирования
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.groups = [NSMutableArray array];
    
    // Рандомное инициализация групп и студентов:
//    for (int i = 0; i < ((arc4random() % 6) + 5); i++) {    //j = 5..10
//        EBGroup* group = [[EBGroup alloc] init];
//        group.name = [NSString stringWithFormat:@"group #%d", i];
//        NSMutableArray* array = [NSMutableArray array];
//
//        for (int j = 0; j < ((arc4random() % 11) + 15); j++) {  //j = 15..25
//            [array addObject: [EBStudent randomStudent]];
//        }
//        group.students = array;
//        [self.groups addObject: group];
//    }
    
    self.navigationItem.title = @"Students";
    
    UIBarButtonItem* editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editAction:)];
    self.navigationItem.rightBarButtonItem = editButton;
    
    UIBarButtonItem* addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(actionAddSection:)];
    [self.navigationItem setLeftBarButtonItem:addButton animated:YES];

}

#pragma mark - Actions
-(void) editAction: (UIBarButtonItem*) sender{
    BOOL isEditing = self.tableView.editing;
    [self.tableView setEditing:!isEditing animated:YES];
    UIBarButtonSystemItem item = UIBarButtonSystemItemEdit;
    if (isEditing) {
        item = UIBarButtonSystemItemDone;
    }
    UIBarButtonItem* editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:item target:self action:@selector(editAction:)];
    [self.navigationItem setRightBarButtonItem:editButton animated:YES];
}

-(void) actionAddSection: (UIBarButtonSystemItem*) sender {
    EBGroup* group = [[EBGroup alloc] init];
    group.name = [NSString stringWithFormat:@"group #%lu", [self.groups count] + 1];
    group.students = @[[EBStudent randomStudent], [EBStudent randomStudent]];
    NSInteger newSectionIndex = 0;
    [self.groups insertObject:group atIndex:newSectionIndex];
//    [self.tableView reloadData];      - Это топорный способ для обновления содержимого таблицы. Далее более правильный показан:
    
    [self.tableView beginUpdates];
    NSIndexSet* insertSections = [NSIndexSet indexSetWithIndex:newSectionIndex];
    UITableViewRowAnimation animation = UITableViewRowAnimationFade;
    if ([self.groups count] > 1){
        animation = [self.groups count] % 2 ? UITableViewRowAnimationLeft: UITableViewRowAnimationRight;
    }
    [self.tableView insertSections: insertSections
                  withRowAnimation: animation];
    [self.tableView endUpdates];
    // После нажатия на addButton для добаления секции во избежание глюков можно отключить обработку приложением нажатий на некоторое время:
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if ([[UIApplication sharedApplication] isIgnoringInteractionEvents]){
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        }});
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
    return [group.students count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        static NSString* addStudentIdentifier = @"AddStudentCell";
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:addStudentIdentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:addStudentIdentifier];
            cell.textLabel.textColor = [UIColor blueColor];
            cell.textLabel.text = @"Tap to add new student";
        }
        return cell;
    } else {
        static NSString* studentIdentifier = @"StudentCell";
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:studentIdentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:studentIdentifier];
        }
        EBGroup* group = [self.groups objectAtIndex:indexPath.section];
        EBStudent* student = [group.students objectAtIndex:indexPath.row - 1];
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
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath.row > 0;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    EBGroup* sourceGroup = [self.groups objectAtIndex: sourceIndexPath.section];
    EBStudent* student = [sourceGroup.students objectAtIndex:sourceIndexPath.row - 1];
    NSMutableArray* tempArray = [NSMutableArray arrayWithArray:sourceGroup.students];
    
    if (sourceIndexPath.section == destinationIndexPath.section){
        [tempArray exchangeObjectAtIndex:sourceIndexPath.row -1 withObjectAtIndex:destinationIndexPath.row - 1];
        sourceGroup.students = tempArray;
    } else {
        [tempArray removeObject:student];
        sourceGroup.students = tempArray;
        
        EBGroup* destinationGroup = [self.groups objectAtIndex: destinationIndexPath.section];
        tempArray = [NSMutableArray arrayWithArray:destinationGroup.students];
        [tempArray insertObject:student atIndex:destinationIndexPath.row - 1];
        destinationGroup.students = tempArray;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        EBGroup* sourceGroup = [self.groups objectAtIndex: indexPath.section];
        EBStudent* student = [sourceGroup.students objectAtIndex:indexPath.row - 1];
        NSMutableArray* tempArray = [NSMutableArray arrayWithArray:sourceGroup.students];
        [tempArray removeObject:student];
        sourceGroup.students = tempArray;
        [tableView beginUpdates];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [tableView endUpdates];
    }
}


#pragma mark - UITableViewDelegate

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{ // рандомные значки слева:
//    return ((arc4random() % 1000) / 500) ? UITableViewCellEditingStyleInsert : UITableViewCellEditingStyleDelete;
    return indexPath.row == 0 ? UITableViewCellEditingStyleNone : UITableViewCellEditingStyleDelete;
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"Remove";
}

- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath{
    if (proposedDestinationIndexPath.row == 0) {
        return sourceIndexPath;
    } else {
        return proposedDestinationIndexPath;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0){
        EBGroup* group = [self.groups objectAtIndex:indexPath.section];
        NSMutableArray* tempArray = nil;
        if (group.students) {
            tempArray = [NSMutableArray arrayWithArray:group.students];
        } else {
            tempArray = [NSMutableArray array];
        }
        
        NSInteger newStudentIndex = 0;
        [tempArray insertObject:[EBStudent randomStudent] atIndex:newStudentIndex];
        group.students = tempArray;
        [self.tableView beginUpdates];
        NSIndexPath* newIndexPath = [NSIndexPath indexPathForItem:newStudentIndex + 1 inSection:indexPath.section];
        [self.tableView insertRowsAtIndexPaths:@[newIndexPath]
                              withRowAnimation:UITableViewRowAnimationLeft];
        [self.tableView endUpdates];
        // После нажатия на addButton для добаления секции во избежание глюков можно отключить обработку приложением нажатий на некоторое время:
        [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if ([[UIApplication sharedApplication] isIgnoringInteractionEvents]){
                [[UIApplication sharedApplication] endIgnoringInteractionEvents];
            }});
    }
}


@end
