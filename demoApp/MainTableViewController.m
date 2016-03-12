//
//  MainTableViewController.m
//  demoApp
//
//  Created by PETRONAS ICT SDN BHD on 3/3/16.
//  Copyright © 2016 myCompany. All rights reserved.
//

#import "MainTableViewController.h"
#import "ViewController.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "AppDelegate.h"
#import "AddEventViewController.h"


@interface MainTableViewController ()

@end

@implementation MainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if ([FBSDKAccessToken currentAccessToken]) {
        NSLog(@"already in");
    }
    else{
        UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"Main"
                                                      bundle:nil];
        
        ViewController *vc = [sb instantiateViewControllerWithIdentifier:@"loginview"];
        
        [self presentViewController:vc animated:YES completion:nil];
        
        
        NSLog(@"not yet");
    }
    
    [self performSelector:@selector(requestAccessToEvents) withObject:nil afterDelay:0.4];
    
    [self loadEventCalendars];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.arrCalendars.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }    // Configure the cell...
    
    EKCalendar *currentCalendar = [self.arrCalendars objectAtIndex:indexPath.row];
    
    cell.textLabel.text = currentCalendar.title;
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    EKEvent *currentCalendar = [self.arrCalendars objectAtIndex:indexPath.row];
    
    UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"Main"
                                                  bundle:nil];
    AddEventViewController *addvc = [sb instantiateViewControllerWithIdentifier:@"addview"];
    
    addvc.cal = currentCalendar;
    
    [self.navigationController pushViewController:addvc animated:YES];
    
    
    
    
    
}

-(void)requestAccessToEvents{
    
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    [delegate.eventManager.eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
        if (error == nil) {
            delegate.eventManager.eventsAccessGranted = granted;
        }
        else{
            // In case of error, just log its description to the debugger.
            NSLog(@"%@", [error localizedDescription]);
        }
    }];
}



-(void)loadEventCalendars{
    
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    self.arrCalendars = [delegate.eventManager getLocalEventCalendars];
    [self.tableView reloadData];
}




- (IBAction)addEventBtn:(id)sender {
    UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"Main"
                                                  bundle:nil];
    AddEventViewController *addvc = [sb instantiateViewControllerWithIdentifier:@"addview"];
    addvc.arrCalendars = self.arrCalendars;
    [self.navigationController pushViewController:addvc animated:YES];
    
}

- (IBAction)logoutBtn:(id)sender {
    
    [[FBSDKLoginManager new] logOut];
    
    UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"Main"
                                                  bundle:nil];
    
    ViewController *vc = [sb instantiateViewControllerWithIdentifier:@"loginview"];
    
    [self presentViewController:vc animated:YES completion:nil];
    
}
@end
