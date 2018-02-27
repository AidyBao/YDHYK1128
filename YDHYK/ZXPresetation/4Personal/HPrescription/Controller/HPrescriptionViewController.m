//
//  HPrescriptionViewController.m
//  YDHYK
//
//  Created by screson on 2016/12/8.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "HPrescriptionViewController.h"
#import "HPrescriptionTableCell.h"
#import "HNewPrescriptionViewController.h"
#import "ZXImagePickerUtils.h"
#import "ZXPrescriptionViewModel.h"
#import <MJPhotoBrowser/MJPhotoBrowser.h>

@interface HPrescriptionViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger currentIndex;
    NSInteger pageTotal;
    NSMutableArray<ZXPrescriptionModel *> * arrPrescriptionList;
}
@property (nonatomic,strong) ZXImagePickerUtils  * zxImgPickerUtils;;
@property (weak, nonatomic) IBOutlet UITableView *tblPrescriptionList;

@end

@implementation HPrescriptionViewController

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
    [self setTitle:@"处方"];
    currentIndex = 1;
    pageTotal = 1;
    
    [self zx_addRightBarItemsWithImageNames:@[@"h_nav_add"] originalColor:true];
    [self.tblPrescriptionList setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tblPrescriptionList setBackgroundColor:[UIColor zx_assistColor]];
    [self.tblPrescriptionList registerNib:[UINib nibWithNibName:@"HPrescriptionTableCell" bundle:nil] forCellReuseIdentifier:@"HPrescriptionTableCell"];
    
    [self.tblPrescriptionList zx_addHeaderRefreshActionUseZXImage:true target:self action:@selector(refreshAction)];
    [self.tblPrescriptionList zx_addFooterRefreshActionAutoRefresh:true target:self action:@selector(loadMoreAction)];
    [self.tblPrescriptionList.mj_header beginRefreshing];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noticeupdate) name:@"ZXUpdatePrescriptionList" object:nil];

}

- (void)noticeupdate{
    currentIndex = 1;
    pageTotal = 1;
    [ZXEmptyView dismissInView:self.view];
    [self getPrescriptionListShowHUD:true];
}

- (void)refreshAction{
    currentIndex = 1;
    pageTotal = 1;
    [self.tblPrescriptionList.mj_footer resetNoMoreData];
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
    [ZXPrescriptionViewModel getPrescriptionListWithMemberId:[[ZXGlobalData shareInstance] memberId] pageNum:currentIndex pageSize:ZXPAGE_SIZE token:[[ZXGlobalData shareInstance] userToken] completion:^(NSArray<ZXPrescriptionModel *> *list, NSInteger totalPage, NSInteger status, BOOL success, NSString *errorMsg) {
        if (bShow) {
            [ZXHUD MBHideForView:self.view animate:true];
        }
        [self.tblPrescriptionList.mj_footer endRefreshing];
        [self.tblPrescriptionList.mj_header endRefreshing];
        if (success) {
            if (status == ZXAPI_SUCCESS) {
                pageTotal = totalPage;
                if (currentIndex == 1) {
                    if (list && [list count]) {
                        arrPrescriptionList = [list mutableCopy];
                    }else{
                        [ZXEmptyView showNoDataInView:self.view text1:@"您还没有处方," text2:@"可点击右上角+号添加保存" heightFix:0];
                    }
                }else{
                    if (list && [list count]) {
                        [arrPrescriptionList addObjectsFromArray:list];
                    }
                }
                if (currentIndex >= pageTotal) {
                    [self.tblPrescriptionList.mj_footer endRefreshingWithNoMoreData];
                }
                [self.tblPrescriptionList reloadData];
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


#pragma mark - 新增处方
- (void)zx_rightBarButtonActionsIndex:(NSInteger)index{
    __weak typeof(self) weakSelf = self;
    UIAlertController * actionSheet = nil;
    if (ZX_IS_IPAD) {
        actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil  preferredStyle:UIAlertControllerStyleAlert];
    }else{
        actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil  preferredStyle:UIAlertControllerStyleActionSheet];
    }
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf.zxImgPickerUtils takePhotoUponVC:weakSelf callBack:^(UIImage *image, ZXTakePhotoStatus status, NSString *errorMsg) {
            if (status == ZXPSuccess) {
                [weakSelf newPrescriptionWithImage:image];
            }
            NSLog(@"%@",errorMsg);
        }];
    }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"从手机相册取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf.zxImgPickerUtils choosePhotoUponVC:weakSelf callBack:^(UIImage *image, ZXTakePhotoStatus status, NSString *errorMsg) {
            if (status == ZXPSuccess) {
                [weakSelf newPrescriptionWithImage:image];
            }
            NSLog(@"%@",errorMsg);
        }];
    }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController:actionSheet animated:true completion:nil];
}

- (void)newPrescriptionWithImage:(UIImage *)image{
    HNewPrescriptionViewController * newPreVC = [[HNewPrescriptionViewController alloc] init];
    newPreVC.image = image;
    [self.navigationController pushViewController:newPreVC animated:true];
}


#pragma mark - TableView DataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HPrescriptionTableCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HPrescriptionTableCell" forIndexPath:indexPath];
    [cell reloadPrescriptionData:arrPrescriptionList[indexPath.section]];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (arrPrescriptionList && arrPrescriptionList.count) {
        return arrPrescriptionList.count;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

#pragma mark - TableView Delegate 

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"selected...");
    
    UIAlertController * actionSheet = nil;
    if (ZX_IS_IPAD) {
        actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil  preferredStyle:UIAlertControllerStyleAlert];
    }else{
        actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil  preferredStyle:UIAlertControllerStyleActionSheet];
    }
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"查看处方原图" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self browseSourceImageAtIndex:indexPath.section];
    }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"删除处方" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self deletePrescriptionAtSectionIndex:indexPath.section];
    }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:actionSheet animated:true completion:nil];
    });
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  277;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

#pragma mark - 查看原图
- (void)browseSourceImageAtIndex:(NSInteger)index{
    ZXPrescriptionModel * model = [arrPrescriptionList objectAtIndex:index];
    MJPhotoBrowser *brower = [[MJPhotoBrowser alloc] init];
    NSMutableArray *photos = [NSMutableArray array];
    for (int i = 0 ; i < model.arrImages.count; i++) {
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.url = [NSURL URLWithString:model.arrImages[i]];
        [photos addObject:photo];
    }
    brower.showSaveBtn = false;
    brower.photos = photos;
    [brower show];
}

#pragma mark - 删除处方
-(void)deletePrescriptionAtSectionIndex:(NSInteger)index{
    ZXPrescriptionModel * model = [arrPrescriptionList objectAtIndex:index];
    [ZXAlertUtils showAAlertMessage:@"确认删除该处方记录" title:@"提示" buttonTexts:@[@"删除",@"取消"] buttonAction:^(int buttonIndex) {
        if (buttonIndex == 0) {
            [ZXHUD MBShowLoadingInView:self.view text:@"删除中..." delay:0];
            [ZXPrescriptionViewModel deletePrescriptionById:model.pId memberId:[[ZXGlobalData shareInstance] memberId] token:[[ZXGlobalData shareInstance] userToken] completion:^(BOOL deleteSuccess, NSInteger status, BOOL success, NSString *errorMsg) {
                [ZXHUD MBHideForView:self.view animate:true];
                if (deleteSuccess) {
                    [arrPrescriptionList removeObjectAtIndex:index];
                    [_tblPrescriptionList deleteSections:[NSIndexSet indexSetWithIndex:index] withRowAnimation:UITableViewRowAnimationAutomatic];
                    if (arrPrescriptionList.count == 0) {
                        [self refreshAction];
                    }
                }else{
                    [ZXHUD MBShowFailureInView:self.view text:errorMsg delay:2];
                }
            }];
        }
    }];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ZXUpdatePrescriptionList" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 
- (ZXImagePickerUtils *)zxImgPickerUtils{
    if (!_zxImgPickerUtils) {
        _zxImgPickerUtils = [[ZXImagePickerUtils alloc] init];
    }
    return _zxImgPickerUtils;
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
