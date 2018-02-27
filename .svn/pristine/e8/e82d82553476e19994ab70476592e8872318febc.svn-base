//
//  YDHistoryDrugController.m
//  ydhyk
//
//  Created by screson on 2016/10/28.
//  Copyright © 2016年 120v. All rights reserved.
//

#import "YDHistoryDrugController.h"
#import "YDHistoryDrugDetailsCell.h"
#import "YDHistoryOrderModel.h"
#import "YDSubHistoryOrderModel.h"

@interface YDHistoryDrugController()

@property (nonatomic, strong) NSMutableArray *detailArray;

@end

@implementation YDHistoryDrugController
+(instancetype)instantiateFromStoryboard{
    return [[UIStoryboard storyboardWithName:@"DrugRemind" bundle:nil] instantiateViewControllerWithIdentifier:@"YDHistoryDrugController"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"从我的订单中添加";
    
    //取值
    [self getDetailOrderData];
    
    //
    self.tableView.backgroundColor = [UIColor zx_assistColor];
    [self.tableView setSeparatorColor:[UIColor zx_separatorColor]];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YDHistoryDrugDetailsCell class]) bundle:nil] forCellReuseIdentifier:[YDHistoryDrugDetailsCell reuseID]];
}

#pragma mark - 取值
-(void)getDetailOrderData{
    
//    [self.detailArray removeAllObjects];
    
    if (self.histOrderArray.count == 0 && [self.histOrderArray isKindOfClass:[NSNull class]]) {
        [ZXEmptyView showNoDataInView:self.view text1:@"没有数据" text2:nil heightFix:0];
    }else{
        [self.tableView reloadData];
    }
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.histOrderArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    YDHistoryOrderModel *mainModel = [self.histOrderArray objectAtIndex:section];
    NSMutableArray *tempArray = mainModel.orderDetailList;
    
    return tempArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YDHistoryDrugDetailsCell *cell=[tableView dequeueReusableCellWithIdentifier:[YDHistoryDrugDetailsCell reuseID] forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    YDHistoryOrderModel *mainModel = [self.histOrderArray objectAtIndex:indexPath.section];
    NSMutableArray *tempArray = mainModel.orderDetailList;
    YDSubHistoryOrderModel *model = [tempArray objectAtIndex:indexPath.row];
    
    if (model) {
        cell.model = model;
    }

    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ZX_BOUNDS_WIDTH, 44)];
    headerView.backgroundColor = [UIColor zx_assistColor];
    
    UILabel *sectionTitle = [[UILabel alloc]initWithFrame:CGRectMake(14, 0, ZX_BOUNDS_WIDTH - 2*14, 44)];
    sectionTitle.textColor = [UIColor zx_sub2TextColor];
    sectionTitle.font = [UIFont zx_bodyFontWithSize:15.0];
    [headerView addSubview:sectionTitle];
    
    YDHistoryOrderModel *mainModel = [self.histOrderArray objectAtIndex:section];
    if (mainModel.orderDateStr) {
        NSString *dateStr = [mainModel.orderDateStr substringWithRange:NSMakeRange(5, 5)];
        sectionTitle.text = [NSString stringWithFormat:@"%@ %@",dateStr,mainModel.drugstoreName];
    }
    return headerView;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //
    YDHistoryDrugDetailsCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
    if(newCell.accessoryType==UITableViewCellAccessoryNone){
        newCell.accessoryType=UITableViewCellAccessoryCheckmark;
        newCell.detailLabel.textColor= [UIColor zx_tintColor];
    }else{
        newCell.accessoryType=UITableViewCellAccessoryNone;
        newCell.detailLabel.textColor= [UIColor zx_textColor];
    }
    
    //回调
    YDHistoryOrderModel *model = [self.histOrderArray objectAtIndex:indexPath.section];
    NSArray *tempArray = model.orderDetailList;
    NSDictionary *tempDict = [tempArray objectAtIndex:indexPath.row];
    YDSubHistoryOrderModel *detailModel = [YDSubHistoryOrderModel mj_objectWithKeyValues:tempDict];
    if ([self.delegate respondsToSelector:@selector(didHistoryDrugDetailsCellWithModel:)]) {
        [self.delegate didHistoryDrugDetailsCellWithModel:detailModel];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    YDHistoryDrugDetailsCell*oldCell = [tableView cellForRowAtIndexPath:indexPath];
    if(oldCell.accessoryType==UITableViewCellAccessoryCheckmark){
        oldCell.accessoryType=UITableViewCellAccessoryNone;
        oldCell.detailLabel.textColor = [UIColor zx_textColor];
    }
}

#pragma mark - Getter
-(NSMutableArray *)detailArray{
    if (!_detailArray) {
        _detailArray = [[NSMutableArray alloc]initWithCapacity:10];
    }
    return _detailArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
