//
//  MTRefreshFooter.m
//  LCElectric
//
//  Created by 云菲 on 2017/5/16.
//  Copyright © 2017年 Freya. All rights reserved.
//

#import "MTRefreshFooter.h"

@implementation MTRefreshFooter
+(instancetype)footerWithRefreshingTarget:(id)target refreshingAction:(SEL)action{
    // 添加默认的上拉刷新
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    MTRefreshFooter *footer = (MTRefreshFooter *)[MJRefreshAutoNormalFooter footerWithRefreshingTarget:target refreshingAction:action];
    footer.automaticallyRefresh = NO;
    footer.automaticallyHidden = YES;
    footer.stateLabel.font = [UIFont systemFontOfSize:13];
    footer.stateLabel.textColor = [UIColor lightGrayColor];
    return footer;
}
@end
