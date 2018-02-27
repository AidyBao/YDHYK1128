//
//  HMessageDetailViewController.m
//  YDHYK
//
//  Created by screson on 2016/12/9.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "HMessageDetailViewController.h"
#import "ZXMessageViewModel.h"

@interface HMessageDetailViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbContent;
@property (weak, nonatomic) IBOutlet UILabel *lbDate;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentWidth;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingHUD;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *webViewHeight;

@end

@implementation HMessageDetailViewController
{
    BOOL bLoad;
    CGFloat documentHeight;

}

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
//    [self.view layoutIfNeeded];
//    _contentHeight.constant = CGRectGetMaxY(_lbDate.frame) + 20;
    [self.view layoutIfNeeded];
    _contentHeight.constant = documentHeight + CGRectGetMaxY(_lbTitle.frame) + 40;
    self.scrollView.contentSize = CGSizeMake(ZX_BOUNDS_WIDTH, _contentHeight.constant);
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    bLoad = false;
    [self setTitle:@"消息详情"];
    [_lbTitle setFont:[UIFont zx_titleFontWithSize:zx_title1FontSize()]];
    [_lbTitle setTextColor:[UIColor zx_textColor]];
    
    [_lbContent setFont:[UIFont zx_titleFontWithSize:13]];
    [_lbContent setTextColor:[UIColor zx_sub1TextColor]];
    
    [_lbDate setFont:[UIFont zx_titleFontWithSize:13]];
    [_lbDate setTextColor:[UIColor zx_sub2TextColor]];
    [_lbDate setHidden:true];
    
    self.webView.delegate = self;
    self.webView.scrollView.scrollEnabled = NO;
    [self.loadingHUD setHidesWhenStopped:true];
    [self.loadingHUD startAnimating];

    
    [self loadMessageInfo];
}

- (void)loadMessageInfo{
    [ZXHUD MBShowLoadingInView:self.view text:ZX_LOADING_TEXT delay:0];
    [ZXMessageViewModel getMessageDetailById:_messageId memerbId:[[ZXGlobalData shareInstance] memberId] type:(_type == ZXMessageTypeCoupon ? @"1" : @"2") token:[[ZXGlobalData shareInstance] userToken] completion:^(ZXMessageDetailModel *model, NSInteger status, BOOL success, NSString *errorMsg) {
        [ZXHUD MBHideForView:self.view animate:true];
        if (success) {
            if (status == ZXAPI_SUCCESS) {
                if (model) {
                    [self updateUIWithMsg:model];
                }else{
                    [ZXEmptyView showNoDataInView:self.view text1:@"无消息详情" text2:nil heightFix:0];
                }
            }else{
                [ZXEmptyView showNetworkErrorInView:self.view heightFix:0 refreshAction:^{
                    [ZXEmptyView dismissInView:self.view];
                    [self loadMessageInfo];
                }];
                [ZXHUD MBShowFailureInView:self.view text:errorMsg delay:1.2];
            }
        }else{
            [ZXEmptyView showNetworkErrorInView:self.view heightFix:0 refreshAction:^{
                [ZXEmptyView dismissInView:self.view];
                [self loadMessageInfo];
            }];
        }
    }];
}

- (void)updateUIWithMsg:(ZXMessageDetailModel *)msgDetailInfo{
    if (msgDetailInfo) {
        [_lbTitle setText:msgDetailInfo.title];
        NSMutableString * content = [NSMutableString stringWithString:@""];
        if (![ZXStringUtils isTextEmpty:msgDetailInfo.content]) {
            [content appendString:msgDetailInfo.content];
        }
        if (![ZXStringUtils isTextEmpty:msgDetailInfo.useRule]) {
            [content appendString:@"\n"];
            [content appendString:msgDetailInfo.useRule];
        }
//        NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[content dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
//        [_lbContent setAttributedText:attrStr];
//        [_lbContent setText:content];
        [self.webView loadHTMLString:content baseURL:nil];
        [_lbDate setText:msgDetailInfo.sendDateStr];
    }
}


#pragma mark WebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView*)webView {
    [self.loadingHUD stopAnimating];
    [self.lbDate     setHidden:false];
    
    [ZXHUD MBHideForView:self.view animate:true];
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none'"];
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none'"];
    
//    documentHeight = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight;"] floatValue];
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
    [ZXHUD MBHideForView:self.view animate:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    
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
