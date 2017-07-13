//
//  TNChannelListHeaderView.h
//  TodayNews
//
//  Created by 云菲 on 2017/7/4.
//  Copyright © 2017年 Freya. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString * const kChannelHeaderIdentifier = @"header";

@interface TNChannelListHeaderView : UICollectionReusableView

@property (nonatomic) NSInteger section;
@property (nonatomic) BOOL edited;
@property (nonatomic, strong) void(^editBlock)(BOOL isEdited);
@end
