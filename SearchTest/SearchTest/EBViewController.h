//
//  EBViewController.h
//  SearchTest
//
//  Created by Eugene on 6/25/16.
//  Copyright (c) 2016 EugeneButkevich. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EBViewController : UITableViewController <UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar* searchBar;
@end
