//
//  HPersonalViewController.m
//  YDHYK
//
//  Created by JuanFelix on 30/11/2016.
//  Copyright © 2016 screson. All rights reserved.
//

#import "HPersonalViewController.h"
#import "HPHeaderView.h"
#import "HTextTableDelegate.h"
#import "HTextTableDataSource.h"
#import "HTextTableCell.h"
#import "HOrderMenuTableCell.h"
#import "HToolsMenuTableCell.h"
#import "HPersonalMenuActionProtocol.h"
#import "HQRScanViewController.h"

//
#import "HSystemMessageViewController.h"
#import "HReportAnalyseRootViewController.h"
#import "HNewReportRecordViewController.h"
#import "HOrderListViewController.h"
#import "HPrescriptionViewController.h"
#import "HCashCouponViewController.h"
#import "HGiftViewController.h"
#import "HAppointmentViewController.h"
#import "HDrugCollectViewController.h"
/** 编辑资料*/
#import "YDEditProfileTableViewController.h"
/** 设置*/
#import "YDSettingViewController.h"
/** 用药提醒*/
#import "YDDrugRemindViewController.h"

#import "ZXCommonViewModel.h"

@interface HPersonalViewController ()<HPersonalMenuActionProtocol,UINavigationControllerDelegate>
{
    BOOL isloading;
}
@property (nonatomic,strong) UIView * topBackView;
@property (nonatomic,strong) HPHeaderView * headerView;
@property (weak, nonatomic) IBOutlet UITableView *tblPersonalMenu;
@property (strong, nonatomic) IBOutlet HTextTableDelegate *textTblDelegate;
@property (strong, nonatomic) IBOutlet HTextTableDataSource *textTblDataSource;


@end

@implementation HPersonalViewController

- (instancetype)init{
    if (self = [super init]) {
        [self setHidesBottomBarWhenPushed:false];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self reloadUIData];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self zx_setNavBarBackgroundColor:[UIColor zx_navbarColor]];
    [self performSelector:@selector(checkShowAllOrder) withObject:nil afterDelay:0.1];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self.tblPersonalMenu addSubview:self.topBackView];
}

- (void)reloadUIData{
    if (isloading) {
        return;
    }
    isloading = true;
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:true];
    [_headerView refreshData];
    [ZXCommonViewModel getAllUnReadMsgCountWithMemberId:[[ZXGlobalData shareInstance] memberId] token:[[ZXGlobalData shareInstance] userToken] completion:^(ZXAllUnReadCountModel *model, NSInteger status, BOOL success, NSString *errorMsg) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:false];
        isloading = false;
        if (model) {
            [ZXNotificationCenter postNotificationName:ZXNOTICE_UPDATE_UNREAD_MSG_COUNT object:model];
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"我的"];
    isloading = false;
    if (self.navigationController) {
        self.navigationController.delegate  = self;
    }
    [self setFd_prefersNavigationBarHidden:true];
    
//    UIView * topBackView = [[UIView alloc] initWithFrame:CGRectMake(0, -ZX_BOUNDS_HEIGHT + 2, ZX_BOUNDS_WIDTH, ZX_BOUNDS_HEIGHT)];
//    [topBackView setBackgroundColor:ZXRGB_COLOR(60, 158, 240)];
//    [_tblPersonalMenu addSubview:topBackView];
    [_tblPersonalMenu setBackgroundColor:[UIColor zx_assistColor]];
    if ([self.tblPersonalMenu respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tblPersonalMenu setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([self.tblPersonalMenu respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tblPersonalMenu setLayoutMargins:UIEdgeInsetsZero];
    }
    [_tblPersonalMenu setSeparatorColor:[UIColor zx_separatorColor]];
    [_tblPersonalMenu setShowsHorizontalScrollIndicator:false];
    [_tblPersonalMenu setShowsVerticalScrollIndicator:false];
    //菜单项
    [_tblPersonalMenu registerNib:[UINib nibWithNibName:HTEXTCELL_CELLID bundle:nil] forCellReuseIdentifier:HTEXTCELL_CELLID];
    //Orders
    [_tblPersonalMenu registerNib:[UINib nibWithNibName:HORDERMENU_CELLID bundle:nil] forCellReuseIdentifier:HORDERMENU_CELLID];
    //Tools
    [_tblPersonalMenu registerNib:[UINib nibWithNibName:HTOOLSMENU_CELLID bundle:nil] forCellReuseIdentifier:HTOOLSMENU_CELLID];
    //Header
    _headerView = [[HPHeaderView alloc] initWithFrame:CGRectMake(0, 0, ZX_BOUNDS_WIDTH, 160)];
    _headerView.delegate = self;
    [_tblPersonalMenu setTableHeaderView:_headerView];
    
    _textTblDelegate.delegate = self;
    _textTblDataSource.delegate = self;
    //
    [ZXNotificationCenter addObserver:self selector:@selector(reloadUIData) name:ZXNOTICE_RECEIVE_REMOTE_NOTICE object:nil];
}

- (void)checkShowAllOrder{
    id obj = [[NSUserDefaults standardUserDefaults] objectForKey:@"ZXOrderList"];
    if (obj && [obj integerValue] == 1) {
        HOrderListViewController * orderListVC = [[HOrderListViewController alloc] init];
        [orderListVC setDispatchWay:HDispatchWayAll];
        [orderListVC setOrderStatus:HDrugOrderTypeAll];
        [self.navigationController pushViewController:orderListVC animated:true];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"ZXOrderList"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

#pragma mark - 按钮事件
- (void)headerMenuActionsWithType:(HPMenuActionType)type{
    switch (type) {
        case HPMessageActionType://消息
        {
            HSystemMessageViewController * messageVC = [[HSystemMessageViewController alloc] init];
            [self.navigationController pushViewController:messageVC animated:true];
        }
            break;
        case HPSettingActionType://设置
        {
            YDSettingViewController *settingVC = [YDSettingViewController instantiateFromStoryboard];
            settingVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:settingVC animated:YES];

        }
            break;
        case HPEditInfoActionType://编辑资料
        {
            YDEditProfileTableViewController *profileVC = [YDEditProfileTableViewController instantiateFromStoryboard];
            profileVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:profileVC animated:YES];
        }
            break;
            
        default:
            break;
    }
}

- (void)orderMenuActionsWithIndex:(NSInteger)index{
    HOrderListViewController * orderListVC = [[HOrderListViewController alloc] init];
    switch (index) {
        case 0://全部订单
        {
            [orderListVC setDispatchWay:HDispatchWayAll];
            [orderListVC setOrderStatus:HDrugOrderTypeAll];
        }
            break;
        case 1://待付款
        {
            [orderListVC setDispatchWay:HDispatchWayAll];
            [orderListVC setOrderStatus:HDrugOrderTypeWaitPay];
        }
            break;
        case 2://待提货
        {
            [orderListVC setDispatchWay:HDispatchWaySelfTake];
            [orderListVC setOrderStatus:HDrugOrderTypeWaitTake];
        }
            break;
        case 3://待发货
        {
            [orderListVC setDispatchWay:HDispatchWayExpress];
            [orderListVC setOrderStatus:HDrugOrderTypeWaitDispatch];
        }
            break;
        case 4://待收货
        {
            [orderListVC setDispatchWay:HDispatchWayExpress];
            [orderListVC setOrderStatus:HDrugOrderTypeDispatched];
        }
            break;
        case 5://已完成
        {
            [orderListVC setDispatchWay:HDispatchWayAll];
            [orderListVC setOrderStatus:HDrugOrderTypeDone];
        }
            break;
            
        default:
            break;
    }
    [self.navigationController pushViewController:orderListVC animated:true];
}

- (void)toolsMenuActionsWithIndex:(NSInteger)index{
    switch (index) {
        case 0://用药提醒
        {
            YDDrugRemindViewController *drug = [YDDrugRemindViewController instantiateFromStoryboard];
            [self.navigationController pushViewController:drug animated:YES];
            
        }
            break;
        case 1://化验单分析
        {
            /* 
            // 暂无图片分析
            HReportAnalyseRootViewController * reportAnalyse = [[HReportAnalyseRootViewController alloc] init];
            [self.navigationController pushViewController:reportAnalyse animated:true];
             */
            HNewReportRecordViewController * addCheckItem = [[HNewReportRecordViewController alloc] init];
            [self.navigationController pushViewController:addCheckItem animated:true];
        }
            break;
        case 2://收藏
        {
            HDrugCollectViewController * drugCC = [[HDrugCollectViewController alloc] init];
            [self.navigationController pushViewController:drugCC animated:true];
        }
            break;
        case 3://处方
        {
            HPrescriptionViewController * preVC = [[HPrescriptionViewController alloc] init];
            [self.navigationController pushViewController:preVC animated:true];
        }
            break;
        case 4://预约
        {
            HAppointmentViewController * appointmentVC = [[HAppointmentViewController alloc] init];
            [self.navigationController pushViewController:appointmentVC animated:true];
        }
            break;
        case 5://现金券
        {
            HCashCouponViewController * cashCoupon = [[HCashCouponViewController alloc] init];
            cashCoupon.isValid = true;
            [self.navigationController pushViewController:cashCoupon animated:true];
        }
            break;
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - NavDelegate

//- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
//    if ([viewController isKindOfClass:[self class]] || [viewController isKindOfClass:[ZXWebEngine class]]) {
//        [navigationController setNavigationBarHidden:true animated:true];
//    }else{
//        [navigationController setNavigationBarHidden:false animated:true];
//    }
//}


- (UIView *)topBackView{
    if (!_topBackView) {
        _topBackView = [[UIView alloc] initWithFrame:CGRectMake(0, - ZX_BOUNDS_HEIGHT + 2, ZX_BOUNDS_WIDTH, ZX_BOUNDS_HEIGHT)];
//        [_topBackView setBackgroundColor:ZXRGB_COLOR(60, 158, 240)];
        [_topBackView setBackgroundColor:[UIColor zx_navbarColor]];
    }
    return _topBackView;
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
