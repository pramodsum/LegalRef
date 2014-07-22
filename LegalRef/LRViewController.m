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
#import <TBXML+NSDictionary.h>
#import "LRCaseObject.h"

@interface LRViewController ()

@property (nonatomic, strong) IBOutlet UITapGestureRecognizer *tapRecognizer;
@property (nonatomic, strong) IBOutlet UISwipeGestureRecognizer *swipeRightRecognizer;
@property (nonatomic, strong) IBOutlet UISegmentedControl *segmentedControl;

@end

@implementation LRViewController {
    NSArray *categories;
    MCPanelViewController *panelController;
    ScholarSearchRequest *searchRequest;
    NSMutableArray *case_results;
}

@synthesize tableView;
@synthesize searchbar;

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Add swipeGestures
    UISwipeGestureRecognizer *gestureRight;
    gestureRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRight:)];//direction is set by default.
    //[gesture setNumberOfTouchesRequired:1];//default is 1
    [[self view] addGestureRecognizer:gestureRight];//this gets things rolling.

    //Searchbar
    [searchbar setDelegate:self];
}

- (void)viewWillAppear:(BOOL)animated {
    //[self.navigationController.navigationBar setHidden:YES];
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

- (void)swipeRight:(UISwipeGestureRecognizer *)gesture
{
    NSLog(@"Right Swipe received.");//Lets you know this method was called by gesture recognizer.for confirmation (1=right).
    //only interested in gesture if gesture state == changed or ended (From Paul Hegarty @ standford U
    if ((gesture.state == UIGestureRecognizerStateChanged) ||
        (gesture.state == UIGestureRecognizerStateEnded)) {
        [panelController presentInViewController:self.navigationController withDirection:MCPanelAnimationDirectionLeft];
    }
}

#pragma mark - Search Bar delegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"Querying on: %@", searchBar.text);
    searchRequest = [[ScholarSearchRequest alloc] init];

    NSURLRequest * urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.casebriefs.com/?s=%@&feed=rss2", searchBar.text]]];

    case_results = [[NSMutableArray alloc] init];

    [NSURLConnection sendAsynchronousRequest:urlRequest queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {

        if (!error) {
            NSDictionary *dict = [TBXML dictionaryWithXMLData:data error:&error];
            NSDictionary *results = [[[dict objectForKey:@"rss"] objectForKey:@"channel"] objectForKey:@"item"];
            //            NSLog(@"Results: %@", results);
            for(NSDictionary *caseResult in results) {
                //                NSLog(@"%@", caseResult);
                LRCaseObject *caseItem = [[LRCaseObject alloc] initFromCaseBriefs:caseResult];
                [case_results addObject:caseItem];
            }
            //            NSLog(@"%@", case_results);

            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [self performSegueWithIdentifier:@"search_results_segue" sender:self];
            }];
        } else {
            NSLog(@"ERROR: %@", error);
        }
    }];


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

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([[segue identifier] isEqual: @"search_results_segue"]) {
        LRSearchResultsTableViewController *vc = [[LRSearchResultsTableViewController alloc] init];
        NSLog(@"%lu results found.", (unsigned long)[case_results count]);
        [vc setResults: [[NSArray alloc] initWithArray:case_results]];
    }
}

@end
