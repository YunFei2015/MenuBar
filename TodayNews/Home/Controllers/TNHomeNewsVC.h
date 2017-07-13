//
//  TNHomeChildCommonVC.h
//  TodayNews
//
//  Created by 云菲 on 2017/7/5.
//  Copyright © 2017年 Freya. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TNChannel;

@interface TNHomeNewsVC : UIViewController



- (instancetype)initWithChannel:(TNChannel *)channel atIndex:(NSInteger)index;
@end
