//
//  YDDrugUnitsView.m
//  YDHYK
//
//  Created by 120v on 2016/12/15.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "YDPopoverView.h"
/** 药品单位模型*/
#import "YDDrugUnitsModel.h"

#define cellHeight 40

static NSString *const PopoverViewCell = @"PopoverViewCell";

@interface YDPopoverView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UIView *backView;
@property (nonatomic,strong) UITableView *tabelView;
@property (nonatomic,strong) NSMutableArray *dataArray;


@end

@implementation YDPopoverView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.backView];
        CATransition *animation = [CATransition animation];
        animation.duration = 0.3f;   //时间间隔
        animation.timingFunction = UIViewAnimationCurveEaseInOut;
        animation.fillMode = kCAFillModeForwards;
        animation.type = kCATransitionMoveIn;         //动画效果
        animation.subtype = kCATransitionFromTop;   //动画方向
        [self.tabelView.layer addAnimation:animation forKey:@"animation"];
        
        self.alpha = 0.0f;
        [UIView beginAnimations:@"fadeIn" context:nil];   //淡入
        [self.backView addSubview:self.tabelView];
        [UIView setAnimationDuration:0.3];
        self.alpha = 1.0f;
        [UIView commitAnimations];
        
        [self.tabelView registerClass:[UITableViewCell class] forCellReuseIdentifier:PopoverViewCell];
    }
    return self;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    self.backView.frame = self.bounds;
}


-(void)setType:(NSString *)type{
    _type = type;
    
    [self.dataArray removeAllObjects];
    
    switch (type.integerValue) {
        case DrugUnitsType:
            [self httpRequestForDrugUnitsAndDrugTimeWithType:[NSString stringWithFormat:@"%d",DrugUnitsType]];
            break;
        case DrugTimeType:
            [self httpRequestForDrugUnitsAndDrugTimeWithType:[NSString stringWithFormat:@"%d",DrugTimeType]];
            break;
        default:
            break;
    }
}

#pragma mark 获取用量单位
-(void)httpRequestForDrugUnitsAndDrugTimeWithType:(NSString *)type{
    NSMutableDictionary *dicPrames = [[NSMutableDictionary alloc]init];
    NSString *token = [[YDAPPManager shareManager] getUserToken];
    
    if (type) {
        [dicPrames setObject:type forKey:@"type"];
    }
    __weak typeof(self) weakSelf = self;
    [ZXNetworkEngine asycnRequestWithURL:ZXAPI_Address(ZXAPI_Get_DictList_URL) params:dicPrames token:token method:POST zxCompletion:^(id content, NSInteger status, BOOL success, NSString *errorMsg) {
        if (success) {
            if (status == ZXAPI_SUCCESS) {
                    id obj = content[@"data"];
                    if ([obj isKindOfClass:[NSArray class]]){
                        if (type.integerValue == DrugUnitsType) {
                            [weakSelf.dataArray addObjectsFromArray:[YDDrugUnitsModel mj_objectArrayWithKeyValuesArray:obj]];
                        }else if (type.integerValue == DrugTimeType){
                            [weakSelf.dataArray addObjectsFromArray:[YDDrugUnitsModel mj_objectArrayWithKeyValuesArray:obj]];
                        }
                    }
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    //重新计算tableView高度
                    CGFloat tableViewH = cellHeight * (weakSelf.dataArray.count+1);
                    self.tabelView.height = tableViewH;
                    self.tabelView.y = ZX_BOUNDS_HEIGHT - self.tabelView.height;
                     [self layoutIfNeeded];
                    
                    //
                    [weakSelf.tabelView reloadData];
                });
            }else{
                [ZXHUD MBShowFailureInView:[ZXRootViewControllers window] text:content[@"msg"] delay:1.2];
            }
        }else{
            [ZXHUD MBShowFailureInView:[ZXRootViewControllers window] text:errorMsg delay:1.2];
        }
    }];
}



#pragma mark UITabelViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PopoverViewCell forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
//        cell.accessoryType = UITableViewCellAccessoryNone;
//    }
    
    UIView *geliView = [[UIView alloc]initWithFrame:CGRectMake(0, 39, ZX_BOUNDS_WIDTH, 1)];
    geliView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [cell addSubview:geliView];
    YDDrugUnitsModel *model = [self.dataArray objectAtIndex:indexPath.row];
    cell.textLabel.text = model.value;
    cell.textLabel.textColor = [UIColor zx_textColor];
    return cell;
}


-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ZX_BOUNDS_WIDTH, 40)];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 0, headerView.width - 2*80, 39)];
    if (self.type.integerValue == DrugUnitsType) {
        titleLabel.text = @"选择用药单位";
    }else if (self.type.integerValue == DrugTimeType){
        titleLabel.text = @"选择用药周期";
    }
    
    titleLabel.textColor = [UIColor zx_tintColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:titleLabel];
    
    UIView *geliView = [[UIView alloc]init];
    geliView.backgroundColor = [UIColor lightGrayColor];
    geliView.alpha = 0.2;
    geliView.width = ZX_BOUNDS_WIDTH;
    geliView.height = 1.0;
    geliView.x = 0;
    geliView.y = CGRectGetMaxY(titleLabel.frame);
    [headerView addSubview:geliView];
    
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //
    UITableViewCell*newCell = [tableView cellForRowAtIndexPath:indexPath];
    if(newCell.accessoryType==UITableViewCellAccessoryNone){
        newCell.accessoryType=UITableViewCellAccessoryCheckmark;
        newCell.textLabel.textColor=[UIColor zx_tintColor];
    }else{
        newCell.accessoryType=UITableViewCellAccessoryNone;
        newCell.textLabel.textColor=[UIColor zx_textColor];
    }
    
    //取值
    YDDrugUnitsModel *model = [self.dataArray objectAtIndex:indexPath.row];
    if ([self.delegate respondsToSelector:@selector(didPopoverViewWithKey:andWithValue:WithTag:)]) {
        [self.delegate didPopoverViewWithKey:model.key andWithValue:model.value WithTag:self.tag];
    }
//    [self removeFromSuperview];
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell*oldCell = [tableView cellForRowAtIndexPath:indexPath];
    if(oldCell.accessoryType==UITableViewCellAccessoryCheckmark){
        oldCell.accessoryType=UITableViewCellAccessoryNone;
        oldCell.textLabel.textColor = [UIColor zx_textColor];
    }
}

#pragma mark - show
-(void)show{
    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:self];
}

#pragma mark - touchesBegan
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dissmisFromSuperview];
}

-(void)dissmisFromSuperview{
    
    CATransition *animation = [CATransition animation];
    animation.duration = 0.3f;   //时间间隔
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.fillMode = kCAFillModeRemoved;
    animation.type = kCATransitionReveal;         //动画效果
    animation.subtype = kCATransitionFromBottom;   //动画方向
    [self.tabelView.layer addAnimation:animation forKey:@"animation"];
    
    [UIView beginAnimations:@"fadeOut" context:nil];   //淡出
    [UIView setAnimationDuration:0.3];
    self.tabelView.alpha = 0.0f;
    self.alpha = 0.0f;
    [UIView commitAnimations];
}


#pragma mark - lazy
-(UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc]initWithFrame:self.bounds];
        _backView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.2];
    }
    return _backView;
}

-(UITableView *)tabelView{
    if (!_tabelView) {
        _tabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, ZX_BOUNDS_HEIGHT - 240, ZX_BOUNDS_WIDTH, 240) style:UITableViewStylePlain];
        _tabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tabelView.delegate = self;
        _tabelView.dataSource = self;
        _tabelView.scrollEnabled = NO;
    }
    return _tabelView;
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}


@end
