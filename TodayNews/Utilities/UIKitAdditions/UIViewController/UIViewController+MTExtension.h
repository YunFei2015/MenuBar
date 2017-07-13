//
//  UIViewController+Convenience.h
//
//

#import <UIKit/UIKit.h>

@interface UIViewController (MTExtension)

/*
 根据类名生成视图控制器，并绑定到新创建的导航控制器的根视图控制器，然后返回该导航控制器
 */
+ (UINavigationController *)navControllerFromClassName:(NSString *)className;

/*
 向该视图控制器对象发送该消息后返回封装好的导航控制器对象
 */
- (UINavigationController *)navController;

//设置返回按钮
- (void)setBackNavigationBarItem;

/*
//设置底部按钮
- (void)addBottomViewWithTitle:(NSString *)title action:(SEL)action;

//删除底部按钮
- (void)removeBottomView;


//拨打电话
- (void)phone:(NSString *)phone;


//更新指定视图的badge
- (void)updateBadgeOnView:(UIView *)view withValue:(NSInteger)value;

//更新item的badge
- (void)updateBadgeOnItem:(id)item withValue:(NSInteger)value;
 */
@end
