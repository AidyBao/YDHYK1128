//
//  HDrugCollectViewController.m
//  YDHYK
//
//  Created by screson on 2016/12/24.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "HDrugCollectViewController.h"
#import "HDugCollectTaTableCell.h"
#import "HDrugNoticeViewController.h"
#import "ZXDrugCollectViewModel.h"

@interface ZXSectionModel : NSObject

@property (nonatomic,strong) NSString * title;
@property (nonatomic,strong) NSMutableArray<ZXDrugCollectModel *> * list;

@end

@implementation ZXSectionModel


@end

@interface HDrugCollectViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray<ZXSectionModel *> * arrSectionList;
}
@property (weak, nonatomic) IBOutlet UITableView *tblDrugsList;

@end

@implementation HDrugCollectViewController


- (instancetype)init{
    if (self = [super init]) {
        [self setHidesBottomBarWhenPushed:true];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"药品收藏"];
    arrSectionList = [NSMutableArray array];
    
    [self.view setBackgroundColor:[UIColor zx_assistColor]];
    [self.tblDrugsList setBackgroundColor:[UIColor zx_assistColor]];
    [self.tblDrugsList setSeparatorColor:[UIColor zx_separatorColor]];
    [self.tblDrugsList registerNib:[UINib nibWithNibName:@"HDugCollectTaTableCell" bundle:nil] forCellReuseIdentifier:@"HDugCollectTaTableCell"];
    [self.tblDrugsList setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
   
    [self.tblDrugsList zx_addHeaderRefreshActionUseZXImage:true target:self action:@selector(refreshAction)];
    
    [self.tblDrugsList.mj_header beginRefreshing];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.tblDrugsList setEditing:false];
}


- (void)refreshAction{
    [self loadCollectListShowHUD:false];
}


- (void)loadCollectListShowHUD:(BOOL)bShow{
    if (bShow) {
        [ZXHUD MBShowLoadingInView:self.view text:ZX_LOADING_TEXT delay:0];
    }
    [ZXDrugCollectViewModel getDrugCollectListWithMemberId:[[ZXGlobalData shareInstance] memberId] token:[[ZXGlobalData shareInstance] userToken] completion:^(NSArray<ZXDrugCollectModel *> *list, NSInteger status, BOOL success, NSString *errorMsg) {
        if (bShow) {
            [ZXHUD MBHideForView:self.view animate:true];
        }
        [self.tblDrugsList.mj_header endRefreshing];
        if (success) {
            if (status == ZXAPI_SUCCESS) {
                if (list && [list count]) {
                    [self splitSectionWithDrugCollectModels:list];
                }else{
                    [ZXEmptyView showNoDataInView:self.view text1:@"暂无收藏记录" text2:nil heightFix:0];
                }
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
                    [self loadCollectListShowHUD:true];
                }];
            }
        }
    }];
}

- (void)splitSectionWithDrugCollectModels:(NSArray<ZXDrugCollectModel *> *)models{
    if (models && models.count) {
        [arrSectionList removeAllObjects];
        NSInteger section = 0;
        for (ZXDrugCollectModel * model in models) {
            if (section == 0) {
                ZXSectionModel * sectionM = [[ZXSectionModel alloc] init];
                sectionM.title = model.drugstoreName;
                sectionM.list = [NSMutableArray array];
                [sectionM.list addObject:model];
                [arrSectionList addObject:sectionM];
                section ++;
            }else{
                NSInteger lastSection = section - 1;
                ZXSectionModel * lastSecionM = [arrSectionList objectAtIndex:lastSection];
                if ([model.drugstoreId isEqualToString:[[lastSecionM.list firstObject] drugstoreId]]) {
                    [lastSecionM.list addObject:model];
                }else{
                    ZXSectionModel * sectionM = [[ZXSectionModel alloc] init];
                    sectionM.title = model.drugstoreName;
                    sectionM.list = [NSMutableArray array];
                    [sectionM.list addObject:model];
                    [arrSectionList addObject:sectionM];
                    section ++;
                }
            }
            
        }
    }
    [self.tblDrugsList reloadData];
}


#pragma mark - TableView DataSource 
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (arrSectionList && arrSectionList.count) {
        return arrSectionList.count;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    ZXSectionModel * sectionM = [arrSectionList objectAtIndex:section];
    if (sectionM.list && sectionM.list.count) {
        return sectionM.list.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HDugCollectTaTableCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HDugCollectTaTableCell" forIndexPath:indexPath];
    ZXSectionModel * sectionM = [arrSectionList objectAtIndex:indexPath.section];
    ZXDrugCollectModel * drugModel = sectionM.list[indexPath.row];
    [cell reloadDrugCollectInfo:drugModel];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return true;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        ZXSectionModel * sectionM = [arrSectionList objectAtIndex:indexPath.section];
        ZXDrugCollectModel * model = sectionM.list[indexPath.row];
        [ZXHUD MBShowLoadingInView:self.view text:@"删除中..." delay:0];
        [ZXDrugCollectViewModel deleteDrugCollectById:model.collectId memberId:[[ZXGlobalData shareInstance] memberId] token:[[ZXGlobalData shareInstance] userToken] completion:^(BOOL success, NSInteger status, BOOL reqSuccess, NSString *errorMsg) {
            [ZXHUD MBHideForView:self.view animate:true];
            if (success) {
                [sectionM.list removeObjectAtIndex:indexPath.row];
                if (sectionM.list && sectionM.list.count > 0) {
                    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                }else{
                    [arrSectionList removeObjectAtIndex:indexPath.section];
                    [tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
                }
                if (arrSectionList.count == 0) {
                    [self loadCollectListShowHUD:false];
                }
            }else{
                [ZXHUD MBShowFailureInView:self.view text:errorMsg delay:1.5];
            }
        }];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    ZXSectionModel * model = [arrSectionList objectAtIndex:section];
    return model.title;
}


#pragma mark - TableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 115;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSString *sectionTitle = [self tableView:tableView titleForHeaderInSection:section];
    if (sectionTitle == nil) {
        return nil;
    }
    // Create label with section title
    UILabel *label = [[UILabel alloc] init] ;
    label.frame = CGRectMake(14, 0, ZX_BOUNDS_WIDTH - 30, 20);
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor zx_textColor];
    label.font = [UIFont zx_titleFontWithSize:11];
    label.text = sectionTitle;
    UIView * hView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ZX_BOUNDS_WIDTH, 20)];
    [hView setBackgroundColor:[UIColor zx_assistColor]];
    [hView addSubview:label];
    return hView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"selected..");
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
