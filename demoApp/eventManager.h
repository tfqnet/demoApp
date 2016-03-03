//
//  eventManager.h
//  demoApp
//
//  Created by PETRONAS ICT SDN BHD on 3/3/16.
//  Copyright © 2016 myCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
@import EventKit;

@interface eventManager : NSObject

@property (nonatomic, strong) EKEventStore *eventStore;
@property (nonatomic) BOOL eventsAccessGranted;
-(NSArray *)getLocalEventCalendars;

-(NSArray *)getEventsOfSelectedCalendar;

@end
