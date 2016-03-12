//
//  AddEventViewController.h
//  demoApp
//
//  Created by PETRONAS ICT SDN BHD on 3/3/16.
//  Copyright © 2016 myCompany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatePickerViewController.h"
@import EventKit;
@class AbstractActionSheetPicker;
@interface AddEventViewController : UIViewController<MyModalViewControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    
}
@property (nonatomic, strong) NSArray *arrCalendars;
@property (weak, nonatomic) IBOutlet UITextField *titleText;
@property (weak, nonatomic) IBOutlet UITextField *descText;
@property (weak, nonatomic) IBOutlet UILabel *startDate;
@property (weak, nonatomic) IBOutlet UILabel *endDate;
@property (weak, nonatomic) IBOutlet UIImageView *picImgView;
@property (nonatomic, strong) AbstractActionSheetPicker *actionSheetPicker;

@property (nonatomic,strong) EKEvent *cal;

- (IBAction)addStartDate:(id)sender;
- (IBAction)addEndDate:(id)sender;
- (IBAction)addPic:(id)sender;
- (IBAction)addEvent:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *sendInvite;

@end
