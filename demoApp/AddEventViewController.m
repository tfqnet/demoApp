//
//  AddEventViewController.m
//  demoApp
//
//  Created by PETRONAS ICT SDN BHD on 3/3/16.
//  Copyright © 2016 myCompany. All rights reserved.
//

#import "AddEventViewController.h"
#import "DatePickerViewController.h"
#import "ActionSheetDatePicker.h"
#import "AppDelegate.h"

@interface AddEventViewController ()

@end

@implementation AddEventViewController
@synthesize cal,titleText,descText,startDate,endDate,picImgView,sendInvite;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"cal %@",cal);
    // EKEvent *event = [EKEvent;
    
    titleText.text = cal.title;
    descText.text = cal.notes;
    //startDate = cal.startDate;
    //endDate = cal.endDate;
    
    
    NSDateFormatter *datFormatter = [[NSDateFormatter alloc] init];
    [datFormatter setDateFormat:@"yyyy-MM-dd hh:mm a"];
    
    NSLog(@"date: %@", [datFormatter stringFromDate:cal.startDate]);
    NSString *st = [NSString stringWithFormat:@"%@",[datFormatter stringFromDate:cal.startDate]];
    NSString *en = [NSString stringWithFormat:@"%@", [datFormatter stringFromDate:cal.endDate]];
    startDate.text = st;
    endDate.text = en;
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)addStartDate:(id)sender {
    
    
    
    
    UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"Main"
                                                  bundle:nil];
    
    DatePickerViewController *datevc = [sb instantiateViewControllerWithIdentifier:@"pickerview"];
    datevc.delegate = self;
    datevc.type = @"start";
    
    
    [self presentViewController:datevc animated:YES completion:nil];
    
}

- (IBAction)addEndDate:(id)sender {
    UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"Main"
                                                  bundle:nil];
    DatePickerViewController *datevc = [sb instantiateViewControllerWithIdentifier:@"pickerview"];
    datevc.type = @"end";
    datevc.delegate = self;
    
    [self presentViewController:datevc animated:YES completion:nil];
}

- (void)myModalViewController:(DatePickerViewController *)controller didFinishSelecting:(NSString *)selectedString withType:(NSString *)type
{
    if([type isEqualToString:@"start"]){
        startDate.text = selectedString;
    }
    else if ([type isEqualToString:@"end"]){
        endDate.text = selectedString;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (IBAction)addPic:(id)sender {
    UIImagePickerController * imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:YES completion:nil];
    
}

- (IBAction)addEvent:(id)sender {
    
    
    
    NSDateFormatter *datFormatter = [[NSDateFormatter alloc] init];
    [datFormatter setDateFormat:@"yyyy-MM-dd hh:mm a"];
    NSLog(@"star %@",startDate.text);
    
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    
    
    [delegate.eventManager.eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
        if (!granted) { return; }
        EKEvent *event = [EKEvent eventWithEventStore:delegate.eventManager.eventStore];
        event.title = titleText.text;
        event.notes = descText.text;
        //event.startDate = [NSDate date]; //today
        //event.endDate = [event.startDate dateByAddingTimeInterval:60*60];
        event.startDate = [datFormatter dateFromString:startDate.text];//[NSDate date]; //today
        event.endDate = [datFormatter dateFromString:endDate.text];
        event.calendar = [delegate.eventManager.eventStore defaultCalendarForNewEvents];
        NSError *err = nil;
        
        NSLog(@"%@",event.startDate);
        
        
        
        NSPredicate *predicate = [delegate.eventManager.eventStore predicateForEventsWithStartDate:event.startDate endDate:event.endDate calendars:self.arrCalendars];
        
        
        // Get an array with all events.
        NSArray *eventsArray = [delegate.eventManager.eventStore eventsMatchingPredicate:predicate];
        NSLog(@"event %@",eventsArray);
        
        
        [delegate.eventManager.eventStore saveEvent:event span:EKSpanThisEvent commit:YES error:&err];
        
        
        NSLog(@"added %@", err);
    }];
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    
    
    NSLog(@"here");
    
    [self dismissViewControllerAnimated:YES completion:^{
        UIImage * image = [info objectForKey:UIImagePickerControllerOriginalImage];
        picImgView.image = image;
        
    }];
    
}

- (BOOL)date:(NSDate*)date isBetweenDate:(NSDate*)beginDate andDate:(NSDate*)endDate1
{
    if ([date compare:beginDate] == NSOrderedAscending)
        return NO;
    
    if ([date compare:endDate1] == NSOrderedDescending)
        return NO;
    
    return YES;
}

@end
