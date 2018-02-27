//
//  YDReceiverAddressTableViewController.m
//  ydhyk
//
//  Created by Aidy Bao on 2016/11/13.
//  Copyright © 2016年 120v. All rights reserved.
//

#import "YDReceiverAddressTableViewController.h"
#import "YDReceiverAddressTableViewCell.h"
/** 编辑地址*/
#import "YDEidtAddressTableViewController.h"
/** 模型*/
#import "YDReceiverAddressModel.h"

static NSString *const AddressCellID = @"AddressCellID";

@interface YDReceiverAddressTableViewController ()<YDReceiverAddressTableViewCellDelegate>

@property (nonatomic ,strong) NSMutableArray *dataArray;

@end

@implementation YDReceiverAddressTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的收货地址";
    //
    self.view.backgroundColor = [UIColor zx_assistColor];
    self.tableView.backgroundColor = [UIColor zx_assistColor];
    
    //右边按钮
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addAction:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YDReceiverAddressTableViewCell class]) bundle:nil] forCellReuseIdentifier:AddressCellID];
    
    //刷新控件
    [self addRefreshView];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - 刷新
-(void)addRefreshView{
    [self.tableView zx_addHeaderRefreshActionUseZXImage:YES target:self action:@selector(loadNewData)];
    [self.tableView.mj_header beginRefreshing];
}

-(void)loadNewData{
    [self httpRequestForReceiverAddressList];
}

#pragma mark - 添加收货地址
-(void)addAction:(UIBarButtonItem *)sender{
    YDEidtAddressTableViewController *editVC = [YDEidtAddressTableViewController instantiateFromStoryboard];
    editVC.hidesBottomBarWhenPushed = YES;
    editVC.isNewAdd = TRUE;
    [self.navigationController pushViewController:editVC animated:YES];
}

#pragma mark - HTTP
#pragma mark 收货地址
-(void)httpRequestForReceiverAddressList{
    
    [ZXEmptyView dismissInView:self.view];
    
    NSMutableDictionary * dicParams =[NSMutableDictionary dictionary];
    NSString *memberID = [[YDAPPManager shareManager]getMemberId];
    NSString *token = [[YDAPPManager shareManager] getUserToken];
    if (memberID) {
        [dicParams setObject:memberID forKey:@"memberId"];
    }
    __weak typeof(self) weakSelf = self;
    [ZXNetworkEngine asycnRequestWithURL:ZXAPI_Address(ZXAPI_Receiver_Address) params:dicParams token:token method:POST zxCompletion:^(id content, NSInteger status, BOOL success, NSString *errorMsg) {
        if (success) {
            if (status == ZXAPI_SUCCESS) {
                    [self.dataArray removeAllObjects];
                    id obj = content[@"data"];
                    if ([obj isKindOfClass:[NSArray class]] && [obj count]) {
                        [self.dataArray addObjectsFromArray: [YDReceiverAddressModel mj_objectArrayWithKeyValuesArray:obj]];
                    }else{
                        [ZXEmptyView showNoDataInView:weakSelf.view text1:@"没有数据" text2:nil heightFix:0];
                    }
            }else{
                [ZXEmptyView showNoDataInView:weakSelf.view text1:@"没有数据" text2:nil heightFix:0];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }else{
            [ZXEmptyView showNetworkErrorInView:weakSelf.view heightFix:0 refreshAction:^{
                [ZXEmptyView dismissInView:weakSelf.view];
                [self httpRequestForReceiverAddressList];
            }];
        }
        [self.tableView.mj_header endRefreshing];
    }];
}

#pragma mark 删除收货地址
-(void)httpRequestForRemoveReceiverAddressWithUID:(NSString *)UID withIndex:(NSInteger)index{
    NSMutableDictionary * dicParams =[NSMutableDictionary dictionary];
    NSString *memberID = [[YDAPPManager shareManager]getMemberId];
    NSString *token = [[YDAPPManager shareManager] getUserToken];
    
    if (memberID) {
        [dicParams setObject:memberID forKey:@"memberId"];
    }
    if (UID) {
         [dicParams setObject:UID forKey:@"id"];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [ZXHUD MBShowSuccessInView:self.view text:ZX_LOADING_TEXT delay:0];
    });
    __weak typeof(self) weakSelf = self;
    [ZXNetworkEngine asycnRequestWithURL:ZXAPI_Address(ZXAPI_Remove_Address) params:dicParams token:token method:POST zxCompletion:^(id content, NSInteger status, BOOL success, NSString *errorMsg) {
        [ZXHUD MBHideForView:self.view animate:true];
        if (success) {
            if (status == ZXAPI_SUCCESS) {
                [ZXHUD MBShowSuccessInView:self.view text:content[@"msg"] delay:1.2];
            }else{
                [ZXHUD MBShowFailureInView:self.view text:content[@"msg"] delay:1.2];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.dataArray removeObjectAtIndex:index];
                
                if (self.dataArray.count == 0) {
                    [ZXEmptyView showNoDataInView:self.view text1:@"没有数据" text2:nil heightFix:0];
                }
                
                [weakSelf.tableView reloadData];
            });

        }else{
            [ZXHUD MBShowFailureInView:self.view text:errorMsg delay:1.2];
        }
    }];
}

#pragma mark 默认收货地址
-(void)httpRequestForsettingDefaultAddressWithUID:(NSString *)UID{
    NSMutableDictionary * dicParams =[NSMutableDictionary dictionary];
    NSString *memberID = [[YDAPPManager shareManager]getMemberId];
    NSString *token = [[YDAPPManager shareManager] getUserToken];
    
    if (memberID) {
        [dicParams setObject:memberID forKey:@"memberId"];
    }
    if (UID) {
        [dicParams setObject:UID forKey:@"id"];
    }
    [ZXHUD MBShowLoadingInView:self.view text:ZX_LOADING_TEXT delay:1.2];
    __weak typeof(self) weakSelf = self;
    [ZXNetworkEngine asycnRequestWithURL:ZXAPI_Address(ZXAPI_Set_Default_Address) params:dicParams token:token method:POST zxCompletion:^(id content, NSInteger status, BOOL success, NSString *errorMsg) {
        [ZXHUD MBHideForView:self.view animate:true];
        if (success) {
            if (status == ZXAPI_SUCCESS) {
                [ZXHUD MBShowSuccessInView:self.view text:content[@"msg"] delay:1.2];
                //修改成功后重新请求
                [weakSelf.tableView.mj_header beginRefreshing];
                
            }else{
                [ZXHUD MBShowFailureInView:self.view text:content[@"msg"] delay:1.2];
            }
//            [weakSelf.tableView reloadData];
        }else{
            [ZXHUD MBShowFailureInView:self.view text:errorMsg delay:1.2];
        }
    }];
}


#pragma mark - Table view data source

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.dataArray.count > 0) {
        if (_delegagte && [_delegagte respondsToSelector:@selector(zxAddressListSelected:)]) {
            [_delegagte zxAddressListSelected:self.dataArray[indexPath.row]];
            [self.navigationController popViewControllerAnimated:true];
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 171;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YDReceiverAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AddressCellID forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    
    if (self.dataArray.count) {
        cell.addressModel = [self.dataArray objectAtIndex:indexPath.row];
    }
    
    return cell;
}

#pragma mark - YDReceiverAddressTableViewCellDelegate
#pragma mark 设置默认
-(void)didSelectedSetDefaultAddressButtonAction:(UIButton *)sender withModel:(YDReceiverAddressModel *)addressModel{
    [self httpRequestForsettingDefaultAddressWithUID:addressModel.uid];
}

#pragma mark 编辑
-(void)didSelectedEditButtonAction:(UIButton *)sender withModel:(YDReceiverAddressModel *)addressModel{
    
    YDEidtAddressTableViewController *editVC = [YDEidtAddressTableViewController instantiateFromStoryboard];
    editVC.addressModel = addressModel;
    editVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:editVC animated:YES];
}

#pragma mark 删除
-(void)didSelectedDeleteButtonAction:(UIButton *)sender withModel:(YDReceiverAddressModel *)addressModel{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定删除地址吗？" preferredStyle:UIAlertControllerStyleAlert];
    //取消
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertController addAction:cancelAction];
    
    //确定
    
    __block YDReceiverAddressModel *model = nil;
    __weak typeof(self) weakSelf = self;
    UIAlertAction *moreAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf.dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            model = obj;
            if (model.uid.integerValue == addressModel.uid.integerValue) {
                *stop = true;
                dispatch_async(dispatch_get_global_queue(0, 0), ^{
                    [weakSelf httpRequestForRemoveReceiverAddressWithUID:addressModel.uid withIndex:idx];
                });
            }
        }];
    }];
    [alertController addAction:moreAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - getter
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
