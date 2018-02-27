//
//  YDDrugRemindViewController.m
//  ydhyk
//
//  Created by screson on 2016/10/28.
//  Copyright © 2016年 120v. All rights reserved.
//

#import "YDDrugRemindViewController.h"
#import "YDDrugRemindAddViewController.h"

/** 通知授权*/
#import "AppDelegate+Notice.h"

#import "YDRemindInfoCell.h"
/** 药品详情*/
#import "YDMedicineDetailView.h"
/** 用药提醒弹窗*/
#import "YDDrugRemindView.h"
/** 已添加提醒数据模型*/
#import "YDDrugRemindModel.h"
/** 通知是否开启*/
#import "YDNotificationStatusView.h"


#define NoDataDefaultCellNum 5

@interface YDDrugRemindViewController ()<UITableViewDataSource,UITableViewDelegate,YDNotificationStatusViewDelegate,YDRemindInfoCellDelegate>
/** 顶部需要服药视图*/
@property (nonatomic,strong) YDDrugRemindView *bannerView;
/** 顶部通知视图*/
@property (nonatomic,strong) UIView *headerView;
/** tableView*/
@property (nonatomic,strong) UITableView *remindTableView;
/** 已添加提醒数据*/
@property (nonatomic,strong) NSMutableArray *drugRemindArray;
/** 通知是否开启*/
@property (nonatomic,strong) YDNotificationStatusView *notificationView;

/** 通知是否开启*/
@property (nonatomic,assign) BOOL isAuthor;

/** 无数据时的处理*/
@property (nonatomic,assign) BOOL isNoData;

@end

@implementation YDDrugRemindViewController

-(void)viewWillLayoutSubviews{
    self.headerView.width = ZX_BOUNDS_WIDTH;
    self.remindTableView.width = ZX_BOUNDS_WIDTH;
    self.bannerView.width = self.headerView.width;
}

- (instancetype)initWithCoder:(NSCoder *)coder{
    self = [super initWithCoder:coder];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

+(instancetype)instantiateFromStoryboard{
    return [[UIStoryboard storyboardWithName:@"DrugRemind" bundle:nil] instantiateViewControllerWithIdentifier:@"YDDrugRemindViewController"];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [ZXEmptyView dismissInView:self.view];
    
    //已添加提醒数据请求
    [self httpRequestForDrugRemindList];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"用药提醒";
    self.view.backgroundColor = [UIColor zx_assistColor];
    
    self.isAuthor = FALSE;
    
    self.isNoData = FALSE;
   
    //导航栏视图
    [self setupNavigationView];
    
    //首次判断通知是否开启
    [self firstConfirmNotAuthor];
    
    //顶部通知视图
    [self setupTopNotView];
    
    //顶部需要服药视图
    [self.view addSubview:self.bannerView];
    
    //添加tableView
    [self.view addSubview:self.remindTableView];
   
    //监听是否开启通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(confirmNotificationIsAuthor:) name:ZXNOTICE_NOTIFICATION_ISOPEN object:nil];
    
    //监听修改用药时间
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(monitorModifyTime) name:ZXNOTICE_NOTIFICATION_ModifyTime object:nil];
}

#pragma mark - 顶部通知视图
-(void)setupTopNotView{
    __block CGFloat headerH = 0.0;
    //
    self.headerView.x = 0;
    self.headerView.width = ZX_BOUNDS_WIDTH;
    self.headerView.y = CGRectGetMaxY(self.bannerView.frame);
    self.headerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.headerView];
    
    //
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ZX_BOUNDS_WIDTH, 45)];
    titleView.backgroundColor = [UIColor whiteColor];
    [self.headerView addSubview:titleView];
    
    //
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(15, 13, 19, 19)];
    image.image = [UIImage imageNamed:@"yytx"];
    [titleView addSubview:image];
    
    //
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(40, 0, 100, 44)];
    title.text = @"已添加提醒";
    title.textColor = [UIColor zx_tintColor];
    [titleView addSubview:title];
    
    //
    UIView *sLine = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(title.frame), ZX_BOUNDS_WIDTH, 1)];
    sLine.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [titleView addSubview:sLine];
    
    //
    self.notificationView.height = 72.0;
    self.notificationView.width = ZX_BOUNDS_WIDTH;
    self.notificationView.y = CGRectGetMaxY(titleView.frame);
    self.notificationView.x = 0;
    [self.headerView addSubview:self.notificationView];
    
    if(self.isAuthor){
        headerH = 45;
        self.notificationView.alpha = 1.0;
        [UIView animateWithDuration:0.0 animations:^{
            self.notificationView.alpha = 0.0;
        }];
    }else{
        headerH = 45 + 72;
        
        self.notificationView.alpha = 0.0;
        [UIView animateWithDuration:0.0 animations:^{
            self.notificationView.alpha = 1.0;
        }];
    }
    self.headerView.height = headerH;
    
    //更新tableView高度
    self.remindTableView.y = CGRectGetMaxY(self.headerView.frame);
    self.remindTableView.frame = CGRectMake(0, CGRectGetMaxY(self.headerView.frame), ZX_BOUNDS_WIDTH, ZX_BOUNDS_HEIGHT - self.bannerView.height - self.headerView.height - 64);
}

#pragma mark - 判断通知是否授权
-(void)firstConfirmNotAuthor{
    
    AppDelegate *appDelegate =(AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if ([appDelegate.isOpenNotice isEqualToString:@"TRUE"]) {
        self.isAuthor = TRUE;
    }else if([appDelegate.isOpenNotice isEqualToString:@"FALSE"]){
        self.isAuthor = FALSE;
    }
   
    
//    [AppDelegate isAllowedNotification:^(BOOL isAuthor) {
//        self.isAuthor = isAuthor;
//    }];
}

-(void)confirmNotificationIsAuthor:(NSNotification *)infor{
    if ([infor.object isEqualToString:@"TRUE"]) {
        self.isAuthor = TRUE;
    }else if([infor.object isEqualToString:@"FALSE"]){
        self.isAuthor = FALSE;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        AppDelegate *appDelegate =(AppDelegate *)[[UIApplication sharedApplication] delegate];
        if(appDelegate.isConnected){
            //更新frame
            [self setupTopNotView];
        }
    });
}

#pragma mark - 监听修改用药时间
-(void)monitorModifyTime{
    [self httpRequestForDrugRemindList];
}

#pragma mark - 导航栏视图
-(void)setupNavigationView{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addRemind)];
}

#pragma mark 添加提醒
-(void)addRemind{
    YDDrugRemindAddViewController *add =[YDDrugRemindAddViewController instantiateFromStoryboard];
    add.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:add animated:YES];
    
   
}

#pragma mark - UITabelViewDataSourceDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.isNoData == TRUE && self.drugRemindArray.count == NoDataDefaultCellNum) {
        return NoDataDefaultCellNum;
    }
    
    return self.drugRemindArray.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.isNoData == TRUE && self.drugRemindArray.count == NoDataDefaultCellNum) {
        return 1;
    }else if(self.isNoData == TRUE && self.drugRemindArray.count == 0){
        return 0;
    }
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YDRemindInfoCell *cell=[tableView dequeueReusableCellWithIdentifier:[YDRemindInfoCell reuseID] forIndexPath:indexPath];
    if (self.drugRemindArray.count && self.isNoData == FALSE) {
        cell.model = [self.drugRemindArray objectAtIndex:indexPath.row];
        [cell.remindSwitch setHidden:NO];
        cell.delegate = self;
    }else if(self.drugRemindArray.count == NoDataDefaultCellNum && self.isNoData == TRUE){
        cell.titleLabel.text = @"";
        cell.descLabel.text = @"";
        [cell.remindSwitch setHidden:YES];
    }
    
    return cell;
}

#pragma mark - UITabeleViewDelegate
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
       YDDrugRemindModel *model = [self.drugRemindArray objectAtIndex:indexPath.row];
        [self httpRequestForDeleteDrugRemindWithTableView:tableView withIndexPath:indexPath withModel:model];
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

#pragma mark - YDNotificationStatusViewDelegate
#pragma mark 开启通知
-(void)didNotificationStatusViewDelegate:(UIButton *)sender{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{UIApplicationOpenURLOptionUniversalLinksOnly:@""} completionHandler:^(BOOL success) {
    }];
}

#pragma mark - YDRemindInfoCellDelegate
#pragma mark 用药提醒药品开启/关闭提醒
-(void)didYDRemindInfoCell:(UISwitch *)sender withModel:(YDDrugRemindModel *)model{
    [self httpRequestForDrugRemindTurnOnWith:sender.isOn andWithID:model.uid];
}

#pragma mark - HTTPRequest
#pragma mark 已添加提醒
-(void)httpRequestForDrugRemindList{
    
//    [ZXEmptyView dismissInView:self.view];
    
    NSMutableDictionary * dicParams =[NSMutableDictionary dictionary];
    NSString *memberID = [[YDAPPManager shareManager]getMemberId];
    NSString *token = [[YDAPPManager shareManager]getUserToken];
    if (memberID) {
        [dicParams setObject:memberID forKey:@"memberId"];
    }
    
    __weak typeof(self) weakSelf = self;
    [ZXNetworkEngine asycnRequestWithURL:ZXAPI_Address(ZXAPI_DrugRemind_List) params:dicParams token:token method:POST zxCompletion:^(id content, NSInteger status, BOOL success, NSString *errorMsg) {
        if (success) {
            if (status == ZXAPI_SUCCESS) {
                
                [self.drugRemindArray removeAllObjects];
                id obj = content[@"data"];
                if ([obj isKindOfClass:[NSArray class]]) {
                    weakSelf.drugRemindArray = [YDDrugRemindModel mj_objectArrayWithKeyValuesArray:obj];
                    self.isNoData = FALSE;

                }
            }
            
            if (self.drugRemindArray.count == 0) {
                self.isNoData = TRUE;
                for (int i = 0; i < NoDataDefaultCellNum; i++) {
                    [self.drugRemindArray addObject:@"1"];
                }
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //刷新
                [weakSelf.remindTableView reloadData];
                
                //通知刷新Banner数据
                [[NSNotificationCenter defaultCenter] postNotificationName:ZXNOTICE_NEW_ADD_DRUGREMIND object:nil];
            });
        }else{
            [ZXEmptyView showNetworkErrorInView:weakSelf.view heightFix:0 refreshAction:^{
                [ZXEmptyView dismissInView:weakSelf.view];
                [self httpRequestForDrugRemindList];
            }];
        }
    }];
}

#pragma mark 用药提醒药品开启/关闭提醒
-(void)httpRequestForDrugRemindTurnOnWith:(BOOL)isPush andWithID:(NSString *)mId{
    NSMutableDictionary * dicParams =[NSMutableDictionary dictionary];
    NSString *memberID = [[YDAPPManager shareManager]getMemberId];
    NSString *token = [[YDAPPManager shareManager]getUserToken];
    if (memberID) {
        [dicParams setObject:memberID forKey:@"memberId"];
    }
    
    if (mId) {
        [dicParams setObject:mId forKey:@"id"];
    }
    
    [dicParams setObject:[NSString stringWithFormat:@"%@",[NSNumber numberWithBool:isPush]] forKey:@"isPush"];
    __weak typeof(self) weakSelf = self;
    [ZXNetworkEngine asycnRequestWithURL:ZXAPI_Address(ZXAPI_DrugRemind_TurnOn) params:dicParams token:token method:POST zxCompletion:^(id content, NSInteger status, BOOL success, NSString *errorMsg) {
        if (success) {
            if (status == ZXAPI_SUCCESS) {
                [ZXHUD MBShowSuccessInView:self.view text:content[@"msg"] delay:1.2];
            }else{
                [ZXHUD MBShowFailureInView:self.view text:content[@"msg"] delay:1.2];
            }
            //从新请求数据
            [weakSelf httpRequestForDrugRemindList];
            
            //通知刷新Banner数据
            [[NSNotificationCenter defaultCenter] postNotificationName:ZXNOTICE_NEW_ADD_DRUGREMIND object:nil];
        }else{
            [ZXHUD MBShowFailureInView:self.view text:errorMsg delay:1.2];
        }
    }];
}

#pragma mark 用药提醒药品删除
-(void)httpRequestForDeleteDrugRemindWithTableView:(UITableView *)tableView withIndexPath:(NSIndexPath *)indexPath withModel:(YDDrugRemindModel *)model{
    NSMutableDictionary * dicParams =[NSMutableDictionary dictionary];
    NSString *memberID = [[YDAPPManager shareManager]getMemberId];
    NSString *token = [[YDAPPManager shareManager]getUserToken];
    if (memberID) {
        [dicParams setObject:memberID forKey:@"memberId"];
    }
    
    if (model.uid) {
        [dicParams setObject:model.uid forKey:@"id"];
    }
    [ZXHUD MBShowLoadingInView:self.view text:ZXStatus_Uploading delay:0.0];
    [ZXNetworkEngine asycnRequestWithURL:ZXAPI_Address(ZXAPI_Delete_DrugRemind) params:dicParams token:token method:POST zxCompletion:^(id content, NSInteger status, BOOL success, NSString *errorMsg) {
        [ZXHUD MBHideForView:self.view animate:YES];
        if (success) {
            if (status == ZXAPI_SUCCESS) {
                
                //删除
                [self.drugRemindArray removeObjectAtIndex:indexPath.row];

                //通知刷新顶部视图
                [[NSNotificationCenter defaultCenter] postNotificationName:ZXNOTICE_NEW_ADD_DRUGREMIND object:nil];
                
                [tableView beginUpdates];
                if (self.drugRemindArray.count <= 0) {
                    [tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationLeft];
                    
                    self.isNoData = TRUE;
                }
                [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                [tableView endUpdates];
                
                [ZXHUD MBShowSuccessInView:self.view text:content[@"msg"] delay:0.5];
            }else{
                [ZXHUD MBShowFailureInView:self.view text:content[@"msg"] delay:0.5];
            }
            if (self.isNoData == TRUE && self.drugRemindArray.count == 0) {
                for (int i = 0; i < NoDataDefaultCellNum; i++) {
                    [self.drugRemindArray addObject:@"1"];
                }
                dispatch_async(dispatch_get_global_queue(0, 0), ^{
                    [self.remindTableView reloadData];
                    
                });
            }
        }else{
            [ZXHUD MBShowFailureInView:self.view text:errorMsg delay:0.5];
        }
    }];
}

#pragma mark - Getter
-(UITableView *)remindTableView{
    if (!_remindTableView) {
        _remindTableView = [[UITableView alloc] init];
        _remindTableView.dataSource = self;
        _remindTableView.delegate = self;
        _remindTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_remindTableView setSeparatorColor:[UIColor groupTableViewBackgroundColor]];
        _remindTableView.backgroundColor = [UIColor zx_assistColor];
        _remindTableView.showsVerticalScrollIndicator = NO;
        [_remindTableView registerNib:[UINib nibWithNibName:NSStringFromClass([YDRemindInfoCell class]) bundle:nil]  forCellReuseIdentifier:[YDRemindInfoCell reuseID]];
    }
    return _remindTableView;
}

-(YDDrugRemindView *)bannerView{
    if (!_bannerView) {
        _bannerView = [[YDDrugRemindView alloc]initWithFrame:CGRectMake(0, 0, ZX_BOUNDS_WIDTH, 268)];
    }
    return _bannerView;
}

-(UIView *)headerView{
    if (!_headerView) {
        _headerView = [[UIView alloc]init];
    }
    return _headerView;
}

-(NSMutableArray *)drugRemindArray{
    if (!_drugRemindArray) {
        _drugRemindArray = [[NSMutableArray alloc]init];
    }
    return _drugRemindArray;
}

-(YDNotificationStatusView *)notificationView{
    if (!_notificationView) {
        _notificationView = [YDNotificationStatusView show];
        _notificationView.delegate = self;
    }
    return _notificationView;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
