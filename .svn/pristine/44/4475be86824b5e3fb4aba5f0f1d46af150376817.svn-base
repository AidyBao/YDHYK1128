//
//  YDListTableViewController.m
//  ydhyk
//
//  Created by 120v on 2016/10/25.
//  Copyright © 2016年 120v. All rights reserved.
//

#import "YDListTableViewController.h"
/** 清单Cell*/
#import "YDListTableViewCell.h"
/** 顶部分段按钮*/
#import "YDSegmentView.h"
/** 加入会员步骤*/
#import "HJoinLeadViewController.h"
/** 搜索*/
#import "YDSearchViewController.h"
/** 地图*/
#import "YDNearbyRootViewController.h"
/** 刷新*/
#import "UIScrollView+ZXPullDownRefresh.h"
/** 药店数据模型*/
#import "YDSearchModel.h"
/** FMDB工具*/
#import "LKDBTool.h"

#import "HQRScanViewController.h"
#import "YDHYK-Swift.h"


/** 清单Cell*/
static NSString * const listCell = @"listCell";

#define PAGESIZE 10

//全部
#define AllSTR @"全部"
#define ChineseMedicine @"中医馆"
#define Drugstore @"药店"
//范围不限
#define AnyRegion @"范围不限"
#define WithInFiveHundred @"5百米内"
#define WithInOneThousand @"1千米内"
#define WithInThreeThousand @"3千米内"
#define WithInFiveThousand @"5千米内"
//距离不限
#define DistancePriority @"距离优先"
#define MemberPriority @"会员优先"


@interface YDListTableViewController ()<YDSegmentViewDelegate,YDListTableViewCellDelegate,UITableViewDelegate,UITableViewDataSource>
/** tableView*/
@property (weak, nonatomic) IBOutlet UITableView *tableView;
/**  顶部搜索 */
@property (nonatomic, strong) UIButton *searchButton;
/**  左边按钮 */
@property (nonatomic, strong) UIButton *leftBtn;
/**  右边按钮 */
@property (nonatomic, strong) UIButton *rightBtn;
/** 隔离视图 */
@property (weak, nonatomic) IBOutlet UIView *geliView;
/**  全部 */
@property (weak, nonatomic) IBOutlet UILabel *allLabel;
@property (weak, nonatomic) IBOutlet UIImageView *allImageView;
@property (weak, nonatomic) IBOutlet UIButton *allButton;

/**  范围不限 */
@property (weak, nonatomic) IBOutlet UILabel *regionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *regionImageView;
@property (weak, nonatomic) IBOutlet UIButton *regionButton;

/**  距离优先 */
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *distanceImageView;
@property (weak, nonatomic) IBOutlet UIButton *distanceButton;

/** 顶部视图*/
@property (weak, nonatomic) IBOutlet UIView *topView;
/**  顶部弹出视图 */
@property (strong, nonatomic) YDSegmentView *segmentView;
/** 所有数据*/
@property (nonatomic, strong) NSArray *allSearchArray;
/** 数据源*/
@property (nonatomic, strong) NSMutableArray *dataModelArray;
/** 页数*/
@property (nonatomic, assign) NSInteger pageIndex;

@property (nonatomic, strong)NSString *allSql;
@property (nonatomic, strong)NSString *regionSql;
@property (nonatomic, strong)NSString *distanceSql;
@property (nonatomic, strong)NSString *sql;

@property (nonatomic, strong) NSMutableArray *tempArray;
@property (nonatomic, strong) NSString *isfirstClick;
@property (nonatomic, strong) NSString *distanceStr;

@end

@implementation YDListTableViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    //1.页数
    _pageIndex = 1;
    
    //2.设置左文字右图片
    [self setupButtonStyle];
    
    //3.设置导航栏按钮
    [self setupNavgationView];

    //4.tableView样式
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YDListTableViewCell class]) bundle:nil] forCellReuseIdentifier:listCell];
    
    //5.从本地取出数据
    [self.tempArray removeAllObjects];
    [ZXHUD MBShowLoadingInView:self.tableView text:ZX_LOADING_TEXT delay:1.0];
    [self.tempArray addObjectsFromArray:[YDSearchModel findAll]];
    [self reloadTableViewWithSearchData:[YDSearchModel findAll]];
    
    //6.添加刷新功能
    [self addRefreshView];
    
    //7.加入会员成功通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(monitorJoinMemberSuccess:) name:ZXNOTICE_JOINMEMBER_SUCCESS object:nil];
}

#pragma mark - 加入会员成功通知
-(void)monitorJoinMemberSuccess:(NSNotification *)obj{
    //1.数据库查找
    id infor = obj.object;
    NSString *storeId = nil;
    if ([infor isKindOfClass:[NSDictionary class]]) {
        storeId = [infor objectForKey:@"storeId"];
    }
    
    //2.查找
    YDSearchModel *model = [[YDSearchModel alloc]init];
    model = [YDSearchModel findFirstByCriteria:[NSString stringWithFormat:@"WHERE uid = %@",storeId]];
    
    //3.修改
    if (model.isMember.intValue == 0) {
        model.isMember = [NSString stringWithFormat:@"%@",@"0"];
        [model update];
    }
    
    //4.搜索
//    [self searchDataFromLocalCacheWithSQLString:self.sql];
    [self reloadTableViewWithSearchData:[YDSearchModel findAll]];
}

#pragma mark - 刷新功能
-(void)addRefreshView{
    [self.tableView zx_addFooterRefreshActionAutoRefresh:YES target:self action:@selector(loadNewData)];
}

-(void)loadNewData{
    
    //1.停止刷新
    [self.tableView.mj_footer endRefreshing];
    
    //2.取值
    NSArray *refreshArray = nil;
    if (self.allSearchArray.count%10 == 0) {//能被10整除
        if (self.allSearchArray.count<= PAGESIZE) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            refreshArray = [self.allSearchArray subarrayWithRange:NSMakeRange(_pageIndex*PAGESIZE, PAGESIZE)];
            if (_pageIndex <= self.allSearchArray.count/10) {
                _pageIndex++;
            }else{
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
        }
    }else{//不能被10整除
        if (_pageIndex <= self.allSearchArray.count/10) {
            if (_pageIndex == self.allSearchArray.count/10) {
                refreshArray = [self.allSearchArray subarrayWithRange:NSMakeRange(_pageIndex*PAGESIZE, self.allSearchArray.count%10)];
            }else{
                refreshArray = [self.allSearchArray subarrayWithRange:NSMakeRange(_pageIndex*PAGESIZE, PAGESIZE)];
            }
            _pageIndex ++ ;
        }else{
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
    }
    //3.添加数据
    [self.dataModelArray addObjectsFromArray:refreshArray];

    //4.刷新
    [self.tableView reloadData];
}

#pragma mark - 按钮样式
-(void)setupButtonStyle{
    //1.配置
    self.view.backgroundColor = [UIColor zx_assistColor];
    self.tableView.backgroundColor = [UIColor zx_assistColor];
    self.tableView.backgroundColor = [UIColor zx_assistColor];
    self.allLabel.textColor = [UIColor zx_textColor];
    self.regionLabel.textColor = [UIColor zx_textColor];
    self.distanceLabel.textColor = [UIColor zx_textColor];
    self.geliView.backgroundColor = [UIColor zx_assistColor];
}

#pragma mark - 设置“地图”按钮
#pragma mark  自定义导航栏按钮
-(void)setupNavgationView{
    //关闭
    [self zx_addLeftBarItemsWithTexts:@[@"关闭"] font:nil color:nil];
    //列表
    [self zx_addRightBarItemsWithTexts:@[@"地图"] font:nil color:nil];
    //搜索
    [self creatSearchView];
}

#pragma mark  自定义导航栏中间搜索按钮
-(void)creatSearchView{
    //点击搜索
    self.searchButton.x = CGRectGetMaxX(self.leftBtn.frame)+15;
    self.searchButton.y = 7;
    self.searchButton.height = 30;
    self.searchButton.width = ZX_BOUNDS_WIDTH-2*self.searchButton.x;
    self.searchButton.backgroundColor = [UIColor whiteColor];
    [self.searchButton addTarget:self action:@selector(searchButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.searchButton setImage:[UIImage imageNamed:@"icon-search"] forState:UIControlStateNormal];
    [self.searchButton setTitle:@" 搜索药店、医馆" forState:UIControlStateNormal];
    [self.searchButton setTitleColor:[UIColor zx_sub2TextColor] forState:UIControlStateNormal];
    self.searchButton.titleLabel.font = [UIFont zx_iconfontWithSize:15.0];
    [self.searchButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    self.searchButton.layer.cornerRadius = 5.0;
    self.searchButton.layer.masksToBounds = YES;
    self.navigationItem.titleView = self.searchButton;
}

#pragma mark 关闭
- (void)zx_leftBarButtonActionsIndex:(NSInteger)index{
//    [self.navigationController popToRootViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark 地图
- (void)zx_rightBarButtonActionsIndex:(NSInteger)index{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - SearchButton
-(void)searchButtonClick:(UIButton *)sender{
    YDSearchViewController *searchVC = [[YDSearchViewController alloc]init];
    [self.navigationController pushViewController:searchVC animated:YES];
}

#pragma mark - 全部/范围不限/距离优先点击事件
#pragma mark  全部
- (IBAction)allButtonClick:(UIButton *)sender {

    self.regionImageView.image = [UIImage imageNamed:@"icon-more"];
    self.distanceImageView.image = [UIImage imageNamed:@"icon-more"];
    
    if (sender.selected == true){
        self.allImageView.image = [UIImage imageNamed:@"icon-more"];
        [self.segmentView removeFromSuperview];
        _segmentView = nil;
    }else{
        [self.segmentView removeFromSuperview];
        _segmentView = nil;
        
        self.allImageView.image = [UIImage imageNamed:@"icon-shou"];
        [self.view addSubview:self.segmentView];
        self.segmentView.buttonType = TOPALL;
        self.segmentView.defaultStr = self.allLabel.text;
    }
    
    sender.selected = !sender.selected;
}

#pragma mark  范围不限
- (IBAction)regionButtonClick:(UIButton *)sender {
    
    self.allImageView.image = [UIImage imageNamed:@"icon-more"];
    self.distanceImageView.image = [UIImage imageNamed:@"icon-more"];

    if (sender.selected == true){
        self.regionImageView.image = [UIImage imageNamed:@"icon-more"];
        [self.segmentView removeFromSuperview];
        _segmentView = nil;
    }else{
        self.regionImageView.image = [UIImage imageNamed:@"icon-shou"];
        [self.segmentView removeFromSuperview];
        _segmentView = nil;
        [self.view addSubview:self.segmentView];
        self.segmentView.buttonType = TOPREGION;
        self.segmentView.defaultStr = self.regionLabel.text;
    }
    
    sender.selected = !sender.selected;
}

#pragma mark  距离优先
- (IBAction)distanceButtonClick:(UIButton *)sender {
    
    self.allImageView.image = [UIImage imageNamed:@"icon-more"];
    self.regionImageView.image = [UIImage imageNamed:@"icon-more"];

    if (sender.selected == true){
        self.distanceImageView.image = [UIImage imageNamed:@"icon-more"];
        [self.segmentView removeFromSuperview];
        _segmentView = nil;
    }else{
        self.distanceImageView.image = [UIImage imageNamed:@"icon-shou"];
        [self.segmentView removeFromSuperview];
        _segmentView = nil;
        [self.view addSubview:self.segmentView];
        self.segmentView.buttonType = TOPDISTANCE;
        self.segmentView.defaultStr = self.distanceLabel.text;
    }
    
    sender.selected = !sender.selected;
}

#pragma mark  移除
-(void)didRemoveSuperView{
    self.allImageView.image = [UIImage imageNamed:@"icon-more"];
    self.regionImageView.image = [UIImage imageNamed:@"icon-more"];
    self.distanceImageView.image = [UIImage imageNamed:@"icon-more"];
    
    [self.segmentView removeFromSuperview];
    _segmentView = nil;
    
    self.allButton.selected = false;
    self.regionButton.selected = false;
    self.distanceButton.selected = false;
}

#pragma mark - YDSegmentDelegate
-(void)didSelectedCellWithDataArray:(NSArray *)array withIndex:(NSInteger)cellIndex withButtonType:(NSString *)buttonType{
    
    //1.移除数据
//    self.allSearchArray = nil;
//    [self.dataModelArray removeAllObjects];
    
    //
    [ZXEmptyView dismissInView:self.tableView];
    [ZXHUD MBShowLoadingInView:self.tableView text:ZX_LOADING_TEXT delay:1.0];
    
    //
    self.sql = nil;
    _pageIndex = 1;
    
    //2.给顶部lable赋值
    NSString *allStr = nil;
    NSString *regionStr = nil;
    NSString *distanceStr = nil;
    
    //
    self.allButton.selected = false;
    self.regionButton.selected = false;
    self.distanceButton.selected = false;
    
    if ([buttonType isEqualToString:TOPALL]) {
        self.allImageView.image = [UIImage imageNamed:@"icon-more"];
        self.allLabel.text = [array objectAtIndex:cellIndex];
        allStr = [array objectAtIndex:cellIndex];
    }
    if ([buttonType isEqualToString:TOPREGION]) {
        self.regionImageView.image = [UIImage imageNamed:@"icon-more"];
        self.regionLabel.text = [array objectAtIndex:cellIndex];
        regionStr = [array objectAtIndex:cellIndex];
    }
    if ([buttonType isEqualToString:TOPDISTANCE]) {
        self.distanceImageView.image = [UIImage imageNamed:@"icon-more"];
        self.distanceLabel.text = [array objectAtIndex:cellIndex];
        distanceStr = [array objectAtIndex:cellIndex];
    }
    
    //3.获取搜索条件
    if ([buttonType isEqualToString:TOPALL]) {
        if ([allStr isEqualToString:[array objectAtIndex:1]]) {
            self.allSql =[NSString stringWithFormat:@"isChineseMedicine = '%@'", @1];
        }else if ([allStr isEqualToString:[array objectAtIndex:2]]){
            self.allSql =[NSString stringWithFormat:@"isChineseMedicine = '%@'", @0];
        }else{
            self.allSql = nil;
        }

    }else if ([buttonType isEqualToString:TOPREGION]){
        if (regionStr.length) {
            switch (cellIndex) {
                case 0:
                    break;
                case 1:
                    regionStr = @"0.5";
                    break;
                case 2:
                    regionStr = @"1.0";
                    break;
                case 3:
                    regionStr = @"3.0";
                    break;
                case 4:
                    regionStr = @"5.0";
                    break;
                default:
                    break;
            }
            if ([regionStr isEqualToString:[array objectAtIndex:0]]) {
                self.regionSql = nil;
            }else{
                self.regionSql = [NSString stringWithFormat:@"distanceF < '%@'",regionStr];
            }
        }
    }else if ([buttonType isEqualToString:TOPDISTANCE]){
        self.distanceStr = distanceStr;
         if ([distanceStr isEqualToString:[array objectAtIndex:1]]) {
            self.distanceSql = [NSString stringWithFormat:@"isMember = '%@'",@1];
         }else{
             self.distanceSql = nil;
         }
    }
    
//    //4.拼接SQL语句
//    if (self.allSql.length && self.regionSql.length == 0 && self.distanceSql.length == 0) {
//        self.sql = [NSString stringWithFormat:@"WHERE %@",self.allSql];
//    }else if (self.allSql.length && self.regionSql.length && self.distanceSql.length == 0){
//        self.sql = [NSString stringWithFormat:@"WHERE %@ AND %@",self.allSql,self.regionSql];
//    }else if (self.allSql.length && self.regionSql.length && self.distanceSql.length){
//        self.sql = [NSString stringWithFormat:@"WHERE %@ AND %@ AND %@",self.allSql,self.regionSql,self.distanceSql];
//    }else if (self.allSql.length && self.regionSql.length == 0 && self.distanceSql.length){
//        self.sql = [NSString stringWithFormat:@"WHERE %@ AND %@",self.allSql,self.distanceSql];
//    }else if (self.allSql.length == 0 && self.regionSql.length && self.distanceSql == 0){
//        self.sql = [NSString stringWithFormat:@"WHERE %@",self.regionSql];
//    }else if (self.allSql.length == 0 && self.regionSql.length == 0 && self.distanceSql){
//        self.sql = [NSString stringWithFormat:@"WHERE %@",self.distanceSql];
//    }else if (self.allSql.length == 0 && self.regionSql.length && self.distanceSql){
//        self.sql = [NSString stringWithFormat:@"WHERE %@ AND %@",self.regionSql,self.distanceSql];
//    }
//    
//    //5.搜索
//    [self searchDataFromLocalCacheWithSQLString:self.sql];
    
    NSArray *searchArray = nil;
    self.sql = nil;
    [self.tempArray removeAllObjects];
    
    if (self.allSql.length == 0 && self.regionSql.length == 0 && self.distanceSql.length == 0) {//筛选为空
        searchArray = [YDSearchModel findAll];
        [self.tempArray addObjectsFromArray:searchArray];
    }else{//筛选不为空
        if (self.distanceSql.length == 0) {//没有选择“距离选项”
            if (self.allSql.length && self.regionSql.length) {
                self.sql = [NSString stringWithFormat:@"WHERE %@ AND %@",self.allSql,self.regionSql];
                searchArray = [YDSearchModel findByCriteria:self.sql];
                [self.tempArray addObjectsFromArray:searchArray];
            }else if (self.allSql.length && self.regionSql.length == 0){
                self.sql = [NSString stringWithFormat:@"WHERE %@",self.allSql];
                searchArray = [YDSearchModel findByCriteria:self.sql];
                [self.tempArray addObjectsFromArray:searchArray];
            }else if (self.allSql.length == 0 && self.regionSql.length){
                self.sql = [NSString stringWithFormat:@"WHERE %@",self.regionSql];
                searchArray = [YDSearchModel findByCriteria:self.sql];
                [self.tempArray addObjectsFromArray:searchArray];
            }else{
                searchArray = [YDSearchModel findAll];
                [self.tempArray addObjectsFromArray:searchArray];
            }
        }else if(self.distanceSql.length){//距离选项不为空
            if (self.allSql.length == 0 && self.regionSql.length == 0) {
                if ([self.distanceStr isEqualToString:MemberPriority]) {//会员优先
                    searchArray = [YDSearchModel findAll];
                    [self.tempArray addObjectsFromArray:searchArray];
                    searchArray = [self sortMemberData:self.tempArray];
                }else{
                    searchArray = self.tempArray;
                }
            }else if (self.allSql.length == 0  && self.regionSql.length){//范围
                self.sql = [NSString stringWithFormat:@"WHERE %@",self.regionSql];
                searchArray = [YDSearchModel findByCriteria:self.sql];
                [self.tempArray addObjectsFromArray:searchArray];
                if ([self.distanceStr isEqualToString:MemberPriority]){
                    searchArray = [self sortMemberData:self.tempArray];
                }
            }else if (self.allSql.length && self.regionSql.length == 0){//全部
                self.sql = [NSString stringWithFormat:@"WHERE %@",self.allSql];
                searchArray = [YDSearchModel findByCriteria:self.sql];
                [self.tempArray addObjectsFromArray:searchArray];
                if ([self.distanceStr isEqualToString:MemberPriority]){
                    searchArray = [self sortMemberData:self.tempArray];
                }
            }else if (self.allSql.length && self.regionSql.length){//范围&& 全部
                self.sql = [NSString stringWithFormat:@"WHERE %@ AND %@",self.allSql,self.regionSql];
                searchArray = [YDSearchModel findByCriteria:self.sql];
                [self.tempArray addObjectsFromArray:searchArray];
                if ([self.distanceStr isEqualToString:MemberPriority]){
                    searchArray = [self sortMemberData:self.tempArray];
                }
            }
        }
    }
    
    [self reloadTableViewWithSearchData:searchArray];
}

#pragma mark 筛选会员
-(NSMutableArray *)sortMemberData:(NSMutableArray *)tempArray{
    NSMutableArray *resultArray = nil;
    __block NSMutableArray *mArray = [[NSMutableArray alloc]initWithCapacity:5];
    __block YDSearchModel *model = nil;
    [tempArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        model = obj;
        if (model.isMember.integerValue == 1) {
            [mArray addObject:model];
        }
    }];
    resultArray = [self sortWithAllArray:tempArray withResutArray:mArray];
    return resultArray;
}

#pragma mark 刷新数据
-(void)reloadTableViewWithSearchData:(NSArray *)searchArray{
    self.allSearchArray = nil;
    [self.dataModelArray removeAllObjects];
    if (searchArray.count) {
        self.allSearchArray = searchArray;
        NSArray *array = nil;
        if (self.allSearchArray.count<PAGESIZE) {
            array = [self.allSearchArray subarrayWithRange:NSMakeRange(0, self.allSearchArray.count)];
        }else{
            array = [self.allSearchArray subarrayWithRange:NSMakeRange(0, PAGESIZE)];
        }
        [self.dataModelArray addObjectsFromArray:array];
    }else{
        [ZXEmptyView showNoDataInView:self.tableView text1:@"暂无数据" text2:@"" heightFix:0];
    }
    [self.tableView.mj_footer resetNoMoreData];
    [self.tableView reloadData];
}

#pragma mark 排序
-(NSMutableArray *)sortWithAllArray:(NSMutableArray *)allArray withResutArray:(NSArray *)resutArray{
    
    __block YDSearchModel *model1 = nil;
    __block YDSearchModel *model2 = nil;
    [resutArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        model1 = obj;
        [allArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            model2 = obj;
            if ([model1.uid isEqualToString:model2.uid]) {
                [allArray removeObject:obj];
                *stop = TRUE;
            }
        }];
    }];
    
    int count =(int)resutArray.count;
    for (int i = count - 1; 0 <= i; i --) {
        YDSearchModel *model = resutArray[i];
        [allArray insertObject:model atIndex:0];
    }
    
    return allArray;
}

//#pragma mark - 条件查询
//-(void)searchDataFromLocalCacheWithSQLString:(NSString *)sql{
//    
//    self.allSearchArray = nil;
//    [self.dataModelArray removeAllObjects];
//
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        NSArray *resultArray = nil;
//        if (self.sql.length) {
//            resultArray = [YDSearchModel findByCriteria:sql];
//            
//            //如果没有过滤条件的情况需要显示全部数据
//            if((self.allSql.length == 0 && self.regionSql.length == 0 && self.distanceSql)){
//                NSMutableArray *allListArray = [NSMutableArray arrayWithArray:[YDSearchModel findAll]];
//                __block YDSearchModel *model1 = nil;
//                __block YDSearchModel *model2 = nil;
//                [resultArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                    model1 = obj;
//                    [allListArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                        model2 = obj;
//                        if ([model1.uid isEqualToString:model2.uid]) {
//                            [allListArray removeObject:obj];
//                            *stop = TRUE;
//                        }
//                    }];
//                }];
//    
//                int count =(int)resultArray.count;
//                for (int i = count - 1; 0 <= i; i --) {
//                    YDSearchModel *model = resultArray[i];
//                    [allListArray insertObject:model atIndex:0];
//                }
//                resultArray = allListArray;
//            }
//        }else{
//            resultArray = [YDSearchModel findAll];
//        }
//       
//        if (resultArray.count) {
//            self.allSearchArray = resultArray;
//            NSArray *array = nil;
//            if (self.allSearchArray.count<PAGESIZE) {
//                array = [self.allSearchArray subarrayWithRange:NSMakeRange(0, self.allSearchArray.count)];
//            }else{
//                array = [self.allSearchArray subarrayWithRange:NSMakeRange(0, PAGESIZE)];
//            }
//            [self.dataModelArray addObjectsFromArray:array];
//        }else{
//            [ZXHUD showFailureWithinText:@"暂无数据"];
//        }
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self.tableView.mj_footer resetNoMoreData];
//            [self.tableView reloadData];
//        });
//    });
//}

#pragma mark - YDListTableViewCellDelegate
#pragma mark 打电话
-(void)didListViewTelephoneButton:(UIButton *)sender withModel:(YDSearchModel *)model{
    if ([model.tel isKindOfClass:[NSString class]] && model.tel.length){
        [ZXCommonUtils openCallWithTelNum:model.tel failBlock:^{
            [ZXAlertUtils showAAlertMessage:@"该设备不支持拨打电话功能" title:@"提示" buttonText:@"知道了" buttonAction:nil];
        }];
    }else{
        [ZXHUD MBShowFailureInView:self.view text:@"无相关联系方式" delay:1.5];
    }
}

#pragma mark 加入会员
-(void)didListViewJoinMemberButton:(UIButton *)sender withModel:(YDSearchModel *)model{
    if (model.isMember.integerValue == 0){//加入会员
        [HJoinLeadViewController checkShowWithCompletion:^{
            HQRScanViewController * qrVC = [[HQRScanViewController alloc] init];
            [self.navigationController pushViewController:qrVC animated:true];
        }];
    }
}

#pragma mark 购药
-(void)didListViewBuyButton:(UIButton *)sender withModel:(YDSearchModel *)model{
    if (model.isMember.integerValue == 1) {//商城
        if (![[[ZXGlobalData shareInstance] userTelephone] isEqualToString:ZXAPP_Common_TestAccount]) {
            ZXStoreRootViewController * webStore = [ZXStoreRootViewController configVCWith:model.uid memberId:[[ZXGlobalData shareInstance] memberId] token:[[ZXGlobalData shareInstance] userToken]];
            
            [self.navigationController pushViewController:webStore animated:true];
        }
    }
}

#pragma mark 定位
-(void)didListViewLocationButton:(UIButton *)sender withModel:(YDSearchModel *)model{
    if (model.latitude.floatValue && model.longitude.floatValue) {
        NSArray *vcArray = [self.navigationController viewControllers];
        __block YDNearbyRootViewController *mapVC = nil;
        [vcArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[YDNearbyRootViewController class]]) {
                mapVC = obj;
                *stop = true;
            }
        }];
        
        mapVC.isLocationButtonClick = YES;
        NSMutableArray *mArray = [[NSMutableArray alloc]init];
        [mArray addObject:model];
        mapVC.modelArray = mArray;
       
        [self.navigationController popToViewController:mapVC animated:YES];
    }else{
        [ZXHUD MBShowFailureInView:self.view text:@"定位失败" delay:1.2];
        return;
    }
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataModelArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 143;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YDListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:listCell forIndexPath:indexPath];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"YDListTableViewCell" owner:self options:nil].firstObject;
    }
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.dataModel = [self.dataModelArray objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - lazy
-(UIButton *)searchButton{
    if (!_searchButton) {
        _searchButton = [[UIButton alloc]init];
    }
    return _searchButton;
}

-(YDSegmentView *)segmentView{
    if (!_segmentView) {
        _segmentView = [[YDSegmentView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topView.frame), ZX_BOUNDS_WIDTH, ZX_BOUNDS_HEIGHT - 64 - self.topView.height)];
        _segmentView.delegate = self;
    }
    return _segmentView;
}

-(NSMutableArray *)dataModelArray{
    if(!_dataModelArray){
        _dataModelArray = [[NSMutableArray alloc]initWithCapacity:PAGESIZE];
    }
    return _dataModelArray;
}

-(NSMutableArray *)tempArray{
    if (!_tempArray) {
        _tempArray = [[NSMutableArray alloc]initWithCapacity:5];
    }
    return _tempArray;
}

#pragma mark - dealloc
-(void)dealloc{
    NSLog(@"%s",__func__);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
