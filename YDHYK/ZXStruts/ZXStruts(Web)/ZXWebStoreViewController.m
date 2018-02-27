//
//  ZXWebStoreViewController.m
//  YDHYK
//
//  Created by screson on 2017/2/7.
//  Copyright © 2017年 screson. All rights reserved.
//

#import "ZXWebStoreViewController.h"

@interface ZXWebStoreViewController ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ZXWebStoreViewController

+ (instancetype)loadWebStoreURLString:(NSString *)strURL{
    ZXWebStoreViewController * webStore = [[ZXWebStoreViewController alloc] init];
    webStore.urlString = strURL;
    return webStore;
}

- (instancetype)init{
    if (self = [super init]) {
        [self setHidesBottomBarWhenPushed:true];
        [self setFd_prefersNavigationBarHidden:true];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view setBackgroundColor:[UIColor zx_tintColor]];
    [self.webView setDelegate:self];
    [self.webView setBackgroundColor:[UIColor zx_assistColor]];
    if (_urlString && _urlString.length) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_urlString]]];
    }else{
        [ZXAlertUtils showAAlertMessage:@"访问出错了" title:@"提示" buttonText:@"确定" buttonAction:^{
            [self dismissAction];
        }];
    }
    [ZXHUD MBShowLoadingInView:self.view text:nil  delay:0];
}


#pragma mark - Delegate

- (void)webViewDidFinishLoad:(UIWebView*)webView {
//    [self.loadingHUD stopAnimating];
    [ZXHUD MBHideForView:self.view animate:true];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
//    [self.loadingHUD stopAnimating];
    [ZXHUD MBHideForView:self.view animate:true];
    [ZXAlertUtils showAAlertMessage:@"访问出错了" title:@"提示" buttonTexts:@[@"返回",@"刷新"] buttonAction:^(int buttonIndex) {
        if (buttonIndex == 0) {
            [self dismissAction];
        }else{
            [self.webView reload];
        }
    }];
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString * strurl = [request.URL absoluteString];
    NSArray  * arrURL = [strurl componentsSeparatedByString:@"#"];
    if ([arrURL isKindOfClass:[NSArray class]] && arrURL.count >= 2) {
        NSArray  * arrAURLType = [[arrURL lastObject] componentsSeparatedByString:@"&"];
        NSInteger index = [[arrAURLType firstObject] intValue];
        switch (index) {
            case 0://关闭
            {
                [self dismissAction];
                return false;

            }
                break;
            case 1://全部订单
            {
                if (self.navigationController) {
                    [self.navigationController popToRootViewControllerAnimated:false];
                    [ZXRouter selectTabbarIndex:3];
                    [[NSUserDefaults standardUserDefaults] setObject:@(1) forKey:@"ZXOrderList"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                }else{
                    [self dismissViewControllerAnimated:true completion:nil];
                    [ZXRouter selectTabbarIndex:3];
                    [[NSUserDefaults standardUserDefaults] setObject:@(1) forKey:@"ZXOrderList"];
                    [[NSUserDefaults standardUserDefaults] synchronize];

                }
                return false;
            }
                break;
            default:
                break;
        }
    }
    return true;
}

- (void)dismissAction{
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:true];
    }else{
        [self dismissViewControllerAnimated:true completion:nil];
    }
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
