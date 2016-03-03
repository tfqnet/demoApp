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
        if (currentCalendar.type == EKCalendarTypeLocal || [currentCalendar.title isEqualToString:@"Calendar"]) {
            [localCalendars addObject:currentCalendar];
            
            
        }
    }
    
    
   
    int yearSeconds = 365 * (60 * 60 * 24);
    NSPredicate *predicate = [self.eventStore predicateForEventsWithStartDate:[NSDate dateWithTimeIntervalSinceNow:-yearSeconds] endDate:[NSDate dateWithTimeIntervalSinceNow:yearSeconds] calendars:localCalendars];
    
    // Get an array with all events.
    NSArray *eventsArray = [self.eventStore eventsMatchingPredicate:predicate];
    
    // Sort the array based on the start date.
    eventsArray = [eventsArray sortedArrayUsingSelector:@selector(compareStartDateWithEvent:)];
    
    
    return eventsArray;
}
/*

-(NSArray *)getEventsOfSelectedCalendar{
    // Specify the calendar that will be used to get the events from.
    EKCalendar *calendar = nil;
    if (self.selectedCalendarIdentifier != nil && self.selectedCalendarIdentifier.length > 0) {
        calendar = [self.eventStore calendarWithIdentifier:self.selectedCalendarIdentifier];
    }
    
    // If no selected calendar identifier exists and the calendar variable has the nil value, then all calendars will be used for retrieving events.
    NSArray *calendarsArray = nil;
    if (calendar != nil) {
        calendarsArray = @[calendar];
    }
    
    
    // Create a predicate value with start date a year before and end date a year after the current date.
    int yearSeconds = 365 * (60 * 60 * 24);
    NSPredicate *predicate = [self.eventStore predicateForEventsWithStartDate:[NSDate dateWithTimeIntervalSinceNow:-yearSeconds] endDate:[NSDate dateWithTimeIntervalSinceNow:yearSeconds] calendars:calendarsArray];
    
    // Get an array with all events.
    NSArray *eventsArray = [self.eventStore eventsMatchingPredicate:predicate];
    
    // Sort the array based on the start date.
    eventsArray = [eventsArray sortedArrayUsingSelector:@selector(compareStartDateWithEvent:)];
    
    // Return that array.
    return eventsArray;
}

*/
@end
