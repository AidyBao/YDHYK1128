//
//  YDSearchViewController.m
//  ydhyk
//
//  Created by 120v on 2016/10/31.
//  Copyright © 2016年 120v. All rights reserved.
//

#import "YDSearchViewController.h"
#import "YDListTableViewCell.h"
/** 模型*/
#import "YDSearchModel.h"
/** FMDB工具*/
#import "LKDBTool.h"
/** 分类*/
#import "NSString+Category.h"
/** 加入会员*/
#import "HJoinLeadViewController.h"
/** 地图*/
#import "YDNearbyRootViewController.h"

#import "HQRScanViewController.h"
#import "YDHYK-Swift.h"

/** 搜索Cell*/
static NSString * const searchCell = @"searchCell";

@interface YDSearchViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,YDListTableViewCellDelegate>
/**  顶部搜索 */
@property (nonatomic, strong) UITextField *searchField;
/**  tableView */
@property (nonatomic, strong) UITableView *tableView;
/**  搜索无结果 */
@property (nonatomic, strong) UILabel *noResult;
/** 数据模型数组 */
@property (nonatomic, strong) NSMutableArray *searchArray;
/** 保存在本地的所有数组 */
@property (nonatomic, strong) NSArray *allArray;

@end

@implementation YDSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor zx_assistColor];
    
    //获取Documents路径
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *path = [paths objectAtIndex:0];
//    NSLog(@"path:%@", path);
    //取出保存在本地的所有数据
    [self queryAllDataFromLocalCache];
    
    //设置navigationItem
    [self setupNavigationView];
    
    //tableView
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor zx_assistColor];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YDListTableViewCell class]) bundle:nil] forCellReuseIdentifier:searchCell];
    //添加搜索无结果的情况
    [self.view addSubview:self.noResult];
    [self.noResult setHidden:YES];
    
    //手势
    UIGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureAction:)];
    [self.tableView addGestureRecognizer:tapGesture];
}

#pragma mark - 取出保存在本地的所有数据
-(void)queryAllDataFromLocalCache{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        self.allArray = [YDSearchModel findAll];
    });
}

#pragma mark - 设置navigationItem
-(void)setupNavigationView{
    //占位按钮：使searchBar居中
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.size = CGSizeMake(0, 0);
    [leftBtn setTitle:@"" forState:UIControlStateNormal];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    //取消
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.size = CGSizeMake(40, 40);
    rightBtn.backgroundColor = [UIColor clearColor];
    [rightBtn setTitle:@"取消" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(cancelButton:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    UIBarButtonItem *rightSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    rightSpace.width = -7;
    self.navigationItem.rightBarButtonItems = @[rightSpace,rightItem];
    
    //搜索
    self.searchField.frame = CGRectMake(0, 0, ZX_BOUNDS_WIDTH - 20, 35);
    self.navigationItem.titleView = self.searchField;
}

#pragma mark - 取消
-(void)cancelButton:(UIButton *)sender{
    [self.searchField resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -YDListTableViewCellDelegate
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

#pragma mark 电话
-(void)didListViewTelephoneButton:(UIButton *)sender withModel:(YDSearchModel *)model{
    if (model.tel.length) {
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",model.tel];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str] options:@{UIApplicationOpenURLOptionUniversalLinksOnly:@""} completionHandler:^(BOOL success) {
        }];
    }else{
        [ZXHUD MBShowFailureInView:self.view text:@"获取电话失败" delay:1.2];
        return;
    }
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [_searchField becomeFirstResponder];
    //处理搜索显示
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:_searchField];
    
    [textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.searchField resignFirstResponder];
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UITextFieldTextDidChangeNotification object:_searchField];
    [_searchField resignFirstResponder];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([[[textField textInputMode] primaryLanguage] isEqualToString:@"emoji"] || ![[textField textInputMode] primaryLanguage]){
        return NO;
    }
    return YES;
}

#pragma mark - 模糊搜索(中文或者字符)
-(void)textFieldDidChange:(UITextField *)textField{
    //1.取值,并去除空字符
    NSString *str=textField.text;
    
    //2.去除Emoji
    NSString *keyString = [str removedEmojiString];
    
    if (keyString.length) {
        //3.中文/字母/数字判断
        BOOL isLetter = [NSString judegeCheseOrChart:keyString];
        
        //4.数据库查找
        if (isLetter) {//字母搜索
            [self queryWithEnlishCondition:keyString];
        }else{//中文搜索
            [self queryWithChineseCondition:keyString];
        }
    }else{
        [self.searchArray removeAllObjects];
        [self.noResult setHidden:NO];
        [self.tableView reloadData];
    }
}


#pragma mark - 本地数据查询
#pragma mark 中文模糊查询
- (void)queryWithChineseCondition:(NSString *)condition{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        //自动生成SQL语句
        //LKDBSQLState *sql = [[LKDBSQLState alloc] object:[YDSearchModel class] type:WHERE key:@"name" opt:@"LIKE" value:condition];
        //self.searchArray = [YDSearchModel findByCriteria:[sql sqlOptionStr]];
        
        //自定义SQL语句
        [self.searchArray removeAllObjects];
        
        if (condition.length) {
            NSString *sql = [NSString stringWithFormat:@"WHERE name LIKE '%%%@%%' OR address LIKE '%%%@%%';",condition,condition];
            [self.searchArray addObjectsFromArray:[YDSearchModel findByCriteria:sql]];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (self.searchArray.count) {
                    [self.noResult setHidden:YES];
                }else{
                    [self.noResult setHidden:NO];
                }
                [self.tableView reloadData];
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.noResult setHidden:NO];
                [self.tableView reloadData];
            });
        }
    });
}

#pragma mark 英文字母模糊查询
- (void)queryWithEnlishCondition:(NSString *)condition{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self.searchArray removeAllObjects];
        if (condition.length) {
            //1.遍历需要搜索的所有内容
            for (YDSearchModel *model in self.allArray) {
                NSString *nameStr = model.name;
                NSString *addressStr = model.address;
                 //2.把所有的搜索结果转成成拼音
                NSString *namePinYin = [NSString transformToPinyin:nameStr];
                NSString *addressPinYin = [NSString transformToPinyin:addressStr];
                if ([namePinYin rangeOfString:condition options:NSCaseInsensitiveSearch].length >0 || [addressPinYin rangeOfString:condition options:NSCaseInsensitiveSearch].length >0) {
                    if (self.searchArray.count) {
                        //去重,如果不已经存在则加入数组
                        if (![self.searchArray containsObject:model]) {
                            [self.searchArray addObject:model];
                        }
                    }else{
                        [self.searchArray addObject:model];
                    }
                }
            }
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (self.searchArray.count) {
                    [self.noResult setHidden:YES];
                }else{
                    [self.noResult setHidden:NO];
                }
                [self.tableView reloadData];
            });
            
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.noResult setHidden:NO];
                [self.tableView reloadData];
            });
        }
    });
}

#pragma mark - UITabelViewDelegate/DataSoureDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.searchArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 143;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YDListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:searchCell forIndexPath:indexPath];
    cell.delegate = self;
    cell.dataModel = [self.searchArray objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - action
- (void)tapGestureAction:(UITapGestureRecognizer *)tap{
    [self.searchField endEditing:YES];
    [self.searchField resignFirstResponder];
}

#pragma mark - lazy
- (UITextField *)searchField{
    if (_searchField == nil) {
        _searchField = [[UITextField alloc]init];
        _searchField.tintColor = [UIColor blueColor];
        _searchField.delegate = self;
        _searchField.leftViewMode =  UITextFieldViewModeAlways;
        _searchField.borderStyle = UITextBorderStyleRoundedRect;
        _searchField.backgroundColor = [UIColor whiteColor];
        _searchField.clearButtonMode = UITextFieldViewModeWhileEditing;
        UIImage *searchImg = [UIImage imageNamed:@"icon-search"];
        UIImageView *leftImgV = [[UIImageView alloc]initWithImage:searchImg];
        leftImgV.frame = CGRectMake(40, 0, searchImg.size.width+10, searchImg.size.height);
        leftImgV.contentMode = UIViewContentModeRight;
        _searchField.leftView =  leftImgV;
        _searchField.font = [UIFont zx_titleFontWithSize:15.0];
        _searchField.textColor = [UIColor zx_textColor];
        _searchField.placeholder = @"搜索药店、医馆";
        _searchField.returnKeyType = UIReturnKeyDone;
        _searchField.enablesReturnKeyAutomatically = YES;//设置无文本为灰色
        [_searchField becomeFirstResponder];
    }
    return _searchField;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ZX_BOUNDS_WIDTH, ZX_BOUNDS_HEIGHT - 64) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

-(UILabel *)noResult{
    if (!_noResult) {
        _noResult = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, 80, 21)];
        _noResult.centerX = self.view.centerX;
        _noResult.font = [UIFont zx_bodyFontWithSize:15];
        _noResult.text = @"无结果";
        _noResult.textAlignment = NSTextAlignmentCenter;
        _noResult.textColor = [UIColor zx_sub2TextColor];
    }
    return _noResult;
}

-(NSArray *)allArray{
    if (!_allArray) {
        _allArray = [NSArray array];
    }
    return _allArray;
}

-(NSMutableArray *)searchArray{
    if (!_searchArray) {
        _searchArray = [[NSMutableArray alloc]init];
    }
    return _searchArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
