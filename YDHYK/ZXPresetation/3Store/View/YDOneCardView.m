//
//  YDOneCardView.m
//  ydhyk
//
//  Created by 120v on 2016/11/1.
//  Copyright © 2016年 120v. All rights reserved.
//

#import "YDOneCardView.h"
#import "YDOneCardTableViewCell.h"

static NSString *const oneCardCell = @"oneCardCell";

@interface YDOneCardView()<UITableViewDataSource,UITableViewDelegate,YDOneCardTableViewCellDelegate>
/** tableView*/
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIButton *button;
@end

@implementation YDOneCardView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.3f];
        
        //tableView
        [self addSubview:self.tableView];
        self.tableView.showsVerticalScrollIndicator = NO;
        self.tableView.backgroundColor = [UIColor whiteColor];
        self.tableView.layer.cornerRadius = 10.0;
        self.tableView.layer.masksToBounds = YES;
        
        //
        [self addSubview:self.button];
        [self.button setBackgroundImage:[UIImage imageNamed:@"prompt"] forState:UIControlStateNormal];
        [self.button addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    //tableView
    self.tableView.frame = CGRectMake(10, 70, self.width-20, 141);
    
    //
    self.button.width = 234.0;
    self.button.height = 42.0;
    self.button.x = (ZX_BOUNDS_WIDTH - self.button.width)/2;
    self.button.y = CGRectGetMaxY(self.tableView.frame) + 10;
}

#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 139 + 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YDOneCardTableViewCell *rootCell = [tableView dequeueReusableCellWithIdentifier:oneCardCell forIndexPath:indexPath];
    rootCell.selectionStyle = UITableViewCellSelectionStyleNone;
    rootCell.delegate = self;
    if (self.dataArray.count) {
        rootCell.model = [self.dataArray objectAtIndex:indexPath.row];
    }
    return rootCell;
}

-(void)setDataArray:(NSMutableArray *)dataArray{
    _dataArray = dataArray;
    [self.tableView reloadData];
}

#pragma mark - 点击会员
-(void)btnAction{
    [self saveFirstClick:TRUE];
    [self removeFromSuperview];
}

#pragma mark - YDOneCardTableViewCellDelegate
-(void)didSelectedOneCardViewWithBuyButton:(UIButton *)sender{
    [self saveFirstClick:TRUE];
    [self removeFromSuperview];
}

-(void)didSelectedOneCardViewWithTelphoneButton:(UIButton *)sender{
    [self saveFirstClick:TRUE];
    [self removeFromSuperview];
}

-(void)didOneCardViewWithTouchBegin:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self saveFirstClick:TRUE];
    [self removeFromSuperview];
}

-(void)saveFirstClick:(BOOL)isClick{
    [[NSUserDefaults standardUserDefaults] setBool:isClick forKey:@"oneCardIsClick"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self saveFirstClick:TRUE];
    [self removeFromSuperview];
}

#pragma mark - lazy
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YDOneCardTableViewCell class]) bundle:nil] forCellReuseIdentifier:oneCardCell];
    }
    return _tableView;
}

-(UIButton *)button{
    if (!_button) {
        _button = [[UIButton alloc]init];
    }
    return _button;
}


@end
