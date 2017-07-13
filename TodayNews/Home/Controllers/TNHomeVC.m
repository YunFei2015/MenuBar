//
//  TNHomeVC.m
//  TodayNews
//
//  Created by 云菲 on 2017/7/4.
//  Copyright © 2017年 Freya. All rights reserved.
//

#import "TNHomeVC.h"
#import "TNHomeNewsVC.h"
#import "MTMenuBar.h"
#import "TNChannelsListView.h"
#import "TNHomeService.h"
#import "TNChannel.h"

@interface TNHomeVC () <MTMenuBarDelegate, UIScrollViewDelegate>
@property (strong, nonatomic) NSMutableArray *childVCs;
@property (strong, nonatomic) NSMutableArray *myChannels;
@property (strong, nonatomic) NSMutableArray *allChannels;
@property (strong, nonatomic) TNChannelsListView *channelSelectView;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) MTMenuBar *menuBar;

@end

@implementation TNHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.scrollView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
//    _myChannels = [NSMutableArray arrayWithArray:@[@"分类1", @"分类2", @"分类3", @"分类4", @"分类5"]];
//    _allChannels = [NSMutableArray arrayWithArray:@[@"新分类1", @"新分类2", @"新分类3", @"新分类4", @"新分类5"]];
//    [self createChildVcs];
//    [self updateScrollViewContentSize];
    [self requestMyChannels];
    [self requestAllChannels];
}

- (void)createChildVcs{
    NSMutableArray *titles = [NSMutableArray arrayWithCapacity:_myChannels.count];
    [_myChannels enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        TNChannel *channel = (TNChannel *)obj;
        NSString *title = channel.name;
        [titles addObject:title];
        
        TNHomeNewsVC *childVC = [[TNHomeNewsVC alloc] initWithChannel:channel atIndex:idx];
        [self addChildVC:childVC];
    }];
    [self createMenuBarWithTitles:titles];
}

- (void)addChildVC:(TNHomeNewsVC *)childVC{
    [self.childVCs addObject:childVC];
    [self addChildViewController:childVC];
    [self.scrollView addSubview:childVC.view];
    [childVC didMoveToParentViewController:self];
}

- (void)removeChildVC:(TNHomeNewsVC *)childVC{
    [self.childVCs removeObject:childVC];
    [childVC willMoveToParentViewController:nil];
    [childVC.view removeFromSuperview];
    [childVC removeFromParentViewController];
}

- (void)updateScrollViewContentSize{
    self.scrollView.contentSize = CGSizeMake(kScreenW * self.myChannels.count, CGRectGetHeight(_scrollView.bounds));
}

- (void)requestMyChannels{
    [[TNHomeService sharedService] requestMyChannelsWithParameters:nil callback:^(id responseObj, NSError *error) {
        if (error) {
            return;
        }
        NSArray *data = [NSArray yy_modelArrayWithClass:[TNChannel class] json:kResponseData];
        _myChannels = [NSMutableArray arrayWithArray:data];
        
        if (self.myChannels) {
            [self createChildVcs];
            [self updateScrollViewContentSize];
        }
    }];
}

- (void)requestAllChannels{
    NSDictionary *params = @{@"aid" : @"13",
                             @"iid" : @"9390526083"};
    [[TNHomeService sharedService] requestAllChannelsWithParameters:params callback:^(id responseObj, NSError *error) {
        if (error) {
            return;
        }
        
        NSArray *data = [NSArray yy_modelArrayWithClass:[TNChannel class] json:kResponseData];
        _allChannels = [NSMutableArray arrayWithArray:data];
    }];
}

- (void)createMenuBarWithTitles:(NSArray *)titles{
    MTMenuBar *menuBar = [[MTMenuBar alloc] initWithFrame:CGRectMake(0, UI_NAVIGATION_BAR_MAXY, kScreenW - 30, kMenuBarHeight)];
    menuBar.delegate = self;
    menuBar.titles = [NSArray arrayWithArray:titles];
    [self.view addSubview:menuBar];
    _menuBar = menuBar;
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(kScreenW - 30, 64, 30, 40);
    [addBtn setTitle:@"+" forState:UIControlStateNormal];
    [addBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    addBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    addBtn.backgroundColor = RGB(255, 255, 255, .5f);
    [addBtn addTarget:self action:@selector(clickAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addBtn];
}

#pragma mark - events
- (void)clickAddBtn:(UIButton *)sender{
    self.channelSelectView.myChannels = _myChannels;
    self.channelSelectView.channels = _allChannels;

    [UIView animateWithDuration:0.25 animations:^{
        [kKeyWindow addSubview:self.channelSelectView];
        self.channelSelectView.alpha = 1.f;
    }];
}

#pragma mark - MTMenuBar delegate
- (void)menuBar:(MTMenuBar *)menuBar didSelectIndex:(NSInteger)index{
    [self.scrollView setContentOffset:CGPointMake(kScreenW * index, 0) animated:NO];
}

#pragma mark - scroll view delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x / kScreenW;
    self.menuBar.index = index;
}

#pragma mark - getters
- (TNChannelsListView *)channelSelectView{
    if (_channelSelectView == nil) {
        _channelSelectView = [[TNChannelsListView alloc] initWithFrame:kScreenBounds];
        _channelSelectView.alpha = 0;
    }
    return _channelSelectView;
}

- (UIScrollView *)scrollView{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, UI_NAVIGATION_BAR_MAXY + kMenuBarHeight, kScreenW, kScreenH - UI_NAVIGATION_BAR_MAXY - kMenuBarHeight)];
        _scrollView.contentSize = CGSizeMake(kScreenW * self.myChannels.count, CGRectGetHeight(_scrollView.bounds));
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.bounces = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
