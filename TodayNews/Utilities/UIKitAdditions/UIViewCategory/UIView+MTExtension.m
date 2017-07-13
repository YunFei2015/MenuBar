//
//  UIView+MTExtension.m
//  LCElectric
//
//  Created by 云菲 on 2017/4/14.
//  Copyright © 2017年 Freya. All rights reserved.
//

#import "UIView+MTExtension.h"

@implementation UIView (MTExtension)

- (CGFloat)mt_height
{
    return self.frame.size.height;
}

- (void)setMt_height:(CGFloat)mt_height
{
    CGRect temp = self.frame;
    temp.size.height = mt_height;
    self.frame = temp;
}

- (CGFloat)mt_width
{
    return self.frame.size.width;
}

- (void)setMt_width:(CGFloat)mt_width
{
    CGRect temp = self.frame;
    temp.size.width = mt_width;
    self.frame = temp;
}


- (CGFloat)mt_y
{
    return self.frame.origin.y;
}

- (void)setMt_y:(CGFloat)mt_y
{
    CGRect temp = self.frame;
    temp.origin.y = mt_y;
    self.frame = temp;
}

- (CGFloat)mt_x
{
    return self.frame.origin.x;
}

- (void)setMt_x:(CGFloat)mt_x
{
    CGRect temp = self.frame;
    temp.origin.x = mt_x;
    self.frame = temp;
}

-(CGFloat)mt_centerX{
    return self.center.x;
}

-(void)setMt_centerX:(CGFloat)mt_centerX{
    CGPoint temp = self.center;
    temp.x = mt_centerX;
    self.center = temp;
}

-(CGFloat)mt_centerY{
    return self.center.y;
}

-(void)setMt_centerY:(CGFloat)mt_centerY{
    CGPoint temp = self.center;
    temp.y = mt_centerY;
    self.center = temp;
}

@end
