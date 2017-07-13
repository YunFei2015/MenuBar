//
//  TNNewsList.h
//  TodayNews
//
//  Created by 云菲 on 2017/7/6.
//  Copyright © 2017年 Freya. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TNNewsTip;

@interface TNNewsList : NSObject
/*
 {
	"login_status": 0,
	"total_number": 14,
	"has_more": false,
	"post_content_hint": "\u5206\u4eab\u300c\u70ed\u70b9\u300d\u7684\u65b0\u9c9c\u4e8b",
	"show_et_status": 0,
	"feed_flag": 0,
	"message": "success",
	"has_more_to_refresh": true,
 "tips": {
 "display_info": "\u4eca\u65e5\u5934\u6761\u63a8\u8350\u5f15\u64ce\u670914\u6761\u66f4\u65b0",
 "open_url": "",
 "web_url": "",
 "app_name": "\u4eca\u65e5\u5934\u6761",
 "package_name": "",
 "display_template": "\u4eca\u65e5\u5934\u6761\u63a8\u8350\u5f15\u64ce\u6709%s\u6761\u66f4\u65b0",
 "type": "app",
 "display_duration": 2,
 "download_url": ""
	}
    "data" : []
 }
 */

@property (nonatomic) NSInteger login_status, show_et_status, total_number, feed_flag;
@property (nonatomic) BOOL has_more, has_more_to_refresh;
@property (strong, nonatomic) NSString *post_content_hint, *message;
@property (strong, nonatomic) NSArray *data;
@property (strong, nonatomic) TNNewsTip *tips;

@end
