//
//  MTMenuBar.m
//  MenuBar
//
//  Created by 云菲 on 2017/6/28.
//  Copyright © 2017年 Freya. All rights reserved.
//

#import "MTMenuBar.h"
#import "MTMenuBarHeader.h"
#import "MTMenuBarTitleView.h"

@interface MTMenuBar () <UIScrollViewDelegate>
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIView *bottomLineView;
@property (nonatomic) NSInteger currentSelectedIndex;

@end


@implementation MTMenuBar

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.scrollView];
    }
    return self;
}

- (void)setTitles:(NSArray *)titles{
    _titles = titles;
    
    __block CGFloat lastX = 0;
    __block CGFloat lastW = 0;
    [titles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *title = (NSString *)obj;
        MTMenuBarTitleView *titleView = [[NSBundle mainBundle] loadNibNamed:@"MTMenuBarTitleView" owner:nil options:nil][0];
        
        NSDictionary *attri = @{NSFontAttributeName : [UIFont systemFontOfSize:MTMenuBarNormalTitleSize]};
        CGRect rect = [title boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, MTMenuBarNormalTitleSize) options:NSStringDrawingUsesLineFragmentOrigin attributes:attri context:nil];
        CGFloat width = rect.size.width + 20;
        CGFloat height = CGRectGetHeight(self.bounds);
        CGFloat x = idx == 0 ? 0 : (lastW + lastX);
        CGFloat y = 0;
        titleView.frame = CGRectMake(x, y, width, height);
        
        if (idx == 0) {
            self.bottomLineView.frame = CGRectMake(0, CGRectGetHeight(self.bounds) - 1, width, 1);
            [self.scrollView addSubview:self.bottomLineView];
            titleView.selected = YES;
        }
        
        if (idx == titles.count - 1) {
            self.scrollView.contentSize = CGSizeMake(x + width, CGRectGetHeight(self.bounds));
        }
        
        titleView.title = title;
        titleView.tag = idx;
        titleView.clickBlock = ^(NSInteger index) {
            [self clickTitleForIndex:index];
        };
        [self.scrollView insertSubview:titleView belowSubview:self.bottomLineView];
        
        lastW = width;
        lastX = x;
    }];
}

- (void)clickTitleForIndex:(NSInteger)index{
    self.index = index;
    if ([self.delegate respondsToSelector:@selector(menuBar:didSelectIndex:)]) {
        [self.delegate menuBar:self didSelectIndex:index];
    }
}

- (void)setShowBottomLine:(BOOL)showBottomLine{
    _showBottomLine = showBottomLine;
    
    self.bottomLineView.hidden = !showBottomLine;
}

#pragma mark - custom methods
- (void)setIndex:(NSInteger)index{
    if (_currentSelectedIndex == index) {
        return;
    }
    
    MTMenuBarTitleView *currentSelectedView = self.scrollView.subviews[_currentSelectedIndex];
    currentSelectedView.selected = NO;
    
    MTMenuBarTitleView *titleView = self.scrollView.subviews[index];
    titleView.selected = YES;
    CGFloat x = titleView.frame.origin.x;
    CGFloat width = titleView.frame.size.width;
    
    [UIView animateWithDuration:.25 animations:^{
        self.bottomLineView.frame = CGRectMake(x, CGRectGetHeight(self.bounds) - 1, width, 1);
    }];
    
    
    if (titleView.center.x < kScreenW / 2.f) {
        [self.scrollView setContentOffset:CGPointZero animated:YES];
    }else if (self.scrollView.contentSize.width - titleView.center.x < kScreenW / 2.f){
        [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentSize.width - CGRectGetWidth(self.bounds), 0) animated:YES];
    }else{
        [self.scrollView setContentOffset:CGPointMake(x - kScreenW / 2.f + width / 2.f, 0) animated:YES];
    }
    
    _currentSelectedIndex = index;
}

#pragma mark - scroll view delegate


#pragma mark - getters
- (UIScrollView *)scrollView{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (UIView *)bottomLineView{
    if (_bottomLineView == nil) {
        _bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
        _bottomLineView.backgroundColor = MTMenuBarBottomLineColor;
        _bottomLineView.hidden = !_showBottomLine;
    }
    return _bottomLineView;
}

- (NSInteger)index{
    return _currentSelectedIndex;
}

@end
