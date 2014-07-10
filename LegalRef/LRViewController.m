//
//  LRViewController.m
//  LegalRef
//
//  Created by Sumedha Pramod on 7/8/14.
//  Copyright (c) 2014 Sumedha Pramod. All rights reserved.
//

#import "LRViewController.h"
#import <MCPanelViewController.h>
#import "ScholarSearchRequest.h"
#import "LRSearchResultsTableViewController.h"

@interface LRViewController ()

@end

@implementation LRViewController {
    NSArray *categories;
    MCPanelViewController *panelController;
    ScholarSearchRequest *searchRequest;
}

@synthesize tableView;
@synthesize searchbar;

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Add swipeGestures
    UISwipeGestureRecognizer *oneFingerSwipeLeft = [[UISwipeGestureRecognizer alloc]
                                                     initWithTarget:self
                                                     action:@selector(oneFingerSwipeLeft:)];
    [oneFingerSwipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [[self view] addGestureRecognizer:oneFingerSwipeLeft];

    //Searchbar
    [searchbar setDelegate:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController.navigationBar setHidden:YES];
    [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setTextColor:[UIColor whiteColor]];

    //Initialize Categories
    [self.view addSubview:tableView];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    categories = [[NSArray alloc] initWithArray:[NSArray arrayWithObjects:@"Administrative Law", @"Civil Procedure", @"Commercial Law", @"Constitutional Law", @"Contracts", @"Corporations", @"Criminal Law", @"Criminal Procedures", @"Ethics", @"Evidence", @"Family Law", @"Income Tax", @"Property", @"Torts", @"Wills, Trusts & Estates", @"International Law", @"Securities Regulation", @"Business Associations", @"Patent Law", nil]];

    //PanelViewController
    UIViewController *controller = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LRPanelViewController"];
    controller.preferredContentSize = CGSizeMake(200, 0);

    panelController = [[MCPanelViewController alloc] initWithRootViewController:controller];
    panelController.backgroundStyle = MCPanelBackgroundStyleExtraLight;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Swipe Gestures

- (void)oneFingerSwipeLeft:(UITapGestureRecognizer *)recognizer {
    [panelController presentInViewController:self.navigationController withDirection:MCPanelAnimationDirectionLeft];
}

- (IBAction)menuView:(id)sender {
    [panelController presentInViewController:self.navigationController withDirection:MCPanelAnimationDirectionLeft];
}

#pragma mark - Search Bar delegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"Querying on: %@", searchBar.text);
    searchRequest = [[ScholarSearchRequest alloc] init];
    [searchRequest search:searchBar.text];
    
    LRSearchResultsTableViewController *vc = [[LRSearchResultsTableViewController alloc] init];
    [vc setResults: [[NSArray alloc] initWithArray:[searchRequest getResults]]];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [categories count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"category_cell" forIndexPath:indexPath];

    // Configure the cell...
    cell.textLabel.text = [categories objectAtIndex:indexPath.row];

    return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation

 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
@end
