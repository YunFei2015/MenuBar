//
//  TNNewsTip.h
//  TodayNews
//
//  Created by 云菲 on 2017/7/6.
//  Copyright © 2017年 Freya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TNNewsTip : NSObject
@property (nonatomic) NSInteger display_duration;
@property (strong, nonatomic) NSString *display_info, *open_url, *web_url, *app_name, *package_name, *display_template, *type, *download_url;

@end
