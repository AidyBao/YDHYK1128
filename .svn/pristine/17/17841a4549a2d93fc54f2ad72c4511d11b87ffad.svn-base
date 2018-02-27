//
//  HReportListViewController.m
//  ydhyk
//
//  Created by screson on 2016/11/22.
//  Copyright © 2016年 120v. All rights reserved.
//

#import "HReportListViewController.h"
#import "HRepostListCell.h"
#import "HReportDetialViewController.h"
#import "ZXReportAnalyseViewModel.h"

NSString * const RCellID = @"RECELLID";

@interface HReportListViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger currentIndex;
    NSInteger pageTotal;
    NSMutableArray<ZXReportListModel *> * arrReportList;
}
@property (weak, nonatomic) IBOutlet UITableView *tblReportList;

@end

@implementation HReportListViewController

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.tblReportList setEditing:false animated:true];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"分析记录"];
    currentIndex = 1;
    pageTotal = 1;
    
    [self.view setBackgroundColor:[UIColor zx_assistColor]];
    [self.tblReportList setBackgroundColor:[UIColor zx_assistColor]];
    [self.tblReportList setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [self.tblReportList registerNib:[UINib nibWithNibName:@"HRepostListCell" bundle:nil] forCellReuseIdentifier:RCellID];
    
    [self.tblReportList zx_addHeaderRefreshActionUseZXImage:true target:self action:@selector(refreshAction)];
    [self.tblReportList zx_addFooterRefreshActionAutoRefresh:true target:self action:@selector(loadMoreAction)];
    [self.tblReportList.mj_header beginRefreshing];
    
    
    [ZXNotificationCenter addObserver:self selector:@selector(refreshAction) name:@"ZXReportListUpdate" object:nil];
}


- (void)refreshAction{
    currentIndex = 1;
    pageTotal = 1;
    [self.tblReportList.mj_footer resetNoMoreData];
    [self getPrescriptionListShowHUD:false];
}

- (void)loadMoreAction{
    currentIndex++;
    [self getPrescriptionListShowHUD:false];
}

- (void)getPrescriptionListShowHUD:(BOOL)bShow{
    if (bShow) {
        [ZXHUD MBShowLoadingInView:self.view text:ZX_LOADING_TEXT delay:0];
    }
    [ZXReportAnalyseViewModel getLabReportListWithMemberId:[[ZXGlobalData shareInstance] memberId] pageNum:currentIndex pageSize:ZXPAGE_SIZE token:[[ZXGlobalData shareInstance] userToken] completion:^(NSArray<ZXReportListModel *> *list, NSInteger totalPage, NSInteger status, BOOL success, NSString *errorMsg) {
        if (bShow) {
            [ZXHUD MBHideForView:self.view animate:true];
        }
        [self.tblReportList.mj_footer endRefreshing];
        [self.tblReportList.mj_header endRefreshing];
        if (success) {
            if (status == ZXAPI_SUCCESS) {
                pageTotal = totalPage;
                if (currentIndex == 1) {
                    if (list && [list count]) {
                        arrReportList = [list mutableCopy];
                    }else{
                        [ZXEmptyView showNoDataInView:self.view text1:@"暂无化验单记录" text2:nil heightFix:0];
                    }
                }else{
                    if (list && [list count]) {
                        [arrReportList addObjectsFromArray:list];
                    }
                }
                if (currentIndex >= pageTotal) {
                    [self.tblReportList.mj_footer endRefreshingWithNoMoreData];
                }
                [self.tblReportList reloadData];
            }else{
                if (status != ZXAPI_LOGIN_INVALID) {
                    [ZXHUD MBShowFailureInView:self.view text:errorMsg delay:2.0];
                }
            }
        }else{
            if (status == ZXAPI_HTTP_TIME_OUT || status == ZXAPI_LOGIN_INVALID) {
                [ZXHUD MBShowFailureInView:self.view text:errorMsg delay:2.0];
            }else{
                [ZXEmptyView showNetworkErrorInView:self.view heightFix:0 refreshAction:^{
                    [ZXEmptyView dismissInView:self.view];
                    [self getPrescriptionListShowHUD:true];
                }];
            }
        }
    }];
}


#pragma mark -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (arrReportList && arrReportList.count) {
        return arrReportList.count;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HRepostListCell * cell = [tableView dequeueReusableCellWithIdentifier:RCellID forIndexPath:indexPath];
    [cell reloadReport:arrReportList[indexPath.section]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * v = [[UIView alloc] init];
    [v setBackgroundColor:[UIColor zx_assistColor]];
    return v;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return true;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [ZXAlertUtils showAAlertMessage:@"确定删除化验单及分析结果记录" title:@"提示" buttonTexts:@[@"取消",@"删除"] buttonAction:^(int buttonIndex) {
            if (buttonIndex == 1) {
                [ZXHUD MBShowLoadingInView:self.view text:@"删除中..." delay:0];
                ZXReportListModel * model = arrReportList[indexPath.section];
                [ZXReportAnalyseViewModel deleteAnalyseReportWithId:model.reportId memberId:[[ZXGlobalData shareInstance] memberId] token:[[ZXGlobalData shareInstance]  userToken] completion:^(BOOL success, NSInteger status, BOOL reqSuccess, NSString *errorMsg) {
                    [ZXHUD MBHideForView:self.view animate:true];
                    if (success) {
                        [arrReportList removeObjectAtIndex:indexPath.section];
                        [tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
                        if (arrReportList.count == 0) {
                            [self getPrescriptionListShowHUD:true];
                        }
                    }else{
                        if (status != ZXAPI_LOGIN_INVALID) {
                            [ZXHUD MBShowFailureInView:self.view text:errorMsg delay:1.5];
                        }
                    }
                }];
            }else{
                [self.tblReportList setEditing:false animated:true];
            }
        }];
    }
}

#pragma mark -

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ZXReportListModel * model = arrReportList[indexPath.section];
    HReportDetialViewController * detailVC = [[HReportDetialViewController alloc] init];
    detailVC.reportId = model.reportId;
    [self.navigationController pushViewController:detailVC animated:true];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc{
    [ZXNotificationCenter removeObserver:self name:@"ZXReportListUpdate" object:nil];
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
