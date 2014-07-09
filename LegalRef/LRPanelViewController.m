//
//  LRPanelViewController.m
//  LegalRef
//
//  Created by Sumedha Pramod on 7/8/14.
//  Copyright (c) 2014 Sumedha Pramod. All rights reserved.
//

#import "LRPanelViewController.h"
#import <MGImageUtilities/UIImage+Tint.h>

@interface LRPanelViewController ()

@end

@implementation LRPanelViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.opaque = NO;
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lawlibrary-menu"]];

    [self.navigationController.navigationBar setHidden:YES];

    //tint images
    [_saved.image imageTintedWithColor:[UIColor whiteColor]];
    [_history.image imageTintedWithColor:[UIColor whiteColor]];
    [_about.image imageTintedWithColor:[UIColor whiteColor]];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{

    cell.backgroundColor = [UIColor clearColor];
    cell.backgroundView.backgroundColor = [UIColor clearColor];
}

@end
