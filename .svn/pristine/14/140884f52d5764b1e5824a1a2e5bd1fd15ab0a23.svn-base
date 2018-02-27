//
//  HCashCouponViewController.m
//  YDHYK
//
//  Created by screson on 2016/12/9.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "HCashCouponViewController.h"
#import "HCashCouponTableCell.h"
#import "ZXCashCouponViewModel.h"

@interface HCashCouponViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSInteger currentIndex;
    NSInteger pageTotal;
    NSMutableArray<ZXCashCouponModel *> * arrCashCouponModel;
}
@property (weak, nonatomic) IBOutlet UITableView *tblCashCouponList;

@end

@implementation HCashCouponViewController

- (instancetype)init{
    if (self = [super init]) {
        [self setHidesBottomBarWhenPushed:true];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   
    currentIndex = 1;
    pageTotal = 1;
    
    [self.view setBackgroundColor:[UIColor zx_assistColor]];
    [self.tblCashCouponList setBackgroundColor:[UIColor zx_assistColor]];
    [self.tblCashCouponList registerNib:[UINib nibWithNibName:@"HCashCouponTableCell" bundle:nil] forCellReuseIdentifier:@"HCashCouponTableCell"];
    
    [self.tblCashCouponList zx_addHeaderRefreshActionUseZXImage:true target:self action:@selector(refreshAction)];
    [self.tblCashCouponList zx_addFooterRefreshActionAutoRefresh:true target:self action:@selector(loadMoreAction)];
    [self.tblCashCouponList.mj_header beginRefreshing];
    
    if (_isValid) {
        [self setTitle:@"现金券"];
        [self zx_addRightBarItemsWithTexts:@[@"已失效"] font:nil color:nil];
    }else{
        [self setTitle:@"已失效的现金券"];
    }
}

- (void)refreshAction{
    currentIndex = 1;
    pageTotal = 1;
    [self.tblCashCouponList.mj_footer resetNoMoreData];
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
    [ZXCashCouponViewModel getCashCouponListWithMemberId:[[ZXGlobalData shareInstance] memberId] isValid:_isValid pageNum:currentIndex pageSize:ZXPAGE_SIZE token:[[ZXGlobalData shareInstance] userToken] completion:^(NSArray<ZXCashCouponModel *> *list, NSInteger totalPage, NSInteger status, BOOL success, NSString *errorMsg) {
        if (bShow) {
            [ZXHUD MBHideForView:self.view animate:true];
        }
        [self.tblCashCouponList.mj_footer endRefreshing];
        [self.tblCashCouponList.mj_header endRefreshing];
        if (success) {
            if (status == ZXAPI_SUCCESS) {
                pageTotal = totalPage;
                if (currentIndex == 1) {
                    if (list && [list count]) {
                        arrCashCouponModel = [list mutableCopy];
                    }else{
                        if (_isValid) {
                            [ZXEmptyView showNoDataInView:self.view text1:@"您还没有可用的现金券" text2:nil heightFix:0];
                        }else{
                            [ZXEmptyView showNoDataInView:self.view text1:@"没有相关记录" text2:nil heightFix:0];
                        }
                    }
                }else{
                    if (list && [list count]) {
                        [arrCashCouponModel addObjectsFromArray:list];
                    }
                }
                if (currentIndex >= pageTotal) {
                    [self.tblCashCouponList.mj_footer endRefreshingWithNoMoreData];
                }
                [self.tblCashCouponList reloadData];
            }else{
                if (status != ZXAPI_LOGIN_INVALID) {
                    [ZXHUD MBShowFailureInView:self.view text:errorMsg delay:2.0];
                }
            }
        }else{
            if (status == ZXAPI_HTTP_TIME_OUT) {
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

- (void)zx_rightBarButtonActionsIndex:(NSInteger)index{
    HCashCouponViewController * invalidCoupon = [[HCashCouponViewController alloc] init];
    invalidCoupon.isValid = false;
    [self.navigationController pushViewController:invalidCoupon animated:true];
}


#pragma mark - DataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HCashCouponTableCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HCashCouponTableCell" forIndexPath:indexPath];
    if (_isValid) {
        [cell reloadCashCouponInfo:arrCashCouponModel[indexPath.section] expired:false];
    }else{
        [cell reloadCashCouponInfo:arrCashCouponModel[indexPath.section] expired:true];
    }
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (arrCashCouponModel && arrCashCouponModel.count) {
        return arrCashCouponModel.count;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

#pragma mark - Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 134;
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
