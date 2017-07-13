//
//  MTWebVC.h
//  LCElectric
//
//  Created by 云菲 on 2017/4/26.
//  Copyright © 2017年 Freya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface MTWebVC : UIViewController

@property (strong, nonatomic) NSDictionary *parameters;
@property (strong, nonatomic) WKWebView *webView;
@end

@interface MTWebVC () <WKNavigationDelegate, WKUIDelegate>
- (void)loadRequestWithURLString:(NSString *)baseUrl;

@end
