//
//  MTHUDView.m
//  LCElectric
//
//  Created by 云菲 on 2017/5/26.
//  Copyright © 2017年 Freya. All rights reserved.
//

#import "MTHUDView.h"
#import <SVProgressHUD.h>

@implementation MTHUDView
+ (void)initial{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    [SVProgressHUD setMinimumDismissTimeInterval:2];
}

+ (void)show{
    [SVProgressHUD setMinimumSize:CGSizeMake(100.f, 100.f)];
    [SVProgressHUD show];
}

+ (void)showSuccessWithStatus:(NSString *)status{
    [SVProgressHUD setMinimumSize:CGSizeMake(100.f, 100.f)];
    [SVProgressHUD showSuccessWithStatus:status];
}

+ (void)showImage:(UIImage *)image status:(NSString *)status{
    if (image == nil) {
        [SVProgressHUD setMinimumSize:CGSizeZero];
    }else{
        [SVProgressHUD setMinimumSize:CGSizeMake(100.f, 100.f)];
    }
    [SVProgressHUD showImage:image status:status];
}

+ (void)showProgress:(float)progress{
    [SVProgressHUD setMinimumSize:CGSizeMake(100.f, 100.f)];
    [SVProgressHUD showProgress:progress];
}

+ (void)dismiss{
    [SVProgressHUD setMinimumSize:CGSizeMake(100.f, 100.f)];
    [SVProgressHUD dismiss];
}

@end
