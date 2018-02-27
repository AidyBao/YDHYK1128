//
//  HReportResultViewController.m
//  ydhyk
//
//  Created by screson on 2016/11/23.
//  Copyright © 2016年 120v. All rights reserved.
//

#import "HReportResultViewController.h"
#import "HAnalyseResultCell.h"
#import "ZXReportAnalyseViewModel.h"
#import "HNewReportRecordViewController.h"

@interface HReportResultViewController ()<UITableViewDataSource,UINavigationControllerDelegate>
{
    NSArray<ZXAnalyseResutItemModel *> * arrResults;
    __weak IBOutlet UIView *contentView;
    __weak IBOutlet UIImageView *imgStatus;
    __weak IBOutlet UILabel *lbResult;
    __weak IBOutlet UITableView *tblResultList;
    __weak IBOutlet UIButton *btnNewAnalyse;
    
}
@end

@implementation HReportResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"分析结果详情"];
    
    [self.view setBackgroundColor:[UIColor zx_navbarColor]];
    
    [lbResult setHighlightedTextColor:[UIColor zx_customBColor]];
    
    [contentView.layer setMasksToBounds:true];
    [contentView.layer setCornerRadius:5.0];
    
    [btnNewAnalyse.layer setMasksToBounds:true];
    [btnNewAnalyse.layer setCornerRadius:5.0];
    [btnNewAnalyse.titleLabel setFont:[UIFont zx_titleFontWithSize:zx_navBarTitleFontSize()]];
    
    [tblResultList registerNib:[UINib nibWithNibName:@"HAnalyseResultCell" bundle:nil] forCellReuseIdentifier:@"HAnalyseResultCell"];
    [tblResultList setSeparatorColor:[UIColor zx_separatorColor]];
    [tblResultList setEstimatedRowHeight:100];
    [tblResultList setRowHeight:UITableViewAutomaticDimension];
    [tblResultList setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    
    [self reloadResults];
    
    if (!_pushFromNewReportVC) {
        [self zx_addRightBarItemsWithTexts:@[@"分析记录"] font:nil color:nil];
    }
    [self loadResultListShowHUD:true];
    
    self.navigationController.delegate = self;
}

- (void)loadResultListShowHUD:(BOOL)bShow{
    if (!_isAbnormal) {
        [self reloadResults];
        return;
    }
    if (bShow) {
        [ZXHUD MBShowLoadingInView:self.view text:ZX_LOADING_TEXT delay:0];
    }
    [ZXReportAnalyseViewModel getAnalyseResultByReportId:_reportId memberId:[[ZXGlobalData shareInstance] memberId] token:[[ZXGlobalData shareInstance] userToken] completion:^(NSArray<ZXAnalyseResutItemModel *> *list, NSInteger status, BOOL success, NSString *errorMsg) {
        if (bShow) {
            [ZXHUD MBHideForView:self.view animate:true];
        }
        if (success) {
            if (status == ZXAPI_SUCCESS) {
                if (list && [list count]) {
                    arrResults = [list mutableCopy];
                }
                [self reloadResults];
            }else{
                if (status != ZXAPI_LOGIN_INVALID) {
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
                    [self loadResultListShowHUD:true];
                }];
            }
        }
    }];
}
//返回分析记录列表
- (void)zx_rightBarButtonActionsIndex:(NSInteger)index{
    [self zx_popToViewControllerwithClassName:@"HReportListViewController" animated:true];
}

- (void)reloadResults{
    if (arrResults && arrResults.count) {
        [imgStatus setHighlighted:true];
        [lbResult  setHighlighted:true];
        [lbResult  setText:[NSString stringWithFormat:@"发现%lu个异常点",(unsigned long)arrResults.count]];
    }else{
        [imgStatus setHighlighted:false];
        [lbResult  setHighlighted:false];
        [lbResult  setText:@"未发现异常点"];
    }
    if (tblResultList) {
        [tblResultList reloadData];
    }
}

//创建新的分析
- (IBAction)createNewAnalyse:(id)sender {
    //[HReportAnalyseRootViewController alloc]
//     [self zx_popToViewControllerwithClassName:@"HReportAnalyseRootViewController" animated:true];
         [self zx_popToViewControllerwithClassName:@"HNewReportRecordViewController" animated:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (arrResults && arrResults.count) {
        return arrResults.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HAnalyseResultCell * cell = (HAnalyseResultCell *)[tableView dequeueReusableCellWithIdentifier:@"HAnalyseResultCell" forIndexPath:indexPath];
    
    //Test
    ZXAnalyseResutItemModel * model = [arrResults objectAtIndex:indexPath.row];
    cell.lbItemName.text = model.itemName;
    cell.lbStatus.text   = model.resultValue;
    cell.lbResult.text   = model.abnormalReason;
    
    return cell;
}

#pragma mark - Nav Delegate
//[HReportAnalyseRootViewController alloc]
//- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
//    if ([viewController isKindOfClass:[HNewReportRecordViewController class]]) {
//        [navigationController popViewControllerAnimated:false];
//    }
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
