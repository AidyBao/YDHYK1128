//
//  HReportDetialViewController.m
//  ydhyk
//
//  Created by screson on 2016/11/22.
//  Copyright © 2016年 120v. All rights reserved.
//

#import "HReportDetialViewController.h"
#import "HReportResultViewController.h"
#import "HCheckItemInputViewController.h"
#import "HItemSexAgeTableCell.h"
#import "HItemResultTableCell.h"
#import "HIRHeaderTableCell.h"
#import "ZXReportAnalyseViewModel.h"
#import <MJPhotoBrowser/MJPhotoBrowser.h>

@interface HReportDetialViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray <ZXItemShortModel *> * itemList;
    ZXPatientInfo * patientInfo;
}
@property (weak, nonatomic) IBOutlet UIView *topViewContent;
@property (weak, nonatomic) IBOutlet UIImageView *imgReport;
@property (weak, nonatomic) IBOutlet UIView *topMaskView;
@property (weak, nonatomic) IBOutlet UIButton *btnBrowseDetailImage;
@property (weak, nonatomic) IBOutlet UITableView *tblReportItems;

@end

@implementation HReportDetialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"分析记录详情"];
    
    [self.btnBrowseDetailImage setBackgroundColor:ZXCLEAR_COLOR];
    [self.btnBrowseDetailImage.layer setBorderColor:ZXWHITE_COLOR.CGColor];
    [self.btnBrowseDetailImage.layer setBorderWidth:1.0];
    [self.btnBrowseDetailImage.layer setMasksToBounds:true];
    [self.btnBrowseDetailImage.layer setCornerRadius:5.0];
    [self.btnBrowseDetailImage.titleLabel setFont:[UIFont zx_titleFontWithSize:13]];
    
    [self.tblReportItems setBackgroundColor:[UIColor zx_assistColor]];
    
    [self.imgReport setBackgroundColor:[UIColor zx_separatorColor]];
    [self.imgReport setClipsToBounds:true];
    [self.imgReport setContentMode:UIViewContentModeScaleAspectFill];
    //
    [self.tblReportItems setSeparatorColor:[UIColor zx_separatorColor]];
    [self.tblReportItems registerNib:[UINib nibWithNibName:@"HItemSexAgeTableCell" bundle:nil] forCellReuseIdentifier:@"HItemSexAgeTableCell"];

    [self.tblReportItems registerNib:[UINib nibWithNibName:@"HIRHeaderTableCell" bundle:nil] forCellReuseIdentifier:@"HIRHeaderTableCell"];
    [self.tblReportItems registerNib:[UINib nibWithNibName:@"HItemResultTableCell" bundle:nil] forCellReuseIdentifier:@"HItemResultTableCell"];
    [self loadReportListDetailShowHUD:true];
}

//删除化验单
- (void)zx_rightBarButtonActionsIndex:(NSInteger)index{
    [ZXAlertUtils showAAlertMessage:@"确定删除化验单及分析结果记录" title:@"提示" buttonTexts:@[@"取消",@"删除"] buttonAction:^(int buttonIndex) {
        if (buttonIndex == 1) {
            [ZXHUD MBShowLoadingInView:self.view text:@"删除中..." delay:0];
            [ZXReportAnalyseViewModel deleteAnalyseReportWithId:_reportId memberId:[[ZXGlobalData shareInstance] memberId] token:[[ZXGlobalData shareInstance]  userToken] completion:^(BOOL success, NSInteger status, BOOL reqSuccess, NSString *errorMsg) {
                [ZXHUD MBHideForView:self.view animate:true];
                if (success) {
                    [ZXNotificationCenter postNotificationName:@"ZXReportListUpdate" object:nil];
                    [self.navigationController popViewControllerAnimated:true];
                }else{
                    if (status != ZXAPI_LOGIN_INVALID) {
                        [ZXHUD MBShowFailureInView:self.view text:errorMsg delay:1.5];
                    }
                }
            }];
        }
    }];
}

- (void)loadReportListDetailShowHUD:(BOOL)bShow{
    if (bShow) {
        [ZXHUD MBShowLoadingInView:self.view text:ZX_LOADING_TEXT delay:0];
    }
    [ZXReportAnalyseViewModel getLabReportDetailByReportId:_reportId memberId:[[ZXGlobalData shareInstance] memberId] token:[[ZXGlobalData shareInstance] userToken] completion:^(NSArray<ZXItemShortModel *> *list, ZXPatientInfo *patient, NSInteger status, BOOL success, NSString *errorMsg) {
        if (bShow) {
            [ZXHUD MBHideForView:self.view animate:true];
        }
        if (success) {
            if (status == ZXAPI_SUCCESS) {
                patientInfo = patient;
                if (list && [list count]) {
                    itemList = [list mutableCopy];
                }else{
                    [ZXEmptyView showNoDataInView:self.view text1:@"该化验单无记录详情" text2:nil heightFix:0];
                }
                [self zx_addRightBarItemsWithTexts:@[@"删除"] font:nil color:nil];
                [self updateUI];
            }else{
                if (status != ZXAPI_LOGIN_INVALID) {
//                    [ZXHUD MBShowFailureInView:self.view text:errorMsg delay:2.0];
                    [ZXAlertUtils showAAlertMessage:errorMsg title:@"提示" buttonText:@"确定" buttonAction:^{
                        [self.navigationController popViewControllerAnimated:true];
                    }];
                }else{
                    [self.navigationController popViewControllerAnimated:true];
                }
            }
        }else{
            if (status == ZXAPI_HTTP_TIME_OUT) {
                [ZXAlertUtils showAAlertMessage:errorMsg title:@"提示" buttonText:@"确定" buttonAction:^{
                    [self.navigationController popViewControllerAnimated:true];
                }];
            }else{
                [ZXEmptyView showNetworkErrorInView:self.view heightFix:0 refreshAction:^{
                    [ZXEmptyView dismissInView:self.view];
                    [self loadReportListDetailShowHUD:true];
                }];
            }
        }
    }];
}

- (void)updateUI{
    if (patientInfo) {
        if (patientInfo.imgStr.length) {
            [_btnBrowseDetailImage setTitle:@"查看原图" forState:UIControlStateNormal];
            [self.imgReport sd_setImageWithURL:[NSURL URLWithString:patientInfo.imgStr]];
        }else{
            [_btnBrowseDetailImage setTitle:@"图片丢失" forState:UIControlStateNormal];
            [self.imgReport setImage:nil];
        }
    }
    [self.tblReportItems reloadData];
}


- (IBAction)browseDetailImageAction:(id)sender {
    if (patientInfo && patientInfo.imgStr.length) {
        MJPhotoBrowser *brower = [[MJPhotoBrowser alloc] init];
        NSMutableArray *photos = [NSMutableArray array];
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.url = [NSURL URLWithString:patientInfo.imgStr];
        [photos addObject:photo];
        brower.showSaveBtn = false;
        brower.photos = photos;
        [brower show];
    }
}



- (IBAction)browseResultAction:(id)sender {
    HReportResultViewController * resultVC = [[HReportResultViewController alloc] init];
    resultVC.isAbnormal = patientInfo.isAbnormal;
    resultVC.reportId = _reportId;
    [self.navigationController pushViewController:resultVC animated:true];
}


#pragma mark -

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {//性别 年龄
        HItemSexAgeTableCell * sexAge = [tableView dequeueReusableCellWithIdentifier:@"HItemSexAgeTableCell" forIndexPath:indexPath];
        [sexAge loadSexAge:patientInfo];
        return sexAge;
    }else{
        if (indexPath.row == 0) {//标题
            HIRHeaderTableCell * header = [tableView dequeueReusableCellWithIdentifier:@"HIRHeaderTableCell" forIndexPath:indexPath];
            return header;
        }else{//检查项
            ZXItemShortModel * model = itemList[indexPath.row - 1];
            HItemResultTableCell * item = [tableView dequeueReusableCellWithIdentifier:@"HItemResultTableCell" forIndexPath:indexPath];
            [item reloadItemData:model];
            return item;
        }
    }
    
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (itemList && itemList.count) {
        if (section == 0) {//性别 年龄
            return 1;
        }else{//标题 + 检查项
            return itemList.count + 1;
        }
    }
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [[UIView alloc] init];
    [view setBackgroundColor:[UIColor zx_assistColor]];
    return view;
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
