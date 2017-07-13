//
//  TNChannelListHeaderView.m
//  TodayNews
//
//  Created by 云菲 on 2017/7/4.
//  Copyright © 2017年 Freya. All rights reserved.
//

#import "TNChannelListHeaderView.h"

@interface TNChannelListHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;


@end

@implementation TNChannelListHeaderView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.editBtn.layer.borderColor = [UIColor redColor].CGColor;
    self.editBtn.layer.borderWidth = .5;
    self.editBtn.layer.cornerRadius = 8;
}

- (void)prepareForReuse{
    [super prepareForReuse];
    self.editBtn.hidden = YES;
}

- (void)setSection:(NSInteger)section{
    _section = section;
    
    if (section == 0) {
        _titleLab.text = @"我的频道";
        self.editBtn.hidden = NO;
    }else{
        _titleLab.text = @"频道推荐";
        self.editBtn.hidden = YES;
    }
}

- (void)setEdited:(BOOL)edited{
    _edited = edited;
    
    self.editBtn.selected = edited;
}

- (IBAction)clickEditBtn:(UIButton *)sender {
    self.edited = !sender.selected;
    if (_editBlock) {
        _editBlock(self.edited);
    }
}

@end
