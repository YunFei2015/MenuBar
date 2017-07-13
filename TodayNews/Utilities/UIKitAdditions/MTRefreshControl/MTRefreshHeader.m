//
//  MTRefreshComponent.m
//  LCElectric
//
//  Created by 云菲 on 2017/5/16.
//  Copyright © 2017年 Freya. All rights reserved.
//

#import "MTRefreshHeader.h"

@implementation MTRefreshHeader

+(instancetype)headerWithRefreshingTarget:(id)target refreshingAction:(SEL)action{
    // 下拉刷新
    MTRefreshHeader *header = (MTRefreshHeader *)[super headerWithRefreshingTarget:target refreshingAction:action];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    header.automaticallyChangeAlpha = YES;
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.font = [UIFont systemFontOfSize:13];
    header.stateLabel.textColor = [UIColor lightGrayColor];
    // 设置header
    return header;
}

@end
