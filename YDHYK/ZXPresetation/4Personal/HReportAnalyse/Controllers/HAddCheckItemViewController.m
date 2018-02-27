//
//  HAddCheckItemViewController.m
//  YDHYK
//
//  Created by screson on 2016/12/12.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "HAddCheckItemViewController.h"
#import "HCheckItemTableCell.h"
#import "ZXReportAnalyseViewModel.h"

@interface HAddCheckItemViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray * arrSearchIndex;
}
@property (weak, nonatomic) IBOutlet UITableView *tblCheckItemList;

@end

@implementation HAddCheckItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view setBackgroundColor:[UIColor zx_assistColor]];
    arrSearchIndex = [NSMutableArray arrayWithCapacity:26];
    for (int i = 'A'; i < 'Z'; i++) {
        [arrSearchIndex addObject:[NSString stringWithUTF8String:(char *)&i]];
    }
    [self setTitle:@"添加检查项目"];
    [self zx_addRightBarItemsWithTexts:@[@"完成"] font:nil color:nil];
    [self zx_addLeftBarItemsWithTexts:@[@"关闭"] font:nil color:nil];
    [_tblCheckItemList setSeparatorColor:[UIColor zx_separatorColor]];
    [_tblCheckItemList registerNib:[UINib nibWithNibName:@"HCheckItemTableCell" bundle:nil] forCellReuseIdentifier:@"HCheckItemTableCell"];
    [_tblCheckItemList setAllowsMultipleSelection:true];
    [_tblCheckItemList setBackgroundColor:[UIColor zx_assistColor]];
    [_tblCheckItemList setSectionIndexColor:[UIColor zx_textColor]];
    [_tblCheckItemList setSectionIndexBackgroundColor:ZXCLEAR_COLOR];
    [_tblCheckItemList setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [_tblCheckItemList zx_addHeaderRefreshActionUseZXImage:true target:self action:@selector(refreshAction)];
    if (![ZXReportAnalyseViewModel checkItemList]) {
        [ZXAlertUtils showAAlertMessage:@"暂无检查项列表" title:@"提示" buttonText:@"确定" buttonAction:^{
            [self.navigationController popViewControllerAnimated:true];
        }];
    }
}

- (void)refreshAction{
    //前面已经获取过列表数据,这里只做刷新
    //刷新失败不改变原有数据
    [ZXReportAnalyseViewModel getAllCheckItemListWithMemberId:[[ZXGlobalData shareInstance] memberId] token:[[ZXGlobalData shareInstance] userToken] completion:^(NSArray<ZXCheckItemListModel *> *list, NSInteger status, BOOL success, NSString *errorMsg) {
        [_tblCheckItemList.mj_header endRefreshing];
        if (success) {
            if (status == ZXAPI_SUCCESS) {
                if (!list || list.count == 0) {
                    [ZXHUD MBShowFailureInView:self.view text:@"无可用的检查项数据,无法添加化验单" delay:1.5];
                }else{
                    [self.tblCheckItemList reloadData];
                }
            }else{
                [ZXHUD MBShowFailureInView:self.view text:errorMsg delay:1.5];
            }
        }else{
            [ZXHUD MBShowFailureInView:self.view text:errorMsg delay:1.5];
        }
    }];
}

- (void)zx_leftBarButtonActionsIndex:(NSInteger)index{
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:true];
    }else{
        [self dismissViewControllerAnimated:true completion:nil];
    }
}

- (void)zx_rightBarButtonActionsIndex:(NSInteger)index{
    NSArray<NSIndexPath *> * arrSelected = [self.tblCheckItemList indexPathsForSelectedRows];
    if (arrSelected && arrSelected.count) {
        NSMutableArray<ZXCheckItemListModel *> * arrItemList = [NSMutableArray array];
        [arrSelected enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [arrItemList addObject:[[ZXReportAnalyseViewModel checkItemList] objectAtIndex:obj.row]];
        }];
        if (_checkEnd) {
            _checkEnd(arrItemList);
        }
        [self.navigationController popViewControllerAnimated:true];
    }else{
        [ZXHUD MBShowFailureInView:self.view text:@"请选择要添加的检查项" delay:1.5];
    }
}

#pragma mark - TableView DataSource 

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return arrSearchIndex;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HCheckItemTableCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HCheckItemTableCell" forIndexPath:indexPath];
    ZXCheckItemListModel * model = [[ZXReportAnalyseViewModel checkItemList] objectAtIndex:indexPath.row];
    cell.lbItemName.text = model.itemName;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([ZXReportAnalyseViewModel checkItemList]) {
        return [[ZXReportAnalyseViewModel checkItemList] count];
    }
    return 0;
}


#pragma mark - TableView Delegate

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    NSInteger idx = [self getSortIndexByKey:title];
    if (idx != -1) {
        [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:idx inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:true];
    }
    return NSNotFound;
    //return 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)getSortIndexByKey:(NSString *)key{
    __block NSInteger index = -1;
    if (![ZXStringUtils isTextEmpty:key]) {
        
    }
    [[ZXReportAnalyseViewModel checkItemList] enumerateObjectsUsingBlock:^(ZXCheckItemListModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.pinyin hasPrefix:key]) {
            index = idx;
            *stop = true;
        }
    }];
    return index;
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
