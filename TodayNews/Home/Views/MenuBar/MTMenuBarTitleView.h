//
//  MTMenuBarButton.h
//  MenuBar
//
//  Created by 云菲 on 2017/6/28.
//  Copyright © 2017年 Freya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTMenuBarTitleView : UIView

@property (strong, nonatomic) NSString *title;
@property (nonatomic, getter=isSelected) BOOL selected;
@property (nonatomic, strong) void(^clickBlock)(NSInteger index);
@end
