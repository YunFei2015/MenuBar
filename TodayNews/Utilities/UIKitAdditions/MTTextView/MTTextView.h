//
//  QYTextView.h
//  SmartLC
//
//  Created by 云菲 on 16/6/28.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTTextView : UITextView
/** 占位文字 */
@property (nonatomic,copy) NSString *placeholder;
/** 占位文字颜色 */
@property (nonatomic,strong) UIColor *placeholderColor;
@end
