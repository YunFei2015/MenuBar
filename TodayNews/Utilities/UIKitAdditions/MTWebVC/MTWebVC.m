//
//  MTWebVC.m
//  LCElectric
//
//  Created by 云菲 on 2017/4/26.
//  Copyright © 2017年 Freya. All rights reserved.
//

#import "MTWebVC.h"

@interface MTWebVC () 


@end

@implementation MTWebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH - 64)];
    
    webView.UIDelegate = self;
    webView.navigationDelegate = self;
    [self.view addSubview:webView];
    self.webView = webView;
    
    [webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.webView.scrollView.contentInset = UIEdgeInsetsZero;
    self.webView.scrollView.scrollIndicatorInsets = UIEdgeInsetsZero;
}

-(void)dealloc{
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

-(void)loadRequestWithURLString:(NSString *)url{
    NSString *path = [kBaseUrl stringByAppendingPathComponent:url];
    NSMutableString *params = [NSMutableString string];
    for (NSString *key in _parameters.allKeys) {
        NSString *value = [_parameters valueForKey:key];
        [params appendFormat:@"&%@=%@", key, value];
    }
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",path, params];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        float progress = [[change valueForKey:NSKeyValueChangeNewKey] floatValue];
        [SVProgressHUD showProgress:progress];
    }
}

#pragma mark - WKNavigationDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSLog(@"开始加载");
}

// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    NSLog(@"开始返回");
}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    NSLog(@"加载完成");
    [SVProgressHUD dismiss];
}

// 页面加载失败时调用
-(void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    NSLog(@"加载失败");
}

// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"接收到服务器跳转请求");
}

// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    
    NSLog(@"收到响应：%@",navigationResponse.response.URL.absoluteString);
   
}

// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    NSLog(@"即将发送请求：%@",navigationAction.request.URL.absoluteString);
    
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
