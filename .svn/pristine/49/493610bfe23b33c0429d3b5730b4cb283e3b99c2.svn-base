//
//  HReportModelViewController.m
//  YDHYK
//
//  Created by screson on 2016/12/12.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "HReportModelViewController.h"
#import "HCheckItemTableCell.h"
#import "ZXCommonViewModel.h"
#import "ZXReportAnalyseViewModel.h"


@interface HReportModelViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray * arrModelName;
}
@property (weak, nonatomic) IBOutlet UITableView *tblModelList;

@end

@implementation HReportModelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"模板"];
    [self zx_addRightBarItemsWithTexts:@[@"完成"] font:nil color:nil];
    arrModelName = @[];
    [_tblModelList setBackgroundColor:[UIColor zx_assistColor]];
    [_tblModelList setSeparatorColor:[UIColor zx_separatorColor]];
    [_tblModelList registerNib:[UINib nibWithNibName:@"HCheckItemTableCell" bundle:nil] forCellReuseIdentifier:@"HCheckItemTableCell"];
    [_tblModelList setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    
    [self.tblModelList zx_addHeaderRefreshActionUseZXImage:true target:self action:@selector(refreshAction)];
    [self.tblModelList.mj_header beginRefreshing];
}


- (void)refreshAction{
    [self getCheckTemplateShowHUD:false];
}

- (void)getCheckTemplateShowHUD:(BOOL)bShow{
    if (bShow) {
        [ZXHUD MBShowLoadingInView:self.view text:ZX_LOADING_TEXT delay:0];
    }
    [ZXCommonViewModel getConstDicListByType:HConstDicTypeCheckTemplate completion:^(NSArray<ZXConstDicModel *> *list, NSInteger status, BOOL success, NSString *errorMsg) {
        if (bShow) {
            [ZXHUD MBHideForView:self.view animate:true];
        }
        [self.tblModelList.mj_header endRefreshing];
        if (success) {
            if (status == ZXAPI_SUCCESS) {
                if (list && [list count]) {
                    arrModelName = [list mutableCopy];
                }else{
                    [ZXEmptyView showNoDataInView:self.view text1:@"暂无化验单模板" text2:nil heightFix:0];
                }
                [self.tblModelList reloadData];
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
                    [self getCheckTemplateShowHUD:true];
                }];
            }
        }
    }];
}

//MARK: 获取模板检查项 并返回
- (void)zx_rightBarButtonActionsIndex:(NSInteger)index{
    NSIndexPath * indexPath = [self.tblModelList indexPathForSelectedRow];
    if (indexPath) {
        ZXConstDicModel * constModel = arrModelName[indexPath.row];
        [ZXHUD MBShowLoadingInView:self.view text:@"获取模板检查项..." delay:0];
        [ZXReportAnalyseViewModel getCheckItemListByTemplateKey:constModel.key memberId:[[ZXGlobalData shareInstance] memberId] token:[[ZXGlobalData shareInstance] userToken] completion:^(NSArray<ZXCheckItemListModel *> *list, NSInteger status, BOOL success, NSString *errorMsg) {
            [ZXHUD MBHideForView:self.view animate:true];
            if (success) {
                if (status == ZXAPI_SUCCESS) {
                    if (list && list.count) {
                        [self.navigationController popViewControllerAnimated:true];
                        if (_checkEnd) {
                            _checkEnd(list);
                        }
                    }else{
                        [ZXHUD MBShowFailureInView:self.view text:@"该模板检查项为空" delay:1.5];
                    }
                }else{
                    if (status != ZXAPI_LOGIN_INVALID) {
                        [ZXHUD MBShowFailureInView:self.view text:errorMsg delay:1.5];
                    }
                }
            }else{
                [ZXHUD MBShowFailureInView:self.view text:errorMsg delay:1.5];
            }
        }];
    }else{
        [ZXHUD MBShowFailureInView:self.view text:@"请选择模板" delay:1.5];
    }
}

#pragma mark - TableView DataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HCheckItemTableCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HCheckItemTableCell" forIndexPath:indexPath];
    ZXConstDicModel * constModel = arrModelName[indexPath.row];
    cell.lbItemName.text = constModel.value;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (arrModelName && arrModelName.count) {
        return arrModelName.count;
    }
    return 0;
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
