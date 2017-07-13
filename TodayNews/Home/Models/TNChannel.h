//
//  TNChannel.h
//  TodayNews
//
//  Created by 云菲 on 2017/7/4.
//  Copyright © 2017年 Freya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYModel.h>

@interface TNChannel : NSObject
@property (strong, nonatomic) NSString *category;
@property (strong, nonatomic) NSString *concern_id;
@property (nonatomic) BOOL default_add;
@property (nonatomic) BOOL tip_new;
@property (strong, nonatomic) NSString *icon_url;
@property (strong, nonatomic) NSString *name;
@property (nonatomic) NSInteger type;
@property (strong, nonatomic) NSString *web_url;


@end
