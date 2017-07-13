//
//  TNChannelCell.h
//  TodayNews
//
//  Created by 云菲 on 2017/7/4.
//  Copyright © 2017年 Freya. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TNChannel;

static NSString * const kChannelCellIdentifier = @"channel";

@interface TNChannelCell : UICollectionViewCell
@property (strong, nonatomic) TNChannel *channel;
@property (nonatomic, getter=isEdited) BOOL edited;

@property (nonatomic, strong) void(^deleteBlock)(TNChannel *channel);
@end
