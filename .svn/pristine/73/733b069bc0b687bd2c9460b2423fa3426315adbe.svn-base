//
//  YDSegmentView.m
//  ydhyk
//
//  Created by 120v on 2016/10/27.
//  Copyright © 2016年 120v. All rights reserved.
//

#import "YDSegmentView.h"

static NSString *const segmentCell = @"segmentCell";

@interface YDSegmentView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *dataArray;
@property (nonatomic,strong) NSIndexPath *selectedIndexPath;
@property (nonatomic,assign) CGFloat tableViewHeight;

@end

@implementation YDSegmentView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.frame = frame;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3f];

        //
        self.tableView.backgroundColor = [UIColor whiteColor];
        
        CATransition *animation = [CATransition animation];
        animation.duration = 0.3f;   //时间间隔
        animation.timingFunction = UIViewAnimationCurveEaseInOut;
        animation.fillMode = kCAFillModeForwards;
        animation.type = kCATransitionMoveIn;         //动画效果
        animation.subtype = kCATransitionFromBottom;   //动画方向
        [self.tableView.layer addAnimation:animation forKey:@"animation"];
        
        self.alpha = 0.0f;
        [UIView beginAnimations:@"fadeIn" context:nil];   //淡入
        [self addSubview:self.tableView];
        [UIView setAnimationDuration:0.3];
        self.alpha = 1.0f;
        [UIView commitAnimations];
    }
    return self;
}

-(void)layoutSubviews{
    self.tableView.frame = CGRectMake(0, 0, self.frame.size.width, self.tableViewHeight);
}

#pragma mark - Setter
-(void)setButtonType:(NSString *)buttonType{
    _buttonType = buttonType;
    if ([buttonType isEqualToString:TOPALL]) {
        self.tableViewHeight = 150;
        self.dataArray = @[@"全部",@"中医馆",@"药店"];
    }
    if ([buttonType isEqualToString:TOPREGION]) {
        self.tableViewHeight = 250;
        self.dataArray = @[@"范围不限",@"5百米内",@"1千米内",@"3千米内",@"5千米内"];
    }
    if ([buttonType isEqualToString:TOPDISTANCE]) {
        self.tableViewHeight = 100;
        self.dataArray = @[@"距离优先",@"会员优先"];
    }
    [self layoutSubviews];
    [self.tableView reloadData];

}

-(void)setDefaultStr:(NSString *)defaultStr{
    _defaultStr = defaultStr;
    [self selectedDefaultRowIndexPathWith:defaultStr];
   
}

#pragma mark 选中默认行
-(void)selectedDefaultRowIndexPathWith:(NSString *)defaultStr{
    __block NSString *tempStr = nil;
    __block typeof(self) blockSelf = self;
    [self.dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        tempStr = obj;
        if ([defaultStr isEqualToString:tempStr]) {
            *stop = TRUE;
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:idx inSection:0];
            [blockSelf.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
            
            UITableViewCell *newCell = [blockSelf.tableView cellForRowAtIndexPath:indexPath];
            [newCell setSelectionStyle:UITableViewCellSelectionStyleNone];
            if(newCell.accessoryType==UITableViewCellAccessoryNone){
                newCell.accessoryType=UITableViewCellAccessoryCheckmark;
                newCell.textLabel.textColor=[UIColor zx_textColor];
                newCell.tintColor = [UIColor zx_textColor];
            }else{
                newCell.accessoryType=UITableViewCellAccessoryNone;
                newCell.textLabel.textColor=[UIColor zx_sub2TextColor];
            }
        }
    }];
}

#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selectedIndexPath = nil;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:segmentCell forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:segmentCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryNone;
    if ([self.selectedIndexPath isEqual:indexPath]){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
         cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.textLabel.text =[NSString stringWithFormat:@"  %@",self.dataArray[indexPath.row]];
    cell.textLabel.textColor = [UIColor zx_sub2TextColor];
    cell.tintColor = [UIColor zx_textColor];
    [cell.textLabel setFont:[UIFont zx_bodyFontWithSize:14.0]];
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.selectedIndexPath) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:self.selectedIndexPath];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.textColor = [UIColor zx_textColor];
        cell.tintColor = [UIColor zx_textColor];

    }
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    cell.textLabel.textColor = [UIColor zx_sub2TextColor];
    self.selectedIndexPath = indexPath;
    
    if ([self.delegate respondsToSelector:@selector(didSelectedCellWithDataArray:withIndex:withButtonType:)]) {
        [self.delegate didSelectedCellWithDataArray:self.dataArray withIndex:indexPath.row withButtonType:self.buttonType];
    }
    
    [self dissmisFromSuperview];
}

#pragma mark - 移除
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if ([self.delegate respondsToSelector:@selector(didRemoveSuperView)]) {
        [self.delegate didRemoveSuperView];
    }
    [self dissmisFromSuperview];
}

#define mark - 消失动画
-(void)dissmisFromSuperview{
    
    CATransition *animation = [CATransition animation];
    animation.duration = 0.3f;   //时间间隔
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.fillMode = kCAFillModeRemoved;
    animation.type = kCATransitionReveal;         //动画效果
    animation.subtype = kCATransitionFromTop;   //动画方向
    [self.tableView.layer addAnimation:animation forKey:@"animation"];
    
    [UIView beginAnimations:@"fadeOut" context:nil];   //淡出
    [UIView setAnimationDuration:0.3];
    self.tableView.alpha = 0.0f;
    self.alpha = 0.0f;
    [UIView commitAnimations];
}

#pragma mark - lazy
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:segmentCell];
    }
    return _tableView;
}

-(NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSArray alloc]init];
    }
    return _dataArray;
}


@end
