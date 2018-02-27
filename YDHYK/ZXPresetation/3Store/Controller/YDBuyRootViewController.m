//
//  YDBuyRootViewController.m
//  ydhyk
//
//  Created by 120v on 2016/10/21.
//  Copyright © 2016年 120v. All rights reserved.
//

#import "YDBuyRootViewController.h"
/** 有卡的Cell*/
#import "BuyRootTableViewCell.h"
/** 加入会员视图*/
#import "HJoinLeadViewController.h"
/** 临时代码：药详情弹窗*/
#import "YDMedicineDetailView.h"
/** 没有会员卡*/
#import "YDNoMemeberCardView.h"
/** 只有一张卡时显示*/
#import "YDOneCardView.h"
/** 查询会员卡模型*/
#import "YDQueryMemberCardModel.h"
/** 二维码*/
#import "HQRScanViewController.h"
/** 地图页*/
#import "YDNearbyRootViewController.h"
#import "YDHYK-Swift.h"


/** 有卡的Cell*/
static NSString * const buyRootcell = @"buyRootcell";

@interface YDBuyRootViewController ()<UITableViewDelegate, UITableViewDataSource,BuyRootTableViewCellDelegate,YDNoMemeberCardViewDelegate>
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSMutableArray *dataArray;
/** 一张卡的情况*/
@property(nonatomic,strong) YDOneCardView *oneCardView;
/** 一没有卡的情况*/
@property(nonatomic,strong) YDNoMemeberCardView *noMemeberCardView;

@property (nonatomic,assign) BOOL firstQueryCard;
@property (nonatomic,assign) BOOL isFetchingCard;

@end

@implementation YDBuyRootViewController

- (instancetype)init{
    if (self = [super init]) {
        [self setHidesBottomBarWhenPushed:false];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"卡·购药";
    self.view.backgroundColor = [UIColor zx_assistColor];
    self.firstQueryCard = true;
    self.isFetchingCard = false;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self zx_setNavBarBackgroundColor:[UIColor zx_navbarColor]];
    
    if (self.firstQueryCard) {
        [self httpRequestForQueryMemberCard:true];
    }else{
        [self httpRequestForQueryMemberCard:false];
    }
}

#pragma mark - HTTP
#pragma mark 会员卡删除
-(void)httpRequestForDeleteMemberCardWithTableView:(UITableView *)tableView withIndexPath:(NSIndexPath *)indexPath withModel:(YDQueryMemberCardModel *)model{
    
    
    NSMutableDictionary * dicParas =[NSMutableDictionary dictionary];
    NSString *memberID = [[YDAPPManager shareManager] getMemberId];
    NSString *token = [[YDAPPManager shareManager] getUserToken];
    if (memberID) {
        [dicParas setObject:memberID forKey:@"memberId"];
    }
    
    if (model.uid) {
        [dicParas setObject:model.uid forKey:@"id"];
    }

    [ZXHUD MBShowLoadingInView:self.view text:ZXStatus_Loading delay:0.0];
    [ZXNetworkEngine asycnRequestWithURL:ZXAPI_Address(ZXAPI_Remove_MyCard) params:dicParas token:token method:POST zxCompletion:^(id content, NSInteger status, BOOL success, NSString *errorMsg) {
        [ZXHUD MBHideForView:self.view animate:YES];
        if (success) {
            if (status == ZXAPI_SUCCESS) {//
                
                //删除
                [self.dataArray removeObjectAtIndex:indexPath.row];
                
                [tableView beginUpdates];
                if (self.dataArray.count <= 0) {
                    [tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationLeft];
                }
                [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                [tableView endUpdates];
                
                [ZXHUD MBShowSuccessInView:self.view text:content[@"msg"] delay:0.5];
                
                if (self.dataArray.count <= 0) {
                    [self switchLoadView];
                }
                
            }else{
                [ZXHUD MBShowFailureInView:self.view text:content[@"msg"] delay:0.5];
            }
        }else{
            [ZXHUD MBShowFailureInView:self.view text:errorMsg delay:0.5];
        }
    }];

}

#pragma mark 会员卡查询
-(void)httpRequestForQueryMemberCard:(BOOL)showHUD{
    
    if (self.isFetchingCard) {
        return;
    }
    self.isFetchingCard = true;
    [self.dataArray removeAllObjects];
    
    NSMutableDictionary * dicParas =[NSMutableDictionary dictionary];
    NSString *memberID = [[YDAPPManager shareManager] getMemberId];
    NSString *token = [[YDAPPManager shareManager] getUserToken];
    if (memberID) {
        [dicParas setObject:memberID forKey:@"memberId"];
    }
    __weak typeof(self) weakSelf = self;
    if (showHUD) {
        [ZXHUD MBShowLoadingInView:self.view text:ZX_LOADING_TEXT delay:0];
    }else{
        [ZXCommonUtils showNetworkActivity:true];
    }
    [ZXNetworkEngine asycnRequestWithURL:ZXAPI_Address(ZXAPI_Query_Member_Card) params:dicParas token:token method:POST zxCompletion:^(id content, NSInteger status, BOOL success, NSString *errorMsg) {
        _firstQueryCard = false;
        self.isFetchingCard = false;
        [ZXCommonUtils showNetworkActivity:false];
        [ZXHUD MBHideForView:self.view animate:true];
        [ZXEmptyView dismissInView:weakSelf.view];
        if (success) {
            if (status == ZXAPI_SUCCESS) {//
                id obj = content[@"data"];
                if ([obj isKindOfClass:[NSArray class]]) {
                    [weakSelf.dataArray addObjectsFromArray:[YDQueryMemberCardModel mj_objectArrayWithKeyValuesArray:obj]];
                     //判断显示那个视图
                    [self switchLoadView];
                }else{
                    [ZXEmptyView showNoDataInView:weakSelf.view text1:@"没有数据" text2:nil heightFix:0];
                }
            }else{
                [ZXEmptyView showNoDataInView:weakSelf.view text1:@"没有数据" text2:nil heightFix:0];
            }
        }else{
            [ZXEmptyView showNetworkErrorInView:weakSelf.view heightFix:0 refreshAction:^{
                [ZXEmptyView dismissInView:weakSelf.view];
                [self httpRequestForQueryMemberCard:true];
            }];
        }
    }];
}

#pragma mark -  判断显示那个视图
-(void)switchLoadView{
    
     if (self.dataArray.count == 0 || self.dataArray == nil) {//没有会员卡
        _tableView.delegate = nil;
        _tableView.dataSource = nil;
        [_tableView setHidden:YES];
        _tableView = nil;
        _noMemeberCardView = nil;
        
        [self.view addSubview:self.noMemeberCardView];
        self.noMemeberCardView.delegate = self;
    }else if (self.dataArray.count == 1){//只有一张会员卡
        _noMemeberCardView.delegate = nil;
        [_noMemeberCardView setHidden:YES];
        _noMemeberCardView = nil;
        
        [self.view addSubview:self.tableView];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
        //如果只有一张卡时
        BOOL firstClick = [[NSUserDefaults standardUserDefaults] objectForKey:@"oneCardIsClick"];
        if (firstClick == FALSE) {
            self.oneCardView.frame = [UIScreen mainScreen].bounds;
            [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:self.oneCardView];
            self.oneCardView.dataArray = self.dataArray;
        }

        [self.tableView reloadData];
        
    }else if(self.dataArray.count > 1){//大于一张
        _noMemeberCardView.delegate = nil;
        [_noMemeberCardView setHidden:YES];
        _noMemeberCardView = nil;
        
        [self.view addSubview:self.tableView];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
        [self.tableView reloadData];
    }else{
        __weak typeof(self) weakSelf = self;
        [ZXEmptyView showNetworkErrorInView:self.view heightFix:0 refreshAction:^{
            [ZXEmptyView dismissInView:weakSelf.view];
            [weakSelf httpRequestForQueryMemberCard:true];
        }];
    }
}

#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.dataArray.count == 0) {
        return 0;
    }
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 138 + 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BuyRootTableViewCell *rootCell = [tableView dequeueReusableCellWithIdentifier:buyRootcell forIndexPath:indexPath];
    rootCell.selectionStyle = UITableViewCellSelectionStyleNone;
    rootCell.cellIndex = indexPath.row;
    rootCell.delegate = self;
    if (self.dataArray.count) {
        rootCell.model = [self.dataArray objectAtIndex:indexPath.row];
    }
    return rootCell;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        YDQueryMemberCardModel *model = [self.dataArray objectAtIndex:indexPath.row];
        [self httpRequestForDeleteMemberCardWithTableView:tableView withIndexPath:indexPath withModel:model];
    }
}

#pragma mark - BuyRootTableViewCellDelegate
#pragma mark 打电话
-(void)didSelectedBuyRootCellWithTelButtonClick:(UIButton *)sender withModel:(YDQueryMemberCardModel *)model{
    if ([model.drugstoreTel isKindOfClass:[NSString class]] && model.drugstoreTel.length){
        [ZXCommonUtils openCallWithTelNum:model.drugstoreTel failBlock:^{
            [ZXAlertUtils showAAlertMessage:@"该设备不支持拨打电话功能" title:@"提示" buttonText:@"知道了" buttonAction:nil];
        }];
    }else{
        [ZXHUD MBShowFailureInView:self.view text:@"无相关联系方式" delay:1.5];
    }
}

#pragma mark 购药
-(void)didSelectedBuyRootCellWithBuyButtonClick:(UIButton *)sender withModel:(YDQueryMemberCardModel *)model{
    if (![[[ZXGlobalData shareInstance] userTelephone] isEqualToString:ZXAPP_Common_TestAccount]) {
        ZXStoreRootViewController * webStore = [ZXStoreRootViewController configVCWith:model.drugstoreId memberId:[[ZXGlobalData shareInstance] memberId] token:[[ZXGlobalData shareInstance] userToken]];
        [self.navigationController pushViewController:webStore animated:true];
    }
}

#pragma mark - YDNoMemeberCardViewDelegate
#pragma mark 加入会员
-(void)didNoMemeberCardViewMemberButton:(UIButton *)sender withModel:(YDClosesListModel *)model{
    if (model.isMember.integerValue == 1) {//商城
        if (![[[ZXGlobalData shareInstance] userTelephone] isEqualToString:ZXAPP_Common_TestAccount]) {
            ZXStoreRootViewController * webStore = [ZXStoreRootViewController configVCWith:model.uid memberId:[[ZXGlobalData shareInstance] memberId] token:[[ZXGlobalData shareInstance] userToken]];

            [self.navigationController pushViewController:webStore animated:true];
        }
    }else if (model.isMember.integerValue == 0){//加入会员
        [HJoinLeadViewController checkShowWithCompletion:^{
            HQRScanViewController * qrVC = [[HQRScanViewController alloc] init];
            [self.navigationController pushViewController:qrVC animated:true];
        }];
    }
}

#pragma mark 电话
-(void)didNoMemeberCardViewTelephoneButton:(UIButton *)sender withModel:(YDClosesListModel *)model{
    if (model.tel.length) {
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",model.tel];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str] options:@{UIApplicationOpenURLOptionUniversalLinksOnly:@""} completionHandler:^(BOOL success) {
        }];
    }else{
        [ZXHUD MBShowFailureInView:self.view text:@"获取电话失败" delay:1.2];
        return;
    }
}

#pragma mark 定位
-(void)didNoMemeberCardViewLocationButton:(UIButton *)sender withModel:(YDClosesListModel *)model{
    if (model.latitude && model.longitude && model.latitude.floatValue && model.longitude.floatValue) {
        YDNearbyRootViewController *mapVC = [[YDNearbyRootViewController alloc]init];
        mapVC.isLocationButtonClick = YES;
        NSMutableArray *mArray = [[NSMutableArray alloc]init];
        [mArray addObject:model];
        mapVC.modelArray_store = mArray;
        
        [self presentViewController:[[UINavigationController alloc] initWithRootViewController:mapVC] animated:YES completion:nil];
    }else{
        [ZXHUD MBShowFailureInView:self.view text:@"定位失败" delay:1.2];
        return;
    }
}

#pragma mark lazy
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -30, ZX_BOUNDS_WIDTH, ZX_BOUNDS_HEIGHT- 64) style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor zx_assistColor];
        [_tableView setShowsVerticalScrollIndicator:NO];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([BuyRootTableViewCell class]) bundle:nil] forCellReuseIdentifier:buyRootcell];
    }
    return _tableView;
}

-(YDOneCardView *)oneCardView{
    if (!_oneCardView) {
        _oneCardView = [[YDOneCardView alloc]init];
    }
    return _oneCardView;
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

-(YDNoMemeberCardView *)noMemeberCardView{
    if (!_noMemeberCardView) {
        _noMemeberCardView = [[YDNoMemeberCardView alloc]initWithFrame:CGRectMake(0, 0, ZX_BOUNDS_WIDTH, ZX_BOUNDS_HEIGHT - 64)];
        _noMemeberCardView.backgroundColor = [UIColor zx_assistColor];
    }
    return _noMemeberCardView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
