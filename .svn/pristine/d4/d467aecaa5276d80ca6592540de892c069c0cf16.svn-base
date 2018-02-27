//
//  HReportAnalyseRootViewController.m
//  ydhyk
//
//  Created by screson on 2016/11/21.
//  Copyright © 2016年 120v. All rights reserved.
//

#import "HReportAnalyseRootViewController.h"
#import "HTakePhotoViewController.h"
#import "HReportListViewController.h"
#import "HNewReportRecordViewController.h"

@interface HReportAnalyseRootViewController ()
@property (weak, nonatomic) IBOutlet UIView *tipView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *lbTips;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tipsHeight;
@property (weak, nonatomic) IBOutlet UIButton *btnManualInput;

@property (weak, nonatomic) IBOutlet UILabel *lbTipsText;

//拍照按钮 底层1
@property (weak, nonatomic) IBOutlet UIView *maskView1;
//拍照按钮 底层1
@property (weak, nonatomic) IBOutlet UIView *maskView2;
@property (weak, nonatomic) IBOutlet UIButton *btnTakePhoto;
@property (weak, nonatomic) IBOutlet UILabel *lbBtnTitle;

@end

@implementation HReportAnalyseRootViewController

- (instancetype)init{
    if (self = [super init]) {
        [self setHidesBottomBarWhenPushed:true];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:false animated:true];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"化验单分析"];
    [self zx_addRightBarItemsWithTexts:@[@"分析记录"] font:nil color:nil];
    [self.view setBackgroundColor:[UIColor zx_navbarColor]];
    [self.lbTips setFont:[UIFont zx_bodyFontWithSize:12]];
    [self.lbTips setTextColor:[UIColor zx_tintColor]];
    [self.lbTips setText:@"分析结果仅作参考,具体请以医师分析为准。"];
    
    [self.lbTipsText setFont:[UIFont zx_bodyFontWithSize:zx_title1FontSize()]];
    
    
    [self.maskView1 setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.1]];
    [self.maskView2 setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.1]];
    [self.lbBtnTitle setFont:[UIFont zx_titleFontWithSize:13]];
    [self.lbBtnTitle setTextColor:[UIColor zx_tintColor]];
    

    //手动录入
    [self.btnManualInput.layer setBorderColor:ZXWHITE_COLOR.CGColor];
    [self.btnManualInput.layer setBorderWidth:1.0];
    [self.btnManualInput.layer setCornerRadius:5.0];
    [self.btnManualInput.layer setMasksToBounds:true];
    [self.btnManualInput.titleLabel setFont:[UIFont zx_titleFontWithSize:13]];
    [self.btnManualInput setImage:[UIImage imageNamed:@"h_btn-write"] forState:UIControlStateHighlighted];
    [self.btnManualInput setImage:[UIImage imageNamed:@"h_btn-write"] forState:UIControlStateSelected];
    
    [self.tipView setBackgroundColor:[UIColor zx_assistColor]];
    [self.contentView setBackgroundColor:[UIColor zx_navbarColor]];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self.maskView1.layer setCornerRadius:self.maskView1.frame.size.width / 2.0];
    [self.maskView1.layer setMasksToBounds:true];
    
    [self.maskView2.layer setCornerRadius:self.maskView2.frame.size.width / 2.0];
    [self.maskView2.layer setMasksToBounds:true];
    
    [self.btnTakePhoto.layer setCornerRadius:self.btnTakePhoto.frame.size.width / 2.0];
    [self.btnTakePhoto.layer setMasksToBounds:true];

}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    //拍照分析
    
    
    if (self.tipsHeight.constant < 30) {
        self.tipsHeight.constant = 30;
        [UIView animateWithDuration:0.35 animations:^{
            [self.view layoutIfNeeded];
        }];
    }
}

//MARK: - 分析记录列表
-(void)zx_rightBarButtonActionsIndex:(NSInteger)index{
    HReportListViewController * reportListVC = [[HReportListViewController alloc] init];
    [self.navigationController pushViewController:reportListVC animated:true];
}

//MARK: - 拍照分析
- (IBAction)takePhotoAction:(id)sender {
    [self.btnTakePhoto setBackgroundColor:ZXWHITE_COLOR];
//    [self presentViewController:[[HTakePhotoViewController alloc] init] animated:true completion:nil];
    [ZXHUD MBShowFailureInView:self.view text:@"该功能调试中" delay:1.5];

}

//拍照 按下状态
- (IBAction)takePhotoTouchDown:(id)sender {
    [self.btnTakePhoto setBackgroundColor:ZXRGBA_COLOR(244, 245, 246, 1.0)];
}

//MAKR: - 手动录入
- (IBAction)manualInputAction:(id)sender {
    HNewReportRecordViewController * addCheckItem = [[HNewReportRecordViewController alloc] init];
    [self.navigationController pushViewController:addCheckItem animated:true];
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
