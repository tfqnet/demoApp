//
//  ViewController.m
//  demoApp
//
//  Created by PETRONAS ICT SDN BHD on 3/3/16.
//  Copyright © 2016 myCompany. All rights reserved.
//

#import "ViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
      // Do any additional setup after loading the view, typically from a nib.
}



- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if ([FBSDKAccessToken currentAccessToken]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)signUpBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)loginBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
