//
//  ViewController.m
//  FontsTest
//
//  Created by DmitryMini on 6/14/16.
//  Copyright © 2016 offsiteteam. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Делаем отступ сверху 20:
//    UIEdgeInsets inset = UIEdgeInsetsMake(20, 0, 0, 0);
//    self.tableView.contentInset = inset;
//    self.tableView.scrollIndicatorInsets = inset;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

// Методы расположены в порядке их вызова
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSLog(@"numberOfSectionsInTableView: %lu",(unsigned long)[[UIFont familyNames] count]);
    return [[UIFont familyNames] count];
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSArray* familyNames = [UIFont familyNames];
    NSString* familyName = [familyNames objectAtIndex:section];
    return [NSString stringWithFormat:@"%@: ",familyName];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"numberOfRowsInSection: %ld",(long)section);
    NSArray* familyNames = [UIFont familyNames];
    NSString* familyName = [familyNames objectAtIndex:section];
    NSArray* fontNames = [UIFont fontNamesForFamilyName:familyName];
    return [fontNames count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"cellForRowAtIndexPath: {%ld,%ld}", (long)indexPath.section, (long)indexPath.row);
    
    //С помощью следующей конструкции не создаются постоянно новые ячейки, а используются уже созданные:
    static NSString* identifier = @"Cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        NSLog(@"Cell created");
    } else {
        NSLog(@"Cell reused");
    }
//    cell.textLabel.text = [NSString stringWithFormat:@"Section = %ld, Row = %ld", (long)indexPath.section, (long)indexPath.row];
    //
    
    NSArray* familyNames = [UIFont familyNames];
    NSString* familyName = [familyNames objectAtIndex:indexPath.section];
    NSArray* fontNames = [UIFont fontNamesForFamilyName:familyName];
    NSString* fontName = [fontNames objectAtIndex:indexPath.row];
    cell.textLabel.text = fontName;
    UIFont* font = [UIFont fontWithName:fontName size:16];
    cell.textLabel.font = font;
    
    return cell;
}

@end
