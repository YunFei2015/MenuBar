//
//  TNNewsList.m
//  TodayNews
//
//  Created by 云菲 on 2017/7/6.
//  Copyright © 2017年 Freya. All rights reserved.
//

#import "TNNewsList.h"
#import "TNNewsMessage.h"
#import "TNNewsTip.h"
#import <YYModel.h>

@implementation TNNewsList

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"data" : [TNNewsMessage class],
             @"tips" : [TNNewsTip class]};
}

@end
