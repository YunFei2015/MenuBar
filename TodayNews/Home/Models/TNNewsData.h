//
//  TNNewsData.h
//  TodayNews
//
//  Created by 云菲 on 2017/7/6.
//  Copyright © 2017年 Freya. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TNNewsData : NSObject
@property (nonatomic) NSInteger read_count, ban_comment, bury_count, tip, hot, has_mp4_video, comment_count, share_count, publish_time, gallary_image_count, repin_count, cell_flag, level, like_count, digg_count, behot_time, cursor;
@property (nonatomic) NSInteger article_type;
@property (nonatomic) NSInteger article_sub_type;
@property (nonatomic) NSInteger item_id, tag_id, group_id;
@property (nonatomic) BOOL show_portrait_article, is_subject, show_portrait, has_image, has_video;
@property (strong, nonatomic) NSString *media_name, *abstract ,*tag, *keywords, *title, *share_url, *source, *article_url, *verified_content, *display_url, *source_open_url, *url;
@property (strong, nonatomic) NSArray *image_list, *filter_words, *action_list, *large_image_list;
@property (strong, nonatomic) NSDictionary *media_info, *user_info, *middle_image;

/*
 {
 "log_pb": {
 "impr_id": "2017070600022201000807804123961B"
 },
 "read_count": 423081,
 "media_name": "中国台湾网",
 "ban_comment": 0,
 "abstract": "国民党副主席人选备受关注。",
 "image_list": [],
 "ugc_recommend": {
 "reason": "",
 "activity": ""
 },
 "article_type": 0,
 "tag": "news_politics",
 "forward_info": {
 "forward_count": 6
 },
 "has_m3u8_video": 0,
 "keywords": "曾永权,党主席,全代会,吴敦义,林政则",
 "rid": "2017070600022201000807804123961B",
 "show_portrait_article": false,
 "user_verified": 0,
 "aggr_type": 1,
 "cell_type": 0,
 "article_sub_type": 0,
 "bury_count": 7,
 "title": "国民党中央人事备受关注 吴敦义开始布局",
 "ignore_web_transform": 1,
 "source_icon_style": 6,
 "tip": 0,
 "hot": 0,
 "share_url": "http://toutiao.com/a6439153457098637569/?iid=9390526083&app=news_article",
 "has_mp4_video": 0,
 "source": "中国台湾网",
 "comment_count": 44,
 "article_url": "http://toutiao.com/group/6439153457098637569/",
 "filter_words": [
 {
 "id": "8:0",
 "name": "看过了",
 "is_selected": false
 },
 {
 "id": "9:1",
 "name": "内容太水",
 "is_selected": false
 },
 {
 "id": "5:9104206",
 "name": "拉黑来源:中国台湾网",
 "is_selected": false
 },
 {
 "id": "2:31137566",
 "name": "不想看:台海时事",
 "is_selected": false
 },
 {
 "id": "6:21992",
 "name": "不想看:国民党",
 "is_selected": false
 },
 {
 "id": "6:77454",
 "name": "不想看:吴敦义",
 "is_selected": false
 }
 ],
 "share_count": 125,
 "publish_time": 1499233378,
 "action_list": [
 {
 "action": 1,
 "extra": {},
 "desc": ""
 },
 {
 "action": 3,
 "extra": {},
 "desc": ""
 },
 {
 "action": 7,
 "extra": {},
 "desc": ""
 },
 {
 "action": 9,
 "extra": {},
 "desc": ""
 }
 ],
 "gallary_image_count": 2,
 "cell_layout_style": 1,
 "tag_id": 6439153457098637000,
 "action_extra": "{\"channel_id\": 3189398996}",
 "video_style": 0,
 "verified_content": "",
 "display_url": "http://toutiao.com/group/6439153457098637569/",
 "large_image_list": [],
 "media_info": {
 "user_id": 5852567431,
 "verified_content": "",
 "avatar_url": "http://p3.pstatp.com/large/11199/7570966772",
 "media_id": 5852655501,
 "name": "中国台湾网",
 "recommend_type": 0,
 "follow": false,
 "recommend_reason": "",
 "is_star_user": false,
 "user_verified": false
 },
 "item_id": 6439158330014303000,
 "is_subject": false,
 "show_portrait": false,
 "repin_count": 2718,
 "cell_flag": 11,
 "user_info": {
 "verified_content": "",
 "avatar_url": "http://p3.pstatp.com/thumb/11199/7570966772",
 "user_id": 5852567431,
 "name": "中国台湾网",
 "follower_count": 0,
 "follow": false,
 "user_auth_info": "",
 "user_verified": false,
 "description": "国家重点新闻网站，涉台服务综合门户网站，两岸交流合作的权威平台，致力于打造两岸交流互动新门户。"
 },
 "source_open_url": "sslocal://profile?uid=5852567431",
 "level": 0,
 "like_count": 5,
 "digg_count": 5,
 "behot_time": 1499270542,
 "cursor": 1499270542999,
 "url": "http://toutiao.com/group/6439153457098637569/",
 "preload_web": 1,
 "user_repin": 0,
 "has_image": true,
 "item_version": 0,
 "has_video": false,
 "group_id": 6439153457098637000,
 "middle_image": {
 "url": "http://p3.pstatp.com/list/300x196/2c3800000fd7bcf2e7dc.webp",
 "width": 1049,
 "url_list": [
 {
 "url": "http://p3.pstatp.com/list/300x196/2c3800000fd7bcf2e7dc.webp"
 },
 {
 "url": "http://pb9.pstatp.com/list/300x196/2c3800000fd7bcf2e7dc.webp"
 },
 {
 "url": "http://pb1.pstatp.com/list/300x196/2c3800000fd7bcf2e7dc.webp"
 }
 ],
 "uri": "list/2c3800000fd7bcf2e7dc",
 "height": 590
 }
 }
 */



@end



