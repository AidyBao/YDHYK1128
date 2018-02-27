//
//  HOrderDetailViewController.m
//  YDHYK
//
//  Created by screson on 2016/12/8.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "HOrderDetailViewController.h"

#import "HDrugHeaderTableCell.h"
#import "HDrugTableCell.h"
#import "HDrugOrderFooterNoControlTableCell.h"
#import "HDrugOrderPayInfoTableCell.h"

#import "HDrugOrderStatus.h"  //有进度状态
#import "HDrugOrderStatus2.h" //待付款  已取消

#import "ZXOrderListViewModel.h"
#import "HCheckCodeViewController.h"
#import "YDHYK-Swift.h"

@interface HOrderDetailViewController ()
{
    NSArray * arrOrderInfoTitles;
    ZXOrderListModel * orderDetailInfo;
    BOOL firstLoad;
}

//订单状态 进度
@property (nonatomic,strong) HDrugOrderStatus2 * status2;

//订单详细信息
@property (weak, nonatomic) IBOutlet UITableView *tblOrderInfo;
//底部操作
@property (weak, nonatomic) IBOutlet UIView   * vBottomControl;
@property (weak, nonatomic) IBOutlet UILabel  * lbTotalPrice;
@property (weak, nonatomic) IBOutlet UIButton * btnControl1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint * control1Width;

@property (weak, nonatomic) IBOutlet UIButton * btnControl2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint * lbTotalPriceRightOffset;//label 距离btnControl1 (94 / 14（无按钮2）)

@end

@implementation HOrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    arrOrderInfoTitles = @[@"取货人",@"联系电话",@"自提地址",@"订单号",@"支付方式",@"配送方式",@"下单时间"];
    firstLoad = true;
    
    arrOrderInfoTitles = @[@"收货人",@"联系电话",@"收货地址",@"订单号",@"支付方式",@"配送方式",@"下单时间"];
    
    [self setTitle:@"订单详情"];
    [self.view setBackgroundColor:[UIColor zx_assistColor]];
    [self.tblOrderInfo setBackgroundColor:[UIColor zx_assistColor]];
    
    
    //底部
    [_lbTotalPrice setFont:[UIFont zx_titleFontWithSize:zx_title1FontSize()]];
    [_lbTotalPrice setTextColor:[UIColor zx_textColor]];
    
    [_btnControl1.layer setCornerRadius:5];
    [_btnControl1.layer setMasksToBounds:true];
    [_btnControl1.titleLabel setFont:[UIFont zx_titleFontWithSize:14]];
    [_btnControl1.layer setBorderWidth:1.0];
    [_btnControl1 addTarget:self action:@selector(controlButton1Action) forControlEvents:UIControlEventTouchUpInside];
    
    [_btnControl2.layer setCornerRadius:5];
    [_btnControl2.layer setMasksToBounds:true];
    [_btnControl2.titleLabel setFont:[UIFont zx_titleFontWithSize:14]];
    [_btnControl2.layer setBorderWidth:1.0];
    [_btnControl2 addTarget:self action:@selector(controlButton2Action) forControlEvents:UIControlEventTouchUpInside];
    //订单数据Table
    [self.tblOrderInfo setBackgroundColor:[UIColor zx_assistColor]];
//    [self.tblOrderInfo setSeparatorColor:[UIColor zx_separatorColor]];
    [self.tblOrderInfo setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [self.tblOrderInfo registerNib:[UINib nibWithNibName:@"HDrugHeaderTableCell" bundle:nil] forCellReuseIdentifier:@"HDrugHeaderTableCell"];//店铺信息
    [self.tblOrderInfo registerNib:[UINib nibWithNibName:@"HDrugTableCell" bundle:nil] forCellReuseIdentifier:@"HDrugTableCell"];//药品信息
    [self.tblOrderInfo registerNib:[UINib nibWithNibName:@"HDrugOrderFooterNoControlTableCell" bundle:nil] forCellReuseIdentifier:@"HDrugOrderFooterNoControlTableCell"];//总价格
    [self.tblOrderInfo registerNib:[UINib nibWithNibName:@"HDrugOrderPayInfoTableCell" bundle:nil] forCellReuseIdentifier:@"HDrugOrderPayInfoTableCell"];//支付信息
    [_vBottomControl setHidden:true];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    if (firstLoad) {
        firstLoad = false;
        [self loadOrderDetailInfoShowHUD:true];
    }
}

- (void)loadOrderDetailInfoShowHUD:(BOOL)bShow{
    if (bShow) {
        [ZXHUD MBShowLoadingInView:self.view text:ZX_LOADING_TEXT delay:0];
    }
    [ZXOrderListViewModel getOrderDetailInfoById:_orderId memberId:[[ZXGlobalData shareInstance] memberId] token:[[ZXGlobalData shareInstance] userToken] completion:^(ZXOrderListModel *orderDetail, NSInteger status, BOOL success, NSString *errorMsg) {
        if (bShow) {
            [ZXHUD MBHideForView:self.view animate:true];
        }
        if (orderDetail) {
            orderDetailInfo = orderDetail;
            [self reloadUI];
        }else{
            if (status != ZXAPI_LOGIN_INVALID) {
                [ZXAlertUtils showAAlertMessage:@"此时无法获取订单详情" title:@"提示" buttonText:@"确定" buttonAction:^{
                    [self.navigationController popViewControllerAnimated:true];
                }];
            }else{
                [self.navigationController popViewControllerAnimated:true];
            }
        }
    }];
}

- (void)reloadUI{
    //联系电话
    if ([orderDetailInfo.drugstoreTel isKindOfClass:[NSString class]] &&
        orderDetailInfo.drugstoreTel.length) {
        [self zx_addRightBarItemsWithImageNames:@[@"hOrder_callphone"] originalColor:true];
    }
    [_vBottomControl setHidden:false];
    //顶部订单状态
    if (orderDetailInfo.status == HDrugOrderTypeWaitPay ||
        orderDetailInfo.status == HDrugOrderTypeCancel ||
        orderDetailInfo.status == HDrugOrderTypeRefund) {//待付款 已取消 退款中 状态
        _status2 = [[HDrugOrderStatus2 alloc] initWithFrame:CGRectMake(0, 0, ZX_BOUNDS_WIDTH, 72)];
        [_status2 loadOrderStatusByOrderInfo:orderDetailInfo];
        [self.tblOrderInfo setTableHeaderView:_status2];
    }else{//其他进度状态
        HDrugOrderStatus * status = [[HDrugOrderStatus alloc] initWithFrame:CGRectMake(0, 0, ZX_BOUNDS_WIDTH, 144)];
        [status loadDataByOrderInfo:orderDetailInfo];
        [self.tblOrderInfo setTableHeaderView:status];
    }
    //底部操作按钮
    [self loadOrderControlType:orderDetailInfo.status];

    if (orderDetailInfo.status == HDrugOrderTypeWaitPay) {
        [_status2.lbSubInfoText setText:orderDetailInfo.expiredDateStr];
    }
    if (orderDetailInfo.receiveType == HDispatchWaySelfTake) {
        arrOrderInfoTitles = @[@"收货人",@"联系电话",@"自提地址",@"订单号",@"支付方式",@"配送方式",@"下单时间"];
    }
    [_lbTotalPrice setText:[NSString stringWithFormat:@"合计:¥%@元",orderDetailInfo.originalPriceStr]];
    [_tblOrderInfo reloadData];
}

//打电话
- (void)zx_rightBarButtonActionsIndex:(NSInteger)index{
    if (orderDetailInfo) {
        if ([orderDetailInfo.drugstoreTel isKindOfClass:[NSString class]] && orderDetailInfo.drugstoreTel.length){
            [ZXCommonUtils openCallWithTelNum:orderDetailInfo.drugstoreTel failBlock:^{
                [ZXAlertUtils showAAlertMessage:@"该设备不支持拨打电话功能" title:@"提示" buttonText:@"知道了" buttonAction:nil];
            }];
        }else{
            [ZXHUD MBShowFailureInView:self.view text:@"无相关联系方式" delay:1.5];
        }
    }
}

#pragma mark - TableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {//药品信息
        if (orderDetailInfo) {
            return orderDetailInfo.orderDetailList.count + 2;
        }
    }else{//订单支付、下单日期、配送信息
        if (orderDetailInfo) {//加载之后再显示
            return 7;
        }
        
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {//药品信息
        if (indexPath.row == 0) {//抬头 店铺信息
            HDrugHeaderTableCell * header = [tableView dequeueReusableCellWithIdentifier:@"HDrugHeaderTableCell" forIndexPath:indexPath];
            [header reloadStoreInfo:orderDetailInfo];
            return header;
        }else if (indexPath.row == orderDetailInfo.orderDetailList.count + 1){//订单总价格
            HDrugOrderFooterNoControlTableCell * footer = [tableView dequeueReusableCellWithIdentifier:@"HDrugOrderFooterNoControlTableCell" forIndexPath:indexPath];
            [footer reloadOrderInfo:orderDetailInfo];
            return footer;
        }else{//商品信息
            HDrugTableCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HDrugTableCell" forIndexPath:indexPath];
            NSInteger index = indexPath.row - 1;//第一行为店铺
            [cell reloadGoodsInfo:[orderDetailInfo.orderDetailList objectAtIndex:index]];
            return cell;
        }
    }else if (indexPath.section == 1){//支付信息
        HDrugOrderPayInfoTableCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HDrugOrderPayInfoTableCell" forIndexPath:indexPath];
        cell.lbTitle.text = [arrOrderInfoTitles objectAtIndex:indexPath.row];
        switch (indexPath.row) {
            case 0://收货人
            {
                cell.lbInfo.text = orderDetailInfo.consignee;
            }
                break;
            case 1://联系电话
            {
                cell.lbInfo.text = orderDetailInfo.tel;
            }
                break;
            case 2://收货地址
            {
                if (orderDetailInfo.receiveType == HDispatchWaySelfTake) {
                    cell.lbInfo.text = orderDetailInfo.drugstoreAddress;//自提地址
                }else{
                    cell.lbInfo.text = orderDetailInfo.address;//送货地址
                }
            }
                break;
            case 3://订单编号
            {
                cell.lbInfo.text = orderDetailInfo.orderNo;
            }
                break;
            case 4://支付方式
            {
                cell.lbInfo.text = orderDetailInfo.paymentMethodStr;
            }
                break;
            case 5://配送方式
            {
                if (orderDetailInfo.receiveType == HDispatchWaySelfTake) {
                    cell.lbInfo.text = @"到店自提";
                }else{
                    cell.lbInfo.text = @"送药上门";
                }
                
            }
                break;
            case 6://下单时间
            {
                cell.lbInfo.text = orderDetailInfo.orderDateStr;
            }
                break;
                
            default:
                break;
        }
        return cell;
    }
    
    return nil;
}

#pragma mark - TableViewDelegagte

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {//店铺
            return 67;
        }else if (indexPath.row == orderDetailInfo.orderDetailList.count + 1){//总价
            return 55;
        }
        return 70;//药品
    }else if(indexPath.section == 1){
        if (indexPath.row == 2) {//收货地址
            return 40;
        }
    }
    return 30;//支付信息
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 0.1;
    }
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {//跳转到店铺主页
        if (![[[ZXGlobalData shareInstance] userTelephone] isEqualToString:ZXAPP_Common_TestAccount]) {
            ZXStoreRootViewController * webStore = [ZXStoreRootViewController configVCWith:orderDetailInfo.drugstoreId memberId:[[ZXGlobalData shareInstance] memberId] token:[[ZXGlobalData shareInstance] userToken]];

            [self.navigationController pushViewController:webStore animated:true];
        }
    }else{//跳转到商品
        
    }
}

#pragma mark - 订单操作
- (void)controlButton1Action{
    switch (orderDetailInfo.status) {
        case HDrugOrderTypeWaitPay://待付款 (Control1:立即付款)
        {
            NSLog(@"立即付款");
        }
            break;
        case HDrugOrderTypeWaitTake://待提货 (Control1:查看提货码)
        case HDrugOrderTypeWaitDispatch://待发货 (Control1:查看提货码)
        case HDrugOrderTypeDispatched://待收货 (Control1: 查看提货码)
        {
            NSLog(@"查看提货码");
            HCheckCodeViewController * checkCodeVC = [[HCheckCodeViewController alloc] init];
            checkCodeVC.orderId = _orderId;
            [self.navigationController pushViewController:checkCodeVC animated:true];
        }
            break;
//        case HDrugOrderTypeWaitDispatch://待发货 (Control1:取消订单)
//        {
//            NSLog(@"取消订单");
//            [self changeOrderStatusByType:HDrugOrderTypeCancel];
//        }
//            break;
        case HDrugOrderTypePrepare://待备货 (Control1:取消订单)
        {
            NSLog(@"取消订单");
            [self changeOrderStatusByType:HDrugOrderTypeCancel];
        }
            break;
//        case HDrugOrderTypeDispatched://待收货 (Control: 确认收货)
//        {
//            NSLog(@"确认收货");
//            [self changeOrderStatusByType:HDrugOrderTypeDone];
//        }
//            break;
        case HDrugOrderTypeDone://已完成 (Control1: 删除订单)
        {
            NSLog(@"删除订单");
            [self changeOrderStatusByType:HDrugOrderTypeInvalid];
        }
            break;
        case HDrugOrderTypeCancel://已取消 (Control1: 删除订单)
        {
            NSLog(@"删除订单");
            [self changeOrderStatusByType:HDrugOrderTypeInvalid];
        }
            break;
        case HDrugOrderTypeRefund://退款中 (Control1: 无操作)
        {
            NSLog(@"无操作");
        }
            break;
        default:
            break;
    }
}

- (void)controlButton2Action{
    switch (orderDetailInfo.status) {
        case HDrugOrderTypeWaitPay:     //待付款 (Control2:取消订单)
        case HDrugOrderTypeWaitTake:    //待提货 (Control2:取消订单)
        case HDrugOrderTypeWaitDispatch://待发货 (Control2:取消订单)
        {
            NSLog(@"取消订单");
            [self changeOrderStatusByType:HDrugOrderTypeCancel];
        }
            break;
//        case HDrugOrderTypeDispatched://待收货 (Control2: 无操作)
        case HDrugOrderTypeDispatched://待收货 (Control2: 确认收货)
        {
            [self changeOrderStatusByType:HDrugOrderTypeDone];
        }
            break;
        case HDrugOrderTypeDone:    //已完成 (Control2: 无操作)
        case HDrugOrderTypeCancel:  //已取消 (Control2: 无操作)
        case HDrugOrderTypeRefund:  //已取消 (Control2: 无操作)
        case HDrugOrderTypePrepare: //待备货 (Control2: 无操作)
        {
            NSLog(@"无操作");
        }
            break;
        default:
            break;
    }
}

#pragma mark - 订单可操作类型
- (void)loadOrderControlType:(HDrugOrderType)type{
    orderDetailInfo.status = type;
    [_btnControl1 setHidden:false];
    [_btnControl2 setHidden:false];
    _control1Width.constant = 80;
    _lbTotalPriceRightOffset.constant = 94;
    
    [_btnControl1 setBackgroundColor:[UIColor zx_tintColor]];
    [_btnControl1.layer setBorderColor:[UIColor zx_tintColor].CGColor];
    [_btnControl1 setTitleColor:ZXWHITE_COLOR forState:UIControlStateNormal];
    
    [_btnControl2 setBackgroundColor:ZXWHITE_COLOR];
    [_btnControl2.layer setBorderColor:[UIColor zx_tintColor].CGColor];
    [_btnControl2 setTitleColor:[UIColor zx_tintColor] forState:UIControlStateNormal];
    
    switch (orderDetailInfo.status) {
        case HDrugOrderTypeWaitPay://待付款 (Control: 取消订单、立即付款)
        {
            [_btnControl1 setTitle:@"立即付款" forState:UIControlStateNormal];
            [_btnControl2 setTitle:@"取消订单" forState:UIControlStateNormal];
        }
            break;
        case HDrugOrderTypeWaitTake://待提货 (Control: 取消订单、查看提货码)
        case HDrugOrderTypeWaitDispatch://待发货 (Control: 取消订单、查看提货码)
        {
            _control1Width.constant = 94;
            [_btnControl1 setTitle:@"查看提货码" forState:UIControlStateNormal];
            [_btnControl1 setBackgroundColor:ZXRGB_COLOR(53, 167, 144)];
            [_btnControl1.layer setBorderColor:ZXRGB_COLOR(53, 167, 144).CGColor];
            [_btnControl1 setTitleColor:ZXWHITE_COLOR forState:UIControlStateNormal];
            
            [_btnControl2 setTitle:@"取消订单" forState:UIControlStateNormal];
        }
            break;
//        case HDrugOrderTypeWaitDispatch://待发货 (Control: 取消订单)
//        {
//            [_btnControl1 setTitle:@"取消订单" forState:UIControlStateNormal];
//            [_btnControl1 setBackgroundColor:ZXWHITE_COLOR];
//            [_btnControl1.layer setBorderColor:[UIColor zx_tintColor].CGColor];
//            [_btnControl1 setTitleColor:[UIColor zx_tintColor] forState:UIControlStateNormal];
//            
//            [_btnControl2 setHidden:true];
//            _lbTotalPriceRightOffset.constant = 14;
//            
//        }
//            break;
        case HDrugOrderTypePrepare://备货中 (Control: 取消订单)
        {
            [_btnControl1 setTitle:@"取消订单" forState:UIControlStateNormal];
            [_btnControl1 setBackgroundColor:ZXWHITE_COLOR];
            [_btnControl1.layer setBorderColor:[UIColor zx_tintColor].CGColor];
            [_btnControl1 setTitleColor:[UIColor zx_tintColor] forState:UIControlStateNormal];
            
            [_btnControl2 setHidden:true];
            _lbTotalPriceRightOffset.constant = 14;
            
        }
            break;
//        case HDrugOrderTypeDispatched://待收货 (Control: 确认收货)
//        {
//            [_btnControl1 setTitle:@"确认收货" forState:UIControlStateNormal];
//            [_btnControl2 setHidden:true];
//            _lbTotalPriceRightOffset.constant = 14;
//        }
//            break;
        case HDrugOrderTypeDispatched://待收货 (Control: 确认收货、查看提货码)
        {
            _control1Width.constant = 94;
            [_btnControl1 setTitle:@"查看提货码" forState:UIControlStateNormal];
            [_btnControl1 setBackgroundColor:ZXRGB_COLOR(53, 167, 144)];
            [_btnControl1.layer setBorderColor:ZXRGB_COLOR(53, 167, 144).CGColor];
            [_btnControl1 setTitleColor:ZXWHITE_COLOR forState:UIControlStateNormal];
            
            [_btnControl2 setTitle:@"确认收货" forState:UIControlStateNormal];
        }
            break;
        case HDrugOrderTypeDone://已完成 (Control: 删除订单)
        {
            [_btnControl1 setTitle:@"删除订单" forState:UIControlStateNormal];
            [_btnControl1 setBackgroundColor:ZXWHITE_COLOR];
            [_btnControl1.layer setBorderColor:[UIColor zx_tintColor].CGColor];
            [_btnControl1 setTitleColor:[UIColor zx_tintColor] forState:UIControlStateNormal];
            
            [_btnControl2 setHidden:true];
            _lbTotalPriceRightOffset.constant = 14;
        }
            break;
        case HDrugOrderTypeCancel://已取消 (Control: 删除订单)
        {
            [_btnControl1 setTitle:@"删除订单" forState:UIControlStateNormal];
            [_btnControl1 setBackgroundColor:ZXWHITE_COLOR];
            [_btnControl1.layer setBorderColor:[UIColor zx_tintColor].CGColor];
            [_btnControl1 setTitleColor:[UIColor zx_tintColor] forState:UIControlStateNormal];
            
            [_btnControl2 setHidden:true];
            _lbTotalPriceRightOffset.constant = 14;
        }
            break;
        case HDrugOrderTypeRefund://退款中 (Control: 无操作)
        {
//            [_btnControl1 setTitle:@"删除订单" forState:UIControlStateNormal];
//            [_btnControl1 setBackgroundColor:ZXWHITE_COLOR];
//            [_btnControl1.layer setBorderColor:[UIColor zx_tintColor].CGColor];
//            [_btnControl1 setTitleColor:[UIColor zx_tintColor] forState:UIControlStateNormal];
            [_btnControl1 setHidden:true];
            [_btnControl2 setHidden:true];
            _lbTotalPriceRightOffset.constant = 14;
        }
            break;
        default:
        {
            [_btnControl1 setHidden:true];
            [_btnControl2 setHidden:true];
        }
            break;
    }
}


#pragma mark - 订单操作
- (void)changeOrderStatusByType:(HDrugOrderType)type{
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
    if (type == HDrugOrderTypeInvalid ||
        type == HDrugOrderTypeCancel ||
        type == HDrugOrderTypeDone) {
        [ZXAlertUtils showAAlertMessage:controlTile title:@"提示" buttonTexts:arrButtonTitle buttonAction:^(int buttonIndex) {
            if (buttonIndex == 1) {
                [ZXHUD MBShowLoadingInView:self.view text:@"操作中..." delay:0];
                [ZXOrderListViewModel changeOrderStatusByID:_orderId status:type memberId:[[ZXGlobalData shareInstance] memberId] token:[[ZXGlobalData shareInstance] userToken] completion:^(BOOL success, NSInteger status, BOOL apiSuccess, NSString *errorMsg) {
                    [ZXHUD MBHideForView:self.view animate:true];
                    if (success) {
                        [ZXNotificationCenter postNotificationName:@"ZX_UPDATE_ORDERLIST_NOTICE" object:nil];
                        [self.navigationController popViewControllerAnimated:true];
                    }else{
                        [ZXHUD MBShowFailureInView:self.view text:errorMsg delay:1.5];
                    }
                }];
            }
        }];
    }
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
