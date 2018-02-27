//
//  HMyQRCodeViewController.m
//  YDHYK
//
//  Created by JuanFelix on 02/12/2016.
//  Copyright © 2016 screson. All rights reserved.
//

#import "HMyQRCodeViewController.h"

@interface HMyQRCodeViewController ()
@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
//中间类容
@property (weak, nonatomic) IBOutlet UIImageView *imgHeaderIcon;
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UIImageView *imgSexIcon;
@property (weak, nonatomic) IBOutlet ZXView *vLeftDot;
@property (weak, nonatomic) IBOutlet ZXView *vRightDot;
@property (weak, nonatomic) IBOutlet UIImageView *imgDotLine;
@property (weak, nonatomic) IBOutlet UIImageView *imgQRCode;

@property (weak, nonatomic) IBOutlet UILabel *lbInfo;

@end

@implementation HMyQRCodeViewController

- (instancetype)init{
    if (self = [super init]) {
        [self setHidesBottomBarWhenPushed:true];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:false animated:true];
    [self reloadUIData];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:true animated:true];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    _imgHeaderIcon.layer.cornerRadius = _imgHeaderIcon.frame.size.width / 2.0;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsCompact];
    
    [self zx_setNavBarBackgroundColor:[UIColor clearColor]];
    
    [self setTitle:@"验证会员"];
    [self.view setBackgroundColor:[UIColor zx_assistColor]];
    //添加渐变背景
    [self loadGradientColor];
    [self.contentView setBackgroundColor:ZXCLEAR_COLOR];
    
    //center
    _imgHeaderIcon.layer.masksToBounds = true;
    [_lbName setTextColor:[UIColor zx_textColor]];
    [_lbName setFont:[UIFont zx_titleFontWithSize:zx_title1FontSize()]];
    [_vLeftDot  setHidden:true];
    [_vRightDot setHidden:true];
    /*
    [_vLeftDot   setBackgroundColor:ZXRGB_COLOR(93, 163, 240)];
    [_vRightDot  setBackgroundColor:ZXRGB_COLOR(80, 152, 241)];
     */
    
    [_imgDotLine setBackgroundColor:[UIColor zx_separatorColor]];
    
    [_imgHeaderIcon setBackgroundColor:[UIColor zx_separatorColor]];
    [_imgQRCode     setBackgroundColor:[UIColor zx_separatorColor]];
    //下方文字
    [self.lbInfo setFont:[UIFont zx_titleFontWithSize:zx_title2FontSize()]];
    [self.lbInfo setTextColor:[UIColor zx_colorWithHEXString:@"#ddecff" alpha:1.0]
     ];
}

- (void)reloadUIData{
    [_lbName setText:[[YDAPPManager shareManager] getUserName]];
    id headerUrl = [[YDAPPManager shareManager]  getUserHeadPortraitFilesStr];
    if ([headerUrl isKindOfClass:[NSString class]] && [headerUrl length]) {
        if ([[[YDAPPManager shareManager] getUserSex] integerValue] == 0) {//女
            [_imgHeaderIcon setImageWithURL:[NSURL URLWithString:headerUrl] placeholderImage:[UIImage imageNamed:@"touxiang-woman"]];
        }else{
            [_imgHeaderIcon setImageWithURL:[NSURL URLWithString:headerUrl] placeholderImage:[UIImage imageNamed:@"touxiang-man"]];
        }
        
    }else{
        if ([[[YDAPPManager shareManager] getUserSex] integerValue] == 0) {//女
            [_imgHeaderIcon setImage:[UIImage imageNamed:@"touxiang-woman"]];
        }else{
            [_imgHeaderIcon setImage:[UIImage imageNamed:@"touxiang-man"]];
        }
    }
    
    
    [_imgQRCode setImageWithURL:[NSURL URLWithString:[[YDAPPManager shareManager] getUserQrStr]]];
    if ([[[YDAPPManager shareManager] getUserSex] integerValue] == 0) {//女
        [_imgSexIcon setHighlighted:false];
    }else{
        [_imgSexIcon setHighlighted:true];
    }
}

- (void)loadGradientColor{
    CAGradientLayer *layer = [CAGradientLayer new];
    layer.colors = @[(__bridge id)ZXRGB_COLOR(95, 168, 250).CGColor, (__bridge id)ZXRGB_COLOR(59, 135, 239).CGColor];
    layer.startPoint = CGPointMake(0, 0);
    layer.endPoint = CGPointMake(1, 1);
    layer.contentsScale = [[UIScreen mainScreen] scale];
    layer.frame = [[UIScreen mainScreen] bounds];
    [self.backgroundView.layer addSublayer:layer];
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
