//
//  YDServicePolicyViewController.m
//  ydhyk
//
//  Created by 120v on 2016/11/18.
//  Copyright © 2016年 120v. All rights reserved.
//

#import "YDServicePolicyViewController.h"

@interface YDServicePolicyViewController ()<UIWebViewDelegate>
@property (strong, nonatomic) UIWebView *webView;
@end

@implementation YDServicePolicyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"药店会员卡用户服务协议";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.webView];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    [self.navigationController.navigationBar setBarStyle:(UIBarStyleBlackTranslucent)];
    self.navigationController.navigationBar.translucent = NO;
//    [self.navigationController.navigationBar setBarTintColor:ZXRGB_COLOR(30, 135, 234)];
    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18.0]}];

}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
//    [SVProgressHUD dismiss];
//    [SVProgressHUD showImage:[UIImage imageNamed:@"Lmistake"] status:@"请求超时"];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
//    [SVProgressHUD showWithStatus:@"加载中"];
//    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
//    [SVProgressHUD dismiss];
}

#pragma mark - lazy
-(UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
        _webView.delegate = self;
    }
    return _webView;
}

#pragma mark -隐藏Status Bar
-(BOOL)prefersStatusBarHidden{
    return NO;
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
