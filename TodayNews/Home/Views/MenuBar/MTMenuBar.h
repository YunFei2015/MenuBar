//
//  MTMenuBar.h
//  MenuBar
//
//  Created by 云菲 on 2017/6/28.
//  Copyright © 2017年 Freya. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MTMenuBar;

@protocol MTMenuBarDelegate <NSObject>

- (void)menuBar:(MTMenuBar *)menuBar didSelectIndex:(NSInteger)index;

@end

@interface MTMenuBar : UIView
@property (nonatomic, weak, nonatomic) id <MTMenuBarDelegate> delegate;
@property (strong, nonatomic) NSArray *titles;
@property (nonatomic) NSInteger index;
@property (nonatomic) BOOL showBottomLine;

@end

