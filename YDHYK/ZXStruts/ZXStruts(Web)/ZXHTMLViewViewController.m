//
//  ZXHTMLViewViewController.m
//  YDHYK
//
//  Created by screson on 2017/1/18.
//  Copyright © 2017年 screson. All rights reserved.
//

#import "ZXHTMLViewViewController.h"

@implementation ZXHTMLContentModel

@end

@interface ZXHTMLViewViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbTime;
@property (weak, nonatomic) IBOutlet UILabel *lbContent;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentHeight;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *webViewHeight;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingHUD;

@end

@implementation ZXHTMLViewViewController


- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self updateFrame];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self updateFrame];
}

- (void)updateFrame{
    _contentWidth.constant  = ZX_BOUNDS_WIDTH;
    _webViewHeight.constant = documentHeight;
    [self.view layoutIfNeeded];
    _contentHeight.constant = CGRectGetMaxY(self.lbTime.frame) + documentHeight + 20;
    self.scrollView.contentSize = CGSizeMake(ZX_BOUNDS_WIDTH, _contentHeight.constant);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [_lbTitle setFont:[UIFont zx_titleFontWithSize:zx_navBarTitleFontSize() + 2]];
    [_lbTitle setTextColor:[UIColor zx_textColor]];
    
    [_lbContent setFont:[UIFont zx_titleFontWithSize:13]];
    [_lbContent setTextColor:[UIColor zx_sub1TextColor]];
    
    [_lbTime setFont:[UIFont zx_titleFontWithSize:12]];
    [_lbTime setTextColor:[UIColor zx_textColor]];

    self.webView.delegate = self;
    self.webView.scrollView.scrollEnabled = NO;
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
    
    [self.loadingHUD setHidesWhenStopped:true];
    [self.loadingHUD startAnimating];
    [self loadHTMLContent:_htmlContentModel];
}

- (void)loadHTMLContent:(ZXHTMLContentModel *)htmlContent{
    if (htmlContent) {
        [_lbTitle setText:htmlContent.title];
        [self.webView loadHTMLString:htmlContent.content baseURL:nil];
        [_lbTime setText:htmlContent.publishDate];
    }
}

#pragma mark WebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView*)webView {
    [self.loadingHUD stopAnimating];
    
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none'"];
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none'"];
//    documentHeight = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight;"] floatValue];//有误差 有些算高了 有些算低了
    //方法2
    CGRect frame = webView.frame;
    frame.size.width = ZX_BOUNDS_WIDTH - 40;
    frame.size.height = 1;//必须大于0
    webView.frame = frame;
    frame.size.height = webView.scrollView.contentSize.height;
//    if (documentHeight < frame.size.height) {
        documentHeight = frame.size.height;
//    }
    [self updateFrame];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [self.loadingHUD stopAnimating];
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
