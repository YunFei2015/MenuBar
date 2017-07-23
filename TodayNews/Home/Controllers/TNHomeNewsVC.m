//
//  TNHomeChildCommonVC.m
//  TodayNews
//
//  Created by 云菲 on 2017/7/5.
//  Copyright © 2017年 Freya. All rights reserved.
//

#import "TNHomeNewsVC.h"
#import "TNHomeService.h"
#import "TNChannel.h"
#import "TNNewsList.h"
#import "TNNewsTip.h"
#import "TNNewsMessage.h"
#import "TNNewsData.h"
#import <YYModel.h>

#define colors @[[UIColor redColor], [UIColor blueColor], [UIColor greenColor]]

@interface TNHomeNewsVC ()
@property (strong, nonatomic) TNChannel *channel;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) TNNewsList *listData;
@end

@implementation TNHomeNewsVC

- (instancetype)initWithChannel:(TNChannel *)channel atIndex:(NSInteger)index{
    self = [super init];
    if (self) {
        self.view.frame = CGRectMake(kScreenW * index, 0, kScreenW, kScreenH - UI_NAVIGATION_BAR_MAXY - kMenuBarHeight);
        self.channel = channel;
        self.view.backgroundColor = colors[index % 3];
//        [self.view addSubview:self.tableView];
        
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}


#pragma mark - getters
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        
    }
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
