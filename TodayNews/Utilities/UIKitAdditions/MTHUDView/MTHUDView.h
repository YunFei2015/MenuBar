//
//  MTHUDView.h
//  LCElectric
//
//  Created by 云菲 on 2017/5/26.
//  Copyright © 2017年 Freya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTHUDView : UIView
+ (void)initial;
+ (void)show;
+ (void)showSuccessWithStatus:(NSString *)status;
+ (void)showImage:(UIImage *)image status:(NSString *)status;
+ (void)showProgress:(float)progress;
+ (void)dismiss;
@end
