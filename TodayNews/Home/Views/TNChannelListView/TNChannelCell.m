//
//  TNChannelCell.m
//  TodayNews
//
//  Created by 云菲 on 2017/7/4.
//  Copyright © 2017年 Freya. All rights reserved.
//

#import "TNChannelCell.h"
#import "TNChannel.h"

#define kDeleteBtnHeight 10

@interface TNChannelCell ()
@property (strong, nonatomic) UILabel *titleLab;
@property (strong, nonatomic) UIButton *deleteBtn;

@end

@implementation TNChannelCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, kDeleteBtnHeight / 2.f, CGRectGetWidth(frame) - kDeleteBtnHeight / 2.f, CGRectGetHeight(frame) - kDeleteBtnHeight / 2.f)];
        _titleLab.backgroundColor = [UIColor whiteColor];
        _titleLab.textColor = [UIColor darkGrayColor];
        _titleLab.font = [UIFont systemFontOfSize:14];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_titleLab];
        
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteBtn.bounds = CGRectMake(0, 0, kDeleteBtnHeight, kDeleteBtnHeight);
        _deleteBtn.center = CGPointMake(CGRectGetMaxX(_titleLab.frame), CGRectGetMinY(_titleLab.frame));
        _deleteBtn.backgroundColor = [UIColor lightGrayColor];
        _deleteBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_deleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_deleteBtn setTitle:@"x" forState:UIControlStateNormal];
        [_deleteBtn addTarget:self action:@selector(clickDeleteBtn:) forControlEvents:UIControlEventTouchUpInside];
        _deleteBtn.hidden = YES;
        _deleteBtn.layer.cornerRadius = kDeleteBtnHeight / 2.f;
        [self.contentView addSubview:_deleteBtn];
    }
    return self;
}

//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
//    if ([_deleteBtn pointInside:point withEvent:event]) {
//        return _deleteBtn;
//    }else{
//        return self;
//    }
//}

- (void)prepareForReuse{
    _deleteBtn.hidden = YES;
}

- (void)clickDeleteBtn:(UIButton *)sender{
    if (_deleteBlock) {
        _deleteBlock(_channel);
    }
}

- (void)setChannel:(TNChannel *)channel{
    _channel = channel;
    
    self.titleLab.text = channel.name;
    
    if (channel.name.length > 4) {
        self.titleLab.font = [UIFont systemFontOfSize:13];
    }
}

- (void)setEdited:(BOOL)edited{
    _edited = edited;
    
    _deleteBtn.hidden = !edited;
}


@end
