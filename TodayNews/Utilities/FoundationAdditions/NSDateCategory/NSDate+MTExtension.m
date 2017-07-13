//
//  NSDate+Extension.m
//  约吧
//
//  Created by 云菲 on 4/7/16.
//  Copyright © 2016 云菲. All rights reserved.
//

#import "NSDate+MTExtension.h"
#import <UIKit/UIKit.h>

@implementation NSDate (Extension)
+ (NSString *)stringFromDate:(NSDate *)date withFormatter:(NSString *)formatter{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = formatter;
    
    NSTimeZone* timeZone = kTimeZone;
    [dateFormatter setTimeZone:timeZone];
    return [dateFormatter stringFromDate:date];
}

+ (NSDate *)dateFromString:(NSString *)string withFormatter:(NSString *)formatter{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone* timeZone = kTimeZone;
    [dateFormatter setTimeZone:timeZone];
    dateFormatter.dateFormat = formatter;
    NSDate *date = [dateFormatter dateFromString:string];
    return date;
}

+ (BOOL)isSameDay:(NSDate*)date1 date2:(NSDate*)date2
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:date1];
    NSDateComponents* comp2 = [calendar components:unitFlags fromDate:date2];
    
    return [comp1 day]   == [comp2 day] &&
    [comp1 month] == [comp2 month] &&
    [comp1 year]  == [comp2 year];
}

+ (BOOL)laterThanDay:(NSDate *)date{
    
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSComparisonResult result = [calendar compareDate:[NSDate date] toDate:date toUnitGranularity:NSCalendarUnitDay];
    if (result == NSOrderedDescending) {
        return YES;
    }else{
        return NO;
    }
}
@end
