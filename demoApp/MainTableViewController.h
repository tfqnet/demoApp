//
//  MainTableViewController.h
//  demoApp
//
//  Created by PETRONAS ICT SDN BHD on 3/3/16.
//  Copyright © 2016 myCompany. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface MainTableViewController : UITableViewController
- (IBAction)addEventBtn:(id)sender;
- (IBAction)logoutBtn:(id)sender;
-(void)requestAccessToEvents;


@property (nonatomic, strong) NSArray *arrCalendars;

-(void)loadEventCalendars;





@end
