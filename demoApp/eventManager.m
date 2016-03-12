//
//  eventManager.m
//  demoApp
//
//  Created by PETRONAS ICT SDN BHD on 3/3/16.
//  Copyright © 2016 myCompany. All rights reserved.
//

#import "eventManager.h"

@implementation eventManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.eventStore = [[EKEventStore alloc] init];
        
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        
        
        if ([userDefaults valueForKey:@"eventkit_events_access_granted"] != nil) {
            
            self.eventsAccessGranted = [[userDefaults valueForKey:@"eventkit_events_access_granted"] intValue];
        }
        else{
            
            self.eventsAccessGranted = NO;
        }
    }
    return self;
}


-(void)setEventsAccessGranted:(BOOL)eventsAccessGranted{
    _eventsAccessGranted = eventsAccessGranted;
    
    [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithBool:eventsAccessGranted] forKey:@"eventkit_events_access_granted"];
}

-(NSArray *)getLocalEventCalendars{
    NSArray *allCalendars = [self.eventStore calendarsForEntityType:EKEntityTypeEvent];
    NSMutableArray *localCalendars = [[NSMutableArray alloc] init];
    
    
    
    
    
    for (int i=0; i<allCalendars.count; i++) {
        EKCalendar *currentCalendar = [allCalendars objectAtIndex:i];
        
        
        
        if(currentCalendar.type==EKCalendarTypeCalDAV)
            [localCalendars addObject:currentCalendar];
        
        
    }
    
    //return (NSArray *)localCalendars;
    
    
    int yearSeconds = 365 * (60 * 60 * 24);
    int lastMonth = 30 * (60 * 60 * 24);
    NSPredicate *predicate = [self.eventStore predicateForEventsWithStartDate:[NSDate dateWithTimeIntervalSinceNow:-lastMonth] endDate:[NSDate dateWithTimeIntervalSinceNow:yearSeconds] calendars:localCalendars];
    
    
    NSArray *eventsArray = [self.eventStore eventsMatchingPredicate:predicate];
    
    
    eventsArray = [eventsArray sortedArrayUsingSelector:@selector(compareStartDateWithEvent:)];
    
    
    return eventsArray;
    
}

@end
