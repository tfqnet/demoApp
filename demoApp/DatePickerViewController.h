//
//  DatePickerViewController.h
//  demoApp
//
//  Created by PETRONAS ICT SDN BHD on 3/10/16.
//  Copyright © 2016 myCompany. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyModalViewControllerDelegate;

@interface DatePickerViewController : UIViewController{
    id <MyModalViewControllerDelegate> delegate;
}


@property (assign) id <MyModalViewControllerDelegate> delegate;


@property (weak, nonatomic) IBOutlet UIDatePicker *datePick;
@property (nonatomic,strong)NSString *type;
- (IBAction)Submit:(id)sender;
- (IBAction)cancelBtn:(id)sender;
@end

@protocol MyModalViewControllerDelegate <NSObject>

@optional

- (void)myModalViewController:(DatePickerViewController *)controller didFinishSelecting:(NSString *)selectedString withType:(NSString *)type;

@end