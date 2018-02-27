//
//  HNewReportRecordViewController.m
//  YDHYK
//
//  Created by screson on 2016/12/12.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "HNewReportRecordViewController.h"
#import "HReportModelViewController.h"
#import "HAddCheckItemViewController.h"
#import "HCheckItemInputViewController.h"
#import "HItemInpuTableViewCell.h"
#import "HItemInputHeader.h"
#import "ZXSexAgeInputTableCell.h"
#import "ZXReportAnalyseViewModel.h"
#import "HReportResultViewController.h"
#import "HCheckItemTableCell.h"
#import "HReportListViewController.h"
#import <MJPhotoBrowser/MJPhotoBrowser.h>

@interface HNewReportRecordViewController ()<UITableViewDelegate,UITableViewDataSource,HItemInputHeaderDelegate,ZXSexAgeInputTableCellDelegate,HItemInputTableViewCellDelegate>
{
    NSString * iSex;// 0Female 1Male
    NSString * iAge;//
    NSMutableArray<HItemModel *> * arrAddedItemList;
    NSArray<ZXCheckItemListModel *> * searchList;
    NSInteger selectedIndex;
    BOOL resetUI;
}
@property (weak, nonatomic) IBOutlet UILabel *lbNoSearchResult;
//顶部提示文字
@property (weak, nonatomic) IBOutlet UIView *vTips;
@property (weak, nonatomic) IBOutlet UILabel *lbTopTipsText;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *vTopHeight;

//顶部图片、Button 父视图View
@property (weak, nonatomic) IBOutlet UIView *topBackView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topBackViewHeight; //0 110
@property (weak, nonatomic) IBOutlet UIImageView *imgReportList;
@property (weak, nonatomic) IBOutlet UIButton *btnBrowerImage;
@property (weak, nonatomic) IBOutlet UITableView *tblReportItems;
@property (weak, nonatomic) IBOutlet ZXTintButton *btnStartAnalyse;
@property (weak, nonatomic) IBOutlet UILabel *lbClearText;
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tblTopOffset;//键盘隐藏 110 键盘显示 0
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tblBottomOffset;

//检索出来的检查项
@property (weak, nonatomic) IBOutlet UITableView *tblSearchItemResult;
@property (weak, nonatomic) IBOutlet UIView *searchResultBackView;

@property (weak, nonatomic) IBOutlet UIView *maskView;

@end

@implementation HNewReportRecordViewController

- (void)viewDidAppear:(BOOL)animated{
    if (self.vTopHeight.constant < 30) {
        self.vTopHeight.constant = 30;
        [UIView animateWithDuration:0.35 animations:^{
            [self.view layoutIfNeeded];
        }];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    arrAddedItemList = [NSMutableArray array];
    searchList = [NSArray array];
    selectedIndex = -1;
    self.fd_interactivePopDisabled = true;
    [self setTitle:@"化验单分析"];
//    [self zx_addLeftBarItemsWithTexts:@[@"取消"] font:nil color:nil];
    [self zx_addLeftBarItemsWithImageNames:@[@"zxnavback1"] originalColor:true];
    [self zx_addRightBarItemsWithTexts:@[@"模板"] font:nil color:nil];
    [self.view setBackgroundColor:[UIColor zx_assistColor]];
    
    [self.vTips setBackgroundColor:[UIColor zx_assistColor]];
    [self.lbTopTipsText setFont:[UIFont zx_bodyFontWithSize:12]];
    [self.lbTopTipsText setTextColor:[UIColor zx_tintColor]];
    [self.lbTopTipsText setText:@"分析结果仅作参考,具体请以医师分析为准。"];
    
    [self.btnBrowerImage setBackgroundColor:ZXCLEAR_COLOR];
    [self.btnBrowerImage.layer setBorderColor:ZXWHITE_COLOR.CGColor];
    [self.btnBrowerImage.layer setBorderWidth:1.0];
    [self.btnBrowerImage.layer setMasksToBounds:true];
    [self.btnBrowerImage.layer setCornerRadius:5.0];
    [self.btnBrowerImage.titleLabel setFont:[UIFont zx_titleFontWithSize:13]];
    
    [self.lbClearText setTextColor:[UIColor zx_textColor]];
    [self.lbClearText setFont:[UIFont zx_titleFontWithSize:11]];
    
    //新增录入的检查项
    [self.tblReportItems setBackgroundColor:[UIColor zx_assistColor]];
    [self.tblReportItems setSeparatorColor:[UIColor zx_separatorColor]];
    [self.tblReportItems setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [self.tblReportItems registerNib:[UINib nibWithNibName:@"HItemInpuTableViewCell" bundle:nil] forCellReuseIdentifier:@"HItemInpuTableViewCell"];
    [self.tblReportItems registerNib:[UINib nibWithNibName:@"ZXSexAgeInputTableCell" bundle:nil] forCellReuseIdentifier:@"ZXSexAgeInputTableCell"];
    //检索检查项

    [self.tblSearchItemResult setBackgroundColor:[UIColor whiteColor]];
    [self.tblSearchItemResult setSeparatorColor:[UIColor zx_assistColor]];
    [self.tblSearchItemResult registerNib:[UINib nibWithNibName:@"HCheckItemTableCell" bundle:nil] forCellReuseIdentifier:@"HCheckItemTableCell"];
    
    [self.lbNoSearchResult setFont:[UIFont zx_titleFontWithSize:30]];
    [self.lbNoSearchResult setTextColor:[UIColor zx_assistColor]];
    [self.lbNoSearchResult setHidden:true];
    
//    [self.maskView setBackgroundColor:ZXRGBA_COLOR(255, 255, 255, 0.1)];
    [self.maskView setBackgroundColor:ZXRGBA_COLOR(0, 0, 0, 0.1)];
    [self.maskView setHidden:true];
    [self.maskView setAlpha:0];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(maskViewTapAction)];
    [self.maskView addGestureRecognizer:tap];
    
    [self.searchResultBackView setClipsToBounds:true];
    [self.searchResultBackView setHidden:true];
    [self.searchResultBackView setAlpha:0];
    
    [self.imgReportList setBackgroundColor:[UIColor zx_separatorColor]];
    [self.imgReportList setClipsToBounds:true];
    [self.imgReportList setContentMode:UIViewContentModeScaleAspectFill];
    
    if (!_imageUrl) {
        //[_btnBrowerImage setTitle:@"无图片" forState:UIControlStateNormal];
        [self.topBackViewHeight setConstant:0];
        
    }else{
        [self.topBackViewHeight setConstant:110];
        [self.imgReportList setImage:_imageReport];
    }
    
    [self zx_addKeyboardNotification];
    [self loadCheckItemListShowHUD:true];
}

- (void)loadCheckItemListShowHUD:(BOOL)bShow{
    if (bShow) {
        [ZXHUD MBShowLoadingInView:self.view text:ZX_LOADING_TEXT delay:0];
    }
    [ZXReportAnalyseViewModel getAllCheckItemListWithMemberId:[[ZXGlobalData shareInstance] memberId] token:[[ZXGlobalData shareInstance] userToken] completion:^(NSArray<ZXCheckItemListModel *> *list, NSInteger status, BOOL success, NSString *errorMsg) {
        if (bShow) {
            [ZXHUD MBHideForView:self.view animate:true];
        }
        if (success) {
            if (status == ZXAPI_SUCCESS) {
                if (!list || list.count == 0) {
                    [ZXAlertUtils showAAlertMessage:@"无可用的检查项数据,无法添加化验单" title:@"提示" buttonTexts:@[@"稍后再试",@"重试"] buttonAction:^(int buttonIndex) {
                        if (buttonIndex == 0) {
                            [self.navigationController popViewControllerAnimated:true];
                        }else{
                            [self loadCheckItemListShowHUD:true];
                        }
                    }];
                }
            }else{
                if (status != ZXAPI_LOGIN_INVALID) {
                    [ZXAlertUtils showAAlertMessage:errorMsg title:@"提示" buttonText:@"确定" buttonAction:^{
                        [self.navigationController popViewControllerAnimated:true];
                    }];
                }else{
                    [self.navigationController popViewControllerAnimated:true];
                }
            }
        }else{
            if (status == ZXAPI_HTTP_TIME_OUT) {
                [ZXAlertUtils showAAlertMessage:errorMsg title:@"提示" buttonText:@"确定" buttonAction:^{
                    [self.navigationController popViewControllerAnimated:true];
                }];
            }else{
                [ZXEmptyView showNetworkErrorInView:self.view heightFix:0 refreshAction:^{
                    [ZXEmptyView dismissInView:self.view];
                    [self loadCheckItemListShowHUD:true];
                }];
            }
        }
    }];
}

//MARK: - 取消
- (void)zx_leftBarButtonActionsIndex:(NSInteger)index{
    id txtSearch = [self.view viewWithTag:ZX_ITEMSEARCH_TXT_TAG];
    id txtAge    = [self.view viewWithTag:ZX_ITEMAGE_TXT_TAG];
    if ([txtSearch isKindOfClass:[UITextField class]] &&
        [txtSearch isFirstResponder]) {
        [self.view endEditing:true];
    }else if([txtAge isKindOfClass:[UITextField class]] &&
             [txtAge isFirstResponder]){
        [self.view endEditing:true];
    }else{
        [self.view endEditing:true];
        
        if (![ZXStringUtils isTextEmpty:iSex] || ![ZXStringUtils isTextEmpty:iAge] ||
            [arrAddedItemList count] != 0) {
            [ZXAlertUtils showAAlertMessage:@"是否放弃编辑?" title:@"提示" buttonTexts:@[@"放弃",@"继续编辑"] buttonAction:^(int buttonIndex) {
                if (buttonIndex == 0) {
                    [self.navigationController popViewControllerAnimated:true];
                }
            }];
        }else{
            [self.navigationController popViewControllerAnimated:true];
        }
    }
}
//MARK: - 模板
- (void)zx_rightBarButtonActionsIndex:(NSInteger)index{
    [self.view endEditing:true];
    HReportModelViewController * reportModel = [[HReportModelViewController alloc] init];
    reportModel.checkEnd = ^(NSArray <ZXCheckItemListModel *> *list){
        if (arrAddedItemList && arrAddedItemList.count) {
            [ZXAlertUtils showAAlertMessage:@"是否使用模板检查项数据替换当前检查项?" title:@"提示" buttonTexts:@[@"替换",@"取消"] buttonAction:^(int buttonIndex) {
                if (buttonIndex == 0) {
                    [arrAddedItemList removeAllObjects];
                    [list enumerateObjectsUsingBlock:^(ZXCheckItemListModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        if (![self hasAddedItem:obj]) {
                            [arrAddedItemList insertObject:[HItemModel mj_objectWithKeyValues:[obj mj_keyValues]] atIndex:0];
                        }
                    }];
                    [_tblReportItems reloadData];
                }
            }];
        }else{
            [arrAddedItemList removeAllObjects];
            [list enumerateObjectsUsingBlock:^(ZXCheckItemListModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (![self hasAddedItem:obj]) {
                    [arrAddedItemList insertObject:[HItemModel mj_objectWithKeyValues:[obj mj_keyValues]] atIndex:0];
                }
            }];
            [_tblReportItems reloadData];
        }
    };
    [self.navigationController pushViewController:reportModel animated:true];
}

//MARK: - 查看图片
- (IBAction)btnBrowerSourceImage:(id)sender {
    if (_imageReport) {
        MJPhotoBrowser *brower = [[MJPhotoBrowser alloc] init];
        NSMutableArray *photos = [NSMutableArray array];
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.image = _imageReport;
        [photos addObject:photo];
        brower.showSaveBtn = false;
        brower.photos = photos;
        [brower show];
    }
}

//MARK: - 分析记录列表
- (IBAction)reportListAction:(id)sender {
    HReportListViewController * reportListVC = [[HReportListViewController alloc] init];
    [self.navigationController pushViewController:reportListVC animated:true];
}

//MARK: - 清空数据
- (IBAction)clearAction:(id)sender {
    [self.view endEditing:true];
    [ZXAlertUtils showAAlertMessage:@"确定清空所有数据?" title:@"提示" buttonTexts:@[@"清空",@"取消"] buttonAction:^(int buttonIndex) {
        if (buttonIndex == 0) {
            [self clearAllInput];
        }
    }];
}
- (void)clearAllInput{
    [arrAddedItemList removeAllObjects];
    iAge = nil;
    iSex = nil;
    [_tblReportItems reloadData];
}
//MARK: - 开始分析
- (IBAction)startAnalyse:(id)sender {
    if ([ZXStringUtils isTextEmpty:iSex]) {
        [ZXHUD MBShowFailureInView:self.view text:@"请选择性别" delay:1.5];
        return;
    }
    
    if ([ZXStringUtils isTextEmpty:iAge]) {
        [ZXHUD MBShowFailureInView:self.view text:@"请填写年龄" delay:1.5];
        return;
    }
    if (!arrAddedItemList || [arrAddedItemList count] == 0) {
        [ZXHUD MBShowFailureInView:self.view text:@"请添加至少一个检查项" delay:1.5];
        return;
    }
    if (![self isItemListInputRight]) {
        [ZXHUD MBShowFailureInView:self.view text:@"请将检查项数据录入完整" delay:1.5];
        return;
    }
    [ZXHUD MBShowLoadingInView:self.view text:@"数据分析中..." delay:0];
    [ZXReportAnalyseViewModel addAnalyseReportWithMemberId:[[ZXGlobalData shareInstance] memberId] age:iAge sex:iSex itemList:arrAddedItemList imgUrl:nil token:[[ZXGlobalData shareInstance] userToken] completion:^(NSString * reportId,BOOL isAbnormal, NSInteger status, BOOL success, NSString *errorMsg) {
        [ZXHUD MBHideForView:self.view animate:true];
        if (status == ZXAPI_SUCCESS) {//上传完成 调整到查看分析结果分析结果详情
            [self clearAllInput];
            HReportResultViewController * resultVC = [[HReportResultViewController alloc] init];
            resultVC.isAbnormal = isAbnormal;
            resultVC.reportId = reportId;
            resultVC.pushFromNewReportVC = true;
            [self.navigationController pushViewController:resultVC animated:true];
        }else{
            if (status != ZXAPI_LOGIN_INVALID) {
                [ZXHUD MBShowFailureInView:self.view text:errorMsg delay:1.5];
            }
        }
    }];
}

#pragma mark - TableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.tblReportItems) {
        if (section == 0) {
            return 1;
        }else{
            if (arrAddedItemList && arrAddedItemList.count) {
                return arrAddedItemList.count;
            }
        }
        return 0;
    }else if (tableView == self.tblSearchItemResult){
        if (searchList && searchList.count) {
            return searchList.count;
        }
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView == self.tblReportItems) {
        return 2;
    }else if (tableView == self.tblSearchItemResult){
        if (searchList && searchList.count) {
            [self.lbNoSearchResult setHidden:true];
            return 1;
        }else{
            [self.lbNoSearchResult setHidden:false];
            return 0;
        }
        
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.tblReportItems) {
        if (indexPath.section == 0) {//年龄 性别
            ZXSexAgeInputTableCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ZXSexAgeInputTableCell" forIndexPath:indexPath];
            [cell reloadSex:iSex age:iAge];
            cell.delegate = self;
            return cell;
        }else{
            HItemInpuTableViewCell * inputCell = [tableView dequeueReusableCellWithIdentifier:@"HItemInpuTableViewCell" forIndexPath:indexPath];
            [inputCell setDelegate:self];
            [inputCell reloadItemData:arrAddedItemList[indexPath.row]];
            return inputCell;
        }
    }else if (tableView == self.tblSearchItemResult){
        HCheckItemTableCell * searchResultCell = [tableView dequeueReusableCellWithIdentifier:@"HCheckItemTableCell" forIndexPath:indexPath];
        ZXCheckItemListModel * model = searchList[indexPath.row];
        searchResultCell.lbItemName.text = model.itemName;
        return searchResultCell;
    }
    return nil;
}

#pragma mark - TableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.tblSearchItemResult) {
        if (selectedIndex == indexPath.row) {
            return;
        }
        selectedIndex = indexPath.row;
        ZXCheckItemListModel * item = searchList[indexPath.row];
        UITextField * txtS = [self.view viewWithTag:ZX_ITEMSEARCH_TXT_TAG];
        if ([txtS isKindOfClass:[UITextField class]]) {
            [txtS setText:item.itemName];
        }
        UIButton * btnAdd = [self.view viewWithTag:ZX_ITEMSEARCH_ADDBUTTON_TAG];
        if ([btnAdd isKindOfClass:[UIButton class]]) {
            [btnAdd setEnabled:true];
        }
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 44;
    }else{
        return 75;
    }
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 50;
    }
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 1) {
        return 0.1;
    }
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        //搜索 添加 检查项
        HItemInputHeader * header = [[HItemInputHeader alloc] initWithFrame:CGRectMake(0, 0, ZX_BOUNDS_WIDTH, 50)];
        header.delegate = self;
        return header;
    }
    return [[UIView alloc] initWithFrame:CGRectZero];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc] initWithFrame:CGRectZero];
}

#pragma mark - 年龄 性别 输入代理
- (void)sexAgeInputTableCellDidSexSelected:(NSInteger)sex sexTitle:(NSString *)sexTitle cell:(ZXSexAgeInputTableCell *)cell{
    iSex = [NSString stringWithFormat:@"%@",@(sex)];
}

- (void)sexAgeInputTableCellDidAgeInputed:(NSString *)age textField:(UITextField *)textF cell:(ZXSexAgeInputTableCell *)cell{
    iAge = age;
}

#pragma mark - 检查项
//MARK: 删除
- (void)itemInputCellDeleteAction:(HItemInpuTableViewCell *)cell{
    NSIndexPath * indexPath = [self.tblReportItems indexPathForCell:cell];
    [ZXAlertUtils showAAlertMessage:@"删除该条检查项?" title:@"提示" buttonTexts:@[@"删除",@"取消"] buttonAction:^(int buttonIndex) {
        if (buttonIndex == 0) {
            [arrAddedItemList removeObjectAtIndex:indexPath.row];
            [self.tblReportItems deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    }];
}


#pragma mark - 检查项搜索
//MARK: - 选择检查项
- (void)inputHeaderSelectItemAction:(HItemInputHeader *)header{
    [self.view endEditing:true];
    HAddCheckItemViewController * selectVC = [[HAddCheckItemViewController alloc] init];
    selectVC.checkEnd = ^(NSArray <ZXCheckItemListModel *> *list){
        [list enumerateObjectsUsingBlock:^(ZXCheckItemListModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (![self hasAddedItem:obj]) {
                [arrAddedItemList insertObject:[HItemModel mj_objectWithKeyValues:[obj mj_keyValues]] atIndex:0];
            }
        }];
        [_tblReportItems reloadData];
    };
    [self.navigationController pushViewController:selectVC animated:true];
}

//MARK: 添加按钮
- (void)inputHeaderDidAddedItem:(id)item{
    if (searchList && searchList.count && selectedIndex != -1) {
        ZXCheckItemListModel * obj = searchList[selectedIndex];
        if (![self hasAddedItem:obj]) {
            [self.view endEditing:true];
            [arrAddedItemList insertObject:[HItemModel mj_objectWithKeyValues:[obj mj_keyValues]] atIndex:0];
            [_tblReportItems reloadData];
            selectedIndex = -1;
            searchList = nil;
            [_tblSearchItemResult reloadData];
        }else{
            [_tblSearchItemResult deselectRowAtIndexPath:[NSIndexPath indexPathForRow:selectedIndex inSection:0] animated:true];
            selectedIndex = -1;
            [ZXHUD MBShowFailureInView:self.tblSearchItemResult text:@"该检查项目已存在" delay:1.5];
        }
    }
}
//MARK: 搜索检查项结果变化
- (void)inputHeaderSearchResultChangeWithItemList:(NSArray<ZXCheckItemListModel *> *)list{
    searchList = list;
    [self.tblSearchItemResult reloadData];
    if (!list || list.count == 0) {
        selectedIndex = -1;
    }
}

#pragma mark - 判断重复的检查项
- (BOOL)hasAddedItem:(ZXCheckItemListModel *)item{
    __block BOOL bAdded = false;
    if (arrAddedItemList && arrAddedItemList.count) {
        [arrAddedItemList enumerateObjectsUsingBlock:^(HItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.itemId isEqualToString:item.itemId]) {
                bAdded = true;
                *stop = true;
            }
        }];
    }
    return bAdded;
}


#pragma mark - KeyBoard
#define ZX_HIDE_OFFSET 54
- (void)zx_keyboardWillShowTimeInteval:(double)dt notice:(NSNotification *)notice{
    id txtSearch = [self.view viewWithTag:ZX_ITEMSEARCH_TXT_TAG];
    id txtAge    = [self.view viewWithTag:ZX_ITEMAGE_TXT_TAG];
    [self.tblReportItems setScrollEnabled:false];
    if ([txtAge isKindOfClass:[UITextField class]] && [txtAge isFirstResponder]) {
        [self setMaskViewShow:true animationInterval:dt];
    }else if ([txtSearch isKindOfClass:[UITextField class]] && [txtSearch isFirstResponder]){
//        self.tblTopOffset.constant = 0;//调整ItemTable位置 置顶
        [UIView animateWithDuration:dt animations:^{
            [self.view layoutIfNeeded];
            [self.tblReportItems setContentOffset:CGPointMake(0, ZX_HIDE_OFFSET)];
        }];
        [self setSearchTableShow:true animationInterval:dt];
    }else{//录入数值时
//        self.tblTopOffset.constant = 0;//调整ItemTable位置 置顶
        [UIView animateWithDuration:dt animations:^{
            [self.view layoutIfNeeded];
            [self.tblReportItems setContentOffset:CGPointMake(0, ZX_HIDE_OFFSET)];
        }];
    }
    
//    if ([txtSearch isKindOfClass:[UITextField class]] && [txtSearch isFirstResponder]) {
//    }
//    if (arrAddedItemList && arrAddedItemList.count) {
//        [self.tblReportItems scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1] atScrollPosition:UITableViewScrollPositionTop animated:true];
//    }else{
//        [self.tblReportItems scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:true];
//    }
}

- (void)zx_keyboardWillHideTimeInteval:(double)dt notice:(NSNotification *)notice{
//    self.tblTopOffset.constant = 110;
    self.tblBottomOffset.constant = 0;
    [self.tblReportItems setScrollEnabled:true];
    [UIView animateWithDuration:dt animations:^{
        [self.view layoutIfNeeded];
    }];
    [self setMaskViewShow:false animationInterval:dt];
    [self setSearchTableShow:false animationInterval:dt];
}

- (void)zx_keyboardWillChangeFrameBeginRect:(CGRect)beginRect endRect:(CGRect)endRect timeInterval:(double)dt notice:(NSNotification *)notice{
    self.tblBottomOffset.constant = endRect.size.height-50;//距离底部菜单的位置
    [UIView animateWithDuration:dt animations:^{
        [self.view layoutIfNeeded];
    }];
}

#pragma mark - 检查项是否填写完整
- (BOOL)isItemListInputRight{
    if (arrAddedItemList && arrAddedItemList.count) {
        BOOL inputRight = true;
        for (HItemModel * item in arrAddedItemList) {
            switch (item.referenceValueTypeKey) {
                case HItemResultTypeValue:
                {
                    if (!item.resultValue || !item.referenceMinValue) {
                        inputRight = false;
                    }
                }
                    break;
                case HItemResultTypeYinYang:
                {
                    if (!item.referenceNegativePositive || !item.resultNegativePositive) {
                        inputRight = false;
                    }
                }
                    break;
                case HItemResultTypePlusSub:
                {
                    if (!item.referenceAddSub || !item.resultAddSub) {
                        inputRight = false;
                    }
                }
                    break;
                default:
                    break;
            }
            if (!inputRight) {
                break;
            }
        }
        return inputRight;
    }
    return false;
}

- (void)dealloc{
    [self zx_removeKeyboardNotification];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 切换控制

- (void)setSearchTableShow:(BOOL)show animationInterval:(NSTimeInterval)interval{
    if (show == !self.searchResultBackView.hidden) {
        return;
    }
    if (show) {
        [self.maskView setHidden:true];
        [self.searchResultBackView setHidden:false];
        [UIView animateWithDuration:interval animations:^{
            [self.searchResultBackView setAlpha:1.0];
        } completion:^(BOOL finished) {
        }];
    }else{
        [UIView animateWithDuration:interval animations:^{
            [self.searchResultBackView setAlpha:0];
        } completion:^(BOOL finished) {
            [self.searchResultBackView setHidden:true];
        }];
    }
}

- (void)setMaskViewShow:(BOOL)show animationInterval:(NSTimeInterval)interval{
    if (show == !self.maskView.hidden) {
        return;
    }
    if (show) {
        [self.searchResultBackView setHidden:true];
        [self.maskView setHidden:false];
        [UIView animateWithDuration:interval animations:^{
            [self.maskView setAlpha:1.0];
        } completion:^(BOOL finished) {
        }];
    }else{
        [UIView animateWithDuration:interval animations:^{
            [self.maskView setAlpha:0];
        } completion:^(BOOL finished) {
            [self.maskView setHidden:true];
        }];
    }
}

- (void)maskViewTapAction{
    [self.view endEditing:true];
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
