//
//  NSDate+Extension.h
//  约吧
//
//  Created by 云菲 on 4/7/16.
//  Copyright © 2016 云菲. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)

/**
 *  将时间转化为字符串格式
 *
 *  @param formatter 指定字符串格式
 *
 *  @return 时间字符串
 */
+ (NSString *)stringFromDate:(NSDate *)date withFormatter:(NSString *)formatter;

/**
 *  将字符串时间转化成NSDate
 *
 *  @param string      字符串时间
 *  @param formatter 字符串格式
 *
 *  @return NSDate时间
 */
+ (NSDate *)dateFromString:(NSString *)string withFormatter:(NSString *)formatter;


/**
 *  判断两个日期是否为同一天
 *
 *  @param date1 date1
 *  @param date2 date2
 *
 *  @return 
 */
+ (BOOL)isSameDay:(NSDate*)date1 date2:(NSDate*)date2;

/**
 *  判断指定日期是否比当前时间晚至少一天
 */
+ (BOOL)laterThanDay:(NSDate *)date;
@end
