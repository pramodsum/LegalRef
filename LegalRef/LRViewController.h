//
//  LRViewController.h
//  LegalRef
//
//  Created by Sumedha Pramod on 7/8/14.
//  Copyright (c) 2014 Sumedha Pramod. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LRViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UIGestureRecognizerDelegate> {
    UITableView *tableView;
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UISearchBar *searchbar;

@end
