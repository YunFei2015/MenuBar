//
//  UIViewController+Convenience.m
//

#import "UIViewController+MTExtension.h"

@implementation UIViewController (MTExtension)

+ (UINavigationController *)navControllerFromClassName:(NSString *)className
{
    UIViewController *viewController = [[NSClassFromString(className) alloc] init];
    return [[UINavigationController alloc] initWithRootViewController:viewController];
}

- (UINavigationController *)navController
{
    return [[UINavigationController alloc] initWithRootViewController:self];
}

//导航栏--返回
-(void)setBackNavigationBarItem{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:NavBackImage style:UIBarButtonItemStylePlain target:self action:@selector(back:)];
}

- (void)back:(UIBarButtonItem *)item{
    [self.navigationController popViewControllerAnimated:YES];
}

/*
//添加底部操作按钮
- (void)addBottomViewWithTitle:(NSString *)title action:(SEL)action{
    UIButton *bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    bottomBtn.frame = CGRectMake(0, kScreenH - UI_BUTTON_BOTTOM_HEIGHT, kScreenW, UI_BUTTON_BOTTOM_HEIGHT);
    bottomBtn.backgroundColor = UI_MAIN_COLOR;
    [bottomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bottomBtn setTitle:title forState:UIControlStateNormal];
    [bottomBtn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    bottomBtn.tag = kBottomViewTag;
    [kKeyWindow addSubview:bottomBtn];
}

//移除底部按钮
-(void)removeBottomView{
    [[kKeyWindow viewWithTag:kBottomViewTag] removeFromSuperview];
}
 */

//拨打电话
- (void)phone:(NSString *)phone{
    NSString * str=[[NSString alloc] initWithFormat:@"telprompt://%@",phone];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

/*
//更新指定视图的badge
- (void)updateBadgeOnView:(UIView *)view withValue:(NSInteger)value{
    if (value <= 0) {
        [view clearBadge];
    }else{
        [view showBadge];
    }
}

- (void)updateBadgeOnItem:(id)item withValue:(NSInteger)value{
    if ([item isKindOfClass:[UITabBarItem class]]) {
        if (value <= 0) {
            [item clearBadge];
        }else{
            [item showBadge];
        }
    }
    
    if ([item isKindOfClass:[UIButton class]]) {
        UIButton *btn = (UIButton *)item;
        UILabel *titleLab = btn.titleLabel;
        CGSize size = [NSString sizeForText:titleLab.text maxWidth:CGFLOAT_MAX fontSize:15];
        [titleLab setBadgeCenterOffset:CGPointMake(size.width, 0)];
        if (value <= 0) {
            [titleLab clearBadge];
        }else{
            [titleLab showBadge];
        }
    }
}
 */

@end
