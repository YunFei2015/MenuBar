//
//  TNNews.h
//  TodayNews
//
//  Created by 云菲 on 2017/7/6.
//  Copyright © 2017年 Freya. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TNNewsData;


@interface TNNewsMessage : NSObject
@property (strong, nonatomic) TNNewsData *content;
@property (strong, nonatomic) NSString *code;
@end
