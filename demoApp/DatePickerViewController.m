//
//  DatePickerViewController.m
//  demoApp
//
//  Created by PETRONAS ICT SDN BHD on 3/10/16.
//  Copyright © 2016 myCompany. All rights reserved.
//

#import "DatePickerViewController.h"
#import "AddEventViewController.h"

@interface DatePickerViewController ()

@end

@implementation DatePickerViewController
@synthesize datePick;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [datePick setDatePickerMode:UIDatePickerModeDateAndTime];
    [datePick setDate:[NSDate date]];
    
}

- (void) dateFromChangedValue {
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)Submit:(id)sender {
    
    NSDateFormatter *datFormatter = [[NSDateFormatter alloc] init];
    [datFormatter setDateFormat:@"yyyy-MM-dd hh:mm a"];
    
    if ([_type isEqualToString:@"start"]) {
        NSString *str = [NSString stringWithFormat:@"%@",[datFormatter stringFromDate:datePick.date]];
        [self.delegate myModalViewController:self didFinishSelecting:str withType:_type];
    }
    else if ([_type isEqualToString:@"end"]){
        NSString *str = [NSString stringWithFormat:@"%@",[datFormatter stringFromDate:datePick.date]];
        [self.delegate myModalViewController:self didFinishSelecting:str withType:_type];
        
    }
    
    
    
}

- (IBAction)cancelBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
