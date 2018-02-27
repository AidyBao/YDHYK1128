//
//  YDSixAgeView.m
//  ydhyk
//
//  Created by Aidy Bao on 2016/11/13.
//  Copyright © 2016年 120v. All rights reserved.
//

#import "YDSixAgeView.h"

#define cellHeight 40

static NSString *const SixAgeViewCell = @"SixAgeViewCell";

@interface YDSixAgeView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UIView *backView;

@property (nonatomic,strong) UITableView *tabelView;

@end

@implementation YDSixAgeView

-(instancetype)init{
    if ([super init]) {
        [self initWithUI];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initWithUI];
        
    }
    return self;
}

-(void)initWithUI{
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
    
    [self.tabelView registerClass:[UITableViewCell class] forCellReuseIdentifier:SixAgeViewCell];

}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.frame = [UIScreen mainScreen].bounds;
    
    self.backView.frame = self.bounds;

}

#pragma mark - Setter_刷新数据
-(void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    
    CGFloat tableViewH = cellHeight * (dataArray.count+1);
    self.tabelView.height = tableViewH;
    self.tabelView.y = ZX_BOUNDS_HEIGHT - self.tabelView.height;
    
    [self layoutIfNeeded];
    
    [self.tabelView reloadData];
}

-(void)setTitleStr:(NSString *)titleStr{
    _titleStr = titleStr;
    [self.tabelView reloadData];
}

-(void)setDefaultStr:(NSString *)defaultStr{
    _defaultStr = defaultStr;
    [self selectedDefaultRowIndexPathWith:defaultStr];
}

//-(void)setDefaultAgeGroup:(NSString *)defaultAgeGroup{
//    _defaultAgeGroup = defaultAgeGroup;
//    [self selectedDefaultRowIndexPathWith:defaultAgeGroup];
//}

#pragma mark 选中默认行
-(void)selectedDefaultRowIndexPathWith:(NSString *)defaultStr{
    __block NSString *tempStr = nil;
    __block typeof(self) blockSelf = self;
    [self.dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        tempStr = obj;
        if ([defaultStr isEqualToString:tempStr]) {
            *stop = TRUE;
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:idx inSection:0];
            [blockSelf.tabelView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
            
            UITableViewCell *newCell = [blockSelf.tabelView cellForRowAtIndexPath:indexPath];
            if(newCell.accessoryType==UITableViewCellAccessoryNone){
                newCell.accessoryType=UITableViewCellAccessoryCheckmark;
                newCell.textLabel.textColor=[UIColor zx_tintColor];
            }else{
                newCell.accessoryType=UITableViewCellAccessoryNone;
                newCell.textLabel.textColor=[UIColor zx_textColor];
            }
        }
    }];
}

#pragma mark UITabelViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return cellHeight;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return cellHeight;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SixAgeViewCell forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIView *geliView = [[UIView alloc]initWithFrame:CGRectMake(0, 39, ZX_BOUNDS_WIDTH, 1)];
    geliView.backgroundColor = [UIColor lightGrayColor];
    geliView.alpha = 0.2;
    [cell addSubview:geliView];
    
    cell.textLabel.text = [self.dataArray objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor zx_textColor];
    return cell;
}


-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ZX_BOUNDS_WIDTH, cellHeight)];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 0, headerView.width - 2*80, 39)];
    titleLabel.text = self.titleStr;
    titleLabel.textColor = [UIColor zx_sub2TextColor];
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
    //选购
    UITableViewCell*newCell = [tableView cellForRowAtIndexPath:indexPath];
    if(newCell.accessoryType==UITableViewCellAccessoryNone){
        newCell.accessoryType=UITableViewCellAccessoryCheckmark;
        newCell.textLabel.textColor=[UIColor zx_tintColor];
    }else{
        newCell.accessoryType=UITableViewCellAccessoryNone;
        newCell.textLabel.textColor=[UIColor zx_textColor];
    }
    
    //取值
    NSString *str = [self.dataArray objectAtIndex:indexPath.row];
    if ([self.delegate respondsToSelector:@selector(didSelectedCellIndexPathWithString:WithTag:)]) {
        [self.delegate didSelectedCellIndexPathWithString:str WithTag:self.tag];
    }
    
    [self dissmisFromSuperview];
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell*oldCell = [tableView cellForRowAtIndexPath:indexPath];
    if(oldCell.accessoryType==UITableViewCellAccessoryCheckmark){
        oldCell.accessoryType=UITableViewCellAccessoryNone;
        oldCell.textLabel.textColor = [UIColor zx_textColor];
    }
}

#pragma mark - Show
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
        _backView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
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

@end
