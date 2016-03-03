//
//  AppDelegate.h
//  demoApp
//
//  Created by PETRONAS ICT SDN BHD on 3/3/16.
//  Copyright © 2016 myCompany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "eventManager.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) eventManager *eventManager;


@end

