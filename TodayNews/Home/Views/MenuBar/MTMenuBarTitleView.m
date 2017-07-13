//
//  MTMenuBarButton.m
//  MenuBar
//
//  Created by 云菲 on 2017/6/28.
//  Copyright © 2017年 Freya. All rights reserved.
//

#import "MTMenuBarTitleView.h"
#import "MTMenuBarHeader.h"

@interface MTMenuBarTitleView ()
@property (weak, nonatomic) IBOutlet UIButton *button;
@end

@implementation MTMenuBarTitleView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    [self.button setTitleColor:MTMenuBarNormalTitleColor forState:UIControlStateNormal];
    [self.button setTitleColor:MTMenuBarSelectedTitleColor forState:UIControlStateSelected];
    [self.button setBackgroundColor:MTMenuBarBackgroundColor];
    [self.button setTintColor:[UIColor clearColor]];
    self.button.titleLabel.font = [UIFont systemFontOfSize:MTMenuBarNormalTitleSize];
    
    [self.button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)clickButton:(UIButton *)sender{
    self.selected = YES;
    if (self.clickBlock) {
        self.clickBlock(self.tag);
    }
}

- (void)setTitle:(NSString *)title{
    _title = title;
    
    [self.button setTitle:title forState:UIControlStateNormal];
    [self.button setTitle:title forState:UIControlStateSelected];
}

-(void)setSelected:(BOOL)selected{
    _selected = selected;
    
    self.button.selected = selected;
    if (!selected) {
        self.button.titleLabel.font = [UIFont systemFontOfSize:MTMenuBarNormalTitleSize];
    }else{
        self.button.titleLabel.font = [UIFont systemFontOfSize:MTMenuBarSelectedTitleSize];
    }
    
    
}
@end
