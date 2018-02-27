//
//  HOrderListViewController.m
//  YDHYK
//
//  Created by screson on 2016/12/7.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "HOrderListViewController.h"
#import "HDrugHeaderTableCell.h"
#import "HDrugTableCell.h"
#import "HDrugFooterTableCell.h"

//
#import "HCheckCodeViewController.h"
#import "HOrderDetailViewController.h"
#import "ZXOrderListViewModel.h"

#import "YDHYK-Swift.h"

@interface HOrderListViewController ()<UITableViewDelegate,UITableViewDataSource,HDrugFooterTableCellDelegate>
{
    NSInteger currentIndex;
    NSInteger pageTotal;
    NSMutableArray<ZXOrderListModel *> * arrOrderList;
}
@property (weak, nonatomic) IBOutlet UITableView *tblOrderList;

@end

@implementation HOrderListViewController


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
    currentIndex = 1;
    pageTotal = 1;
    
    [self.view setBackgroundColor:[UIColor zx_assistColor]];
    
    [self.tblOrderList setBackgroundColor:[UIColor zx_assistColor]];
//    [self.tblOrderList setSeparatorColor:[UIColor zx_separatorColor]];
    [self.tblOrderList setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [self.tblOrderList registerNib:[UINib nibWithNibName:@"HDrugHeaderTableCell" bundle:nil] forCellReuseIdentifier:@"HDrugHeaderTableCell"];
    [self.tblOrderList registerNib:[UINib nibWithNibName:@"HDrugTableCell" bundle:nil] forCellReuseIdentifier:@"HDrugTableCell"];
    [self.tblOrderList registerNib:[UINib nibWithNibName:@"HDrugFooterTableCell" bundle:nil] forCellReuseIdentifier:@"HDrugFooterTableCell"];
    
    [self.tblOrderList zx_addHeaderRefreshActionUseZXImage:true target:self action:@selector(refreshAction)];
    [self.tblOrderList zx_addFooterRefreshActionAutoRefresh:true target:self action:@selector(loadMoreAction)];
    
    [self setTitleInfo];
    [self.tblOrderList.mj_header beginRefreshing];
    
    [ZXNotificationCenter addObserver:self selector:@selector(refreshAction) name:@"ZX_UPDATE_ORDERLIST_NOTICE" object:nil];
}


- (void)refreshAction{
    currentIndex = 1;
    pageTotal = 1;
    [self.tblOrderList.mj_footer resetNoMoreData];
    [self getOrderListShowHUD:false];
}

- (void)loadMoreAction{
    currentIndex++;
    [self getOrderListShowHUD:false];
}

- (void)getOrderListShowHUD:(BOOL)bShow{
    if (bShow) {
        [ZXHUD MBShowLoadingInView:self.view text:ZX_LOADING_TEXT delay:0];
    }
    [ZXOrderListViewModel getOrderListWithMemberId:[[ZXGlobalData shareInstance] memberId] dispatchWay:_dispatchWay orderType:_orderStatus pageNum:currentIndex pageSize:ZXPAGE_SIZE token:[[ZXGlobalData shareInstance] userToken] completion:^(NSArray<ZXOrderListModel *> *orderList, NSInteger totalPage, NSInteger status, BOOL success, NSString *errorMsg) {
        if (bShow) {
            [ZXHUD MBHideForView:self.view animate:true];
        }
        [self.tblOrderList.mj_footer endRefreshing];
        [self.tblOrderList.mj_header endRefreshing];
        if (success) {
            if (status == ZXAPI_SUCCESS) {
                pageTotal = totalPage;
                if (currentIndex == 1) {
                    if (orderList && [orderList count]) {
                        arrOrderList = [orderList mutableCopy];
                    }else{
                        [ZXEmptyView showNoDataInView:self.view text1:@"暂无订单数据" text2:nil heightFix:0];
                    }
                }else{
                    if (orderList && [orderList count]) {
                        [arrOrderList addObjectsFromArray:orderList];
                    }
                }
                if (currentIndex >= pageTotal) {
                    [self.tblOrderList.mj_footer endRefreshingWithNoMoreData];
                }
                [self.tblOrderList reloadData];
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
                    [self getOrderListShowHUD:true];
                }];
            }
            
        }
    }];
}

- (void)setTitleInfo{
    switch (_orderStatus) {
        case HDrugOrderTypeWaitPay:
        {
            [self setTitle:@"待付款"];
        }
            break;
        case HDrugOrderTypeWaitTake:
        {
            [self setTitle:@"待提货"];
        }
            break;
        case HDrugOrderTypeWaitDispatch:
        {
            [self setTitle:@"待发货"];
        }
            break;
        case HDrugOrderTypeDispatched:
        {
            [self setTitle:@"待收货"];
        }
            break;
        case HDrugOrderTypeDone:
        {
            [self setTitle:@"已完成"];
        }
            break;
        case HDrugOrderTypeCancel:
        {
            [self setTitle:@"已取消"];
        }
            break;
        case HDrugOrderTypeRefund:
        {
            [self setTitle:@"退款中"];
        }
            break;
        case HDrugOrderTypeAll:
        {
            [self setTitle:@"全部订单"];
        }
            break;
        default:
        {
            [self setTitle:@"全部订单"];
        }
            break;
    }
}



#pragma mark - TableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (arrOrderList && arrOrderList.count) {
        return arrOrderList.count;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    ZXOrderListModel * orderModel = [arrOrderList objectAtIndex:section];
    NSArray * arrGoods = orderModel.orderDetailList;
    if ([arrGoods isKindOfClass:[NSArray class]]) {
        return arrGoods.count + 2;//多一行header 和footer
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZXOrderListModel * orderModel = [arrOrderList objectAtIndex:indexPath.section];//section
    if (indexPath.row == 0) {//抬头 店铺信息
        HDrugHeaderTableCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HDrugHeaderTableCell" forIndexPath:indexPath];
        [cell reloadStoreInfo:orderModel];
        return cell;
    }else if (indexPath.row == orderModel.orderDetailList.count + 1){//订单总价格
        HDrugFooterTableCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HDrugFooterTableCell" forIndexPath:indexPath];
        [cell setDelegate:self];
        [cell reloadOrderInfo:orderModel];
        return cell;
    }else{//商品信息
        HDrugTableCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HDrugTableCell" forIndexPath:indexPath];
        NSInteger index = indexPath.row - 1;//第一行为店铺
        [cell reloadGoodsInfo:[orderModel.orderDetailList objectAtIndex:index]];
        return cell;
    }
    return nil;
}

#pragma mark - TableViewDelegagte

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZXOrderListModel * orderModel = [arrOrderList objectAtIndex:indexPath.section];//section
    if (indexPath.row == 0) {//第一行店铺
        return 67;
    }else if (indexPath.row == (orderModel.orderDetailList.count + 1)){//最后一行操作 总价、操作
        return 81;
    }
    return 70;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ZXOrderListModel * orderModel = [arrOrderList objectAtIndex:indexPath.section];//section
    if (indexPath.row == 0) {//跳转到店铺主页
        if (![[[ZXGlobalData shareInstance] userTelephone] isEqualToString:ZXAPP_Common_TestAccount]) {
            ZXStoreRootViewController * webStore = [ZXStoreRootViewController configVCWith:orderModel.drugstoreId memberId:[[ZXGlobalData shareInstance] memberId] token:[[ZXGlobalData shareInstance] userToken]];

            [self.navigationController pushViewController:webStore animated:true];
        }
    }else{
        HOrderDetailViewController * orderDetailVC = [[HOrderDetailViewController alloc] init];
        orderDetailVC.orderId = orderModel.orderId;
        [self.navigationController pushViewController:orderDetailVC animated:true];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Control Order

- (void)orderControlButtonActionType:(HOrderControlActionType)type controlCell:(HDrugFooterTableCell *)cell{
    NSIndexPath * indexPath = [self.tblOrderList indexPathForCell:cell];
    ZXOrderListModel * orderModel = [arrOrderList objectAtIndex:indexPath.section];//section
    switch (type) {
        case HOrderControlActionTypeToPay://马上支付
        {
            NSLog(@"马上支付");
        }
            break;
        case HOrderControlActionTypeCheckCode://查看提货码
        {
            HCheckCodeViewController * checkCodeVC = [[HCheckCodeViewController alloc] init];
            checkCodeVC.orderId = orderModel.orderId;
            [self.navigationController pushViewController:checkCodeVC animated:true];
            NSLog(@"查看提货码");
        }
            break;
        case HOrderControlActionTypeConfirmSign://确认收货
        {
            NSLog(@"确认收货");
            [self changeOrderStatusByType:HDrugOrderTypeDone atSectionIndex:indexPath.section];
        }
            break;
        case HOrderControlActionTypeCancelOrder://取消订单
        {
            NSLog(@"取消订单");
            [self changeOrderStatusByType:HDrugOrderTypeCancel atSectionIndex:indexPath.section];
        }
            break;
        case HOrderControlActionTypeDeleteOrder://删除订单
        {
            NSLog(@"删除订单");
            [self changeOrderStatusByType:HDrugOrderTypeInvalid atSectionIndex:indexPath.section];
        }
            break;
        default:
            break;
    }
}


#pragma mark - 订单操作
- (void)changeOrderStatusByType:(HDrugOrderType)type atSectionIndex:(NSInteger)index{
     ZXOrderListModel * orderModel = [arrOrderList objectAtIndex:index];//section
    
    NSString * controlTile = @"订单操作...";
    NSArray  * arrButtonTitle = @[@"放弃",@"确定"];
    switch (type) {
        case HDrugOrderTypeInvalid:
        {
            controlTile = @"确定删除订单?";
            arrButtonTitle = @[@"放弃",@"确定"];
        }
            break;
        case HDrugOrderTypeCancel:
        {
            controlTile = @"确定取消订单?";
            arrButtonTitle = @[@"放弃",@"确定"];
        }
            break;
        case HDrugOrderTypeDone:
        {
            controlTile = @"请确保已经收到您的物品哦?";
            arrButtonTitle = @[@"稍后",@"确定"];
            
        }
            break;
        default:
            break;
    }
    //HDrugOrderTypeInvalid 删除订单 置为无效
    if (type == HDrugOrderTypeInvalid ||
        type == HDrugOrderTypeCancel ||
        type == HDrugOrderTypeDone) {
        [ZXAlertUtils showAAlertMessage:controlTile title:@"提示" buttonTexts:arrButtonTitle buttonAction:^(int buttonIndex) {
            if (buttonIndex == 1) {
                [ZXHUD MBShowLoadingInView:self.view text:@"操作中..." delay:0];
                [ZXOrderListViewModel changeOrderStatusByID:orderModel.orderId status:type memberId:[[ZXGlobalData shareInstance] memberId] token:[[ZXGlobalData shareInstance] userToken] completion:^(BOOL success, NSInteger status, BOOL apiSuccess, NSString *errorMsg) {
                    [ZXHUD MBHideForView:self.view animate:true];
                    if (success) {
                        if (_orderStatus == HDrugOrderTypeAll && type != HDrugOrderTypeInvalid) {//全部订单操作（取消、完成不删除） 还会显示在当前界面
                            [self refreshAction];
                            [ZXHUD MBShowSuccessInView:self.view text:@"订单操作成功" delay:1.2];
                        }else{
                            [arrOrderList removeObjectAtIndex:index];
                            [_tblOrderList deleteSections:[NSIndexSet indexSetWithIndex:index] withRowAnimation:UITableViewRowAnimationAutomatic];
                            if (arrOrderList.count == 0) {
                                [self refreshAction];
                            }
                        }
                        
                    }else{
                        [ZXHUD MBShowFailureInView:self.view text:errorMsg delay:1.5];
                    }
                }];
            }
        }];
    }
}

- (void)dealloc{
    [ZXNotificationCenter removeObserver:self name:@"ZX_UPDATE_ORDERLIST_NOTICE" object:nil];
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
