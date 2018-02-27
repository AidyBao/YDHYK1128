//
//  HCheckCodeViewController.m
//  YDHYK
//
//  Created by screson on 2016/12/7.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "HCheckCodeViewController.h"
#import "ZXOrderListViewModel.h"

#define HCheckCode_TintColor ZXRGB_COLOR(53, 167, 144)

@interface HCheckCodeViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topOffset;
@property (weak, nonatomic) IBOutlet UIView *vLine;
@property (weak, nonatomic) IBOutlet UIView *vCodeContent;
@property (weak, nonatomic) IBOutlet UIImageView *imgQRCode;//二维码
@property (weak, nonatomic) IBOutlet UIView *vCheckCodeContent;
@property (weak, nonatomic) IBOutlet UILabel *lbCodeTile;
@property (weak, nonatomic) IBOutlet UILabel *lbCheckCode;//提货码
@property (weak, nonatomic) IBOutlet UIView *vCashCodeContent;
@property (weak, nonatomic) IBOutlet UILabel *lbCashCodeTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbCashCode;//现金券码
@property (weak, nonatomic) IBOutlet UILabel *lbBottomInfo;

@end

@implementation HCheckCodeViewController

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self zx_setNavBarBackgroundColor:[UIColor zx_navbarColor]];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self zx_setNavBarBackgroundColor:HCheckCode_TintColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"提货码"];
    [self.view setBackgroundColor:HCheckCode_TintColor];
    
    [_vLine setBackgroundColor:[UIColor zx_separatorColor]];
    
    [_lbCodeTile setFont:[UIFont zx_titleFontWithSize:16]];
    [_lbCodeTile setTextColor:[UIColor zx_textColor]];
    [_lbCashCodeTitle setFont:[UIFont zx_titleFontWithSize:16]];
    [_lbCashCodeTitle setTextColor:[UIColor zx_textColor]];
    
    [_lbCheckCode setFont:[UIFont zx_titleFontWithSize:26]];
    [_lbCheckCode setTextColor:HCheckCode_TintColor];
    [_lbCashCode  setFont:[UIFont zx_titleFontWithSize:26]];
    [_lbCashCode  setTextColor:HCheckCode_TintColor];
    
    [_lbBottomInfo  setFont:[UIFont zx_titleFontWithSize:zx_title2FontSize()]];
    [_lbBottomInfo  setTextColor:ZXRGB_COLOR(176, 255, 241)];
    
    if ([UIDevice zx_deviceSizeType] == ZX_IPHONE4 ||
        [UIDevice zx_deviceSizeType] == ZX_IPHONE5) {
        _topOffset.constant = 20;
    }else{
        _topOffset.constant = 45;
    }
    
    [_imgQRCode setBackgroundColor:[UIColor zx_separatorColor]];

    //暂时都没有现金券
    [_vCashCodeContent setHidden:true];
    [self loadCheckCodeShowHUD:true];
}

- (void)loadCheckCodeShowHUD:(BOOL)bShow{
    if (bShow) {
        [ZXHUD MBShowLoadingInView:self.view text:ZX_LOADING_TEXT delay:0];
    }
    [ZXOrderListViewModel browserOrderTakeCodeById:_orderId memberId:[[ZXGlobalData shareInstance] memberId] token:[[ZXGlobalData shareInstance] userToken] completion:^(NSString *code, UIImage * qrCode, NSInteger status, BOOL apiSuccess, NSString *errorMsg) {
        [ZXHUD MBHideForView:self.view animate:true];
        if (status == ZXAPI_SUCCESS) {
            if (!code || code.length == 0) {
                [ZXAlertUtils showAAlertMessage:@"没有提货码信息" title:@"提示" buttonText:@"确定" buttonAction:^{
                    [self.navigationController popViewControllerAnimated:true];
                }];
            }else{
//                [_imgQRCode setImage:[ZXQRCodeUtils createQRForString:qrCodeStr withSize:250]];
//                [_imgQRCode setImage:[ZXQRCodeUtils createQRForString:code withSize:250]];
                [_imgQRCode setImage:qrCode];
                [_lbCheckCode setText:code];
            }
        }else{
            if (status != ZXAPI_LOGIN_INVALID) {
                [ZXAlertUtils showAAlertMessage:errorMsg title:@"提示" buttonText:@"确定" buttonAction:^{
                    [self.navigationController popViewControllerAnimated:true];
                }];
            }else{//登录失效
                [self.navigationController popViewControllerAnimated:false];
            }
        }
    }];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    UIBezierPath *maskPath1 = [UIBezierPath bezierPathWithRoundedRect:_vCodeContent.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *maskLayer1 = [[CAShapeLayer alloc] init];
    maskLayer1.frame = _vCodeContent.bounds;
    maskLayer1.path = maskPath1.CGPath;
    _vCodeContent.layer.mask = maskLayer1;
    //暂时都没有现金券
    /*
    if (_vCashCodeContent.isHidden) {//没有现金券码
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_vCheckCodeContent.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(5, 5)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = _vCheckCodeContent.bounds;
        maskLayer.path = maskPath.CGPath;
        _vCheckCodeContent.layer.mask = maskLayer;
    }else{
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_vCashCodeContent.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(5, 5)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = _vCashCodeContent.bounds;
        maskLayer.path = maskPath.CGPath;
        _vCashCodeContent.layer.mask = maskLayer;
    }
     */
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_vCheckCodeContent.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = _vCheckCodeContent.bounds;
    maskLayer.path = maskPath.CGPath;
    _vCheckCodeContent.layer.mask = maskLayer;
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
