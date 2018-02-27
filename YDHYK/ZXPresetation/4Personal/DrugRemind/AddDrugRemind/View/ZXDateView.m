//
//  ZXDateView.m
//  YDHYK
//
//  Created by 120v on 2016/12/14.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "ZXDateView.h"

@interface ZXDateView()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIPickerView *datePicker;
@property (nonatomic, strong) UIView *sLine;
@property (nonatomic, strong) UIButton *confirmButton;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) NSMutableArray *hoursArray;
@property (nonatomic, strong) NSMutableArray *minuteArray;
@property (nonatomic, copy) NSString *hourStr;
@property (nonatomic, copy) NSString *minuteStr;

@end

@implementation ZXDateView

-(instancetype)init{
    if ([super init]) {
        [self initWithUI];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initWithUI];
    }
    return self;
}

-(void)initWithUI{
    self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];
    self.frame = [UIScreen mainScreen].bounds;
    
    [self addSubview:self.backView];
    
    [self.backView addSubview:self.cancelButton];
    
    [self.backView addSubview:self.titleLabel];
    
    [self.backView addSubview:self.confirmButton];
    
    [self.backView addSubview:self.sLine];
    
    [self.backView addSubview:self.datePicker];
    [self.datePicker selectRow:8 inComponent:0 animated:YES];
    [self.datePicker selectRow:6 inComponent:1 animated:YES];

}


-(void)layoutSubviews{
    self.backView.frame = CGRectMake(0, ZX_BOUNDS_HEIGHT - 202, ZX_BOUNDS_WIDTH, 202);
    
    self.cancelButton.frame = CGRectMake(10, 0, 50, 40);
    self.cancelButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.cancelButton addTarget:self action:@selector(cancelButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.titleLabel.width = 100.0f;
    self.titleLabel.height = 40.0f;
    self.titleLabel.centerX = self.centerX;
    self.titleLabel.y = 0;
    self.titleLabel.textColor = [UIColor zx_sub2TextColor];
    
    self.confirmButton.frame = CGRectMake(ZX_BOUNDS_WIDTH - 60, 0, 50, 40);
    [self.confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    [self.confirmButton setTitleColor:[UIColor zx_tintColor] forState:UIControlStateNormal];
    self.confirmButton.titleLabel.textAlignment = NSTextAlignmentRight;
    [self.confirmButton addTarget:self action:@selector(confirmButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.sLine.frame = CGRectMake(0, CGRectGetMaxY(self.cancelButton.frame), ZX_BOUNDS_WIDTH, 1);
    
    self.datePicker.frame = CGRectMake(0, CGRectGetMaxY(self.sLine.frame), ZX_BOUNDS_WIDTH, self.backView.height - self.sLine.y);
}

-(void)setModel:(YDAddDrugTimeModel *)model{
    _model = model;
    NSString *tempHour = [model.drugTime substringWithRange:NSMakeRange(11, 2)];
    NSString *tempMinute = [model.drugTime substringWithRange:NSMakeRange(14, 2)];
    
    __weak typeof(self) weakSelf = self;
    __block NSString *hourStr = nil;
    [self.hoursArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        hourStr = obj;
        if ([hourStr isEqualToString:tempHour]) {
            [weakSelf.datePicker selectRow:idx inComponent:0 animated:YES];
            weakSelf.hourStr = [weakSelf.hoursArray objectAtIndex:idx];
            *stop = true;
        }
    }];
    
    __block NSString *minStr = nil;
    [self.minuteArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        minStr = obj;
        if ([minStr isEqualToString:tempMinute]) {
            [weakSelf.datePicker selectRow:idx inComponent:1 animated:YES];
            weakSelf.minuteStr = [weakSelf.minuteArray objectAtIndex:idx];
            *stop = true;
        }
    }];
    
}

-(void)setTitle:(NSString *)title{
    _title = title;
    self.titleLabel.text = title;
}

-(void)setCancelStr:(NSString *)cancelStr{
    _cancelStr = cancelStr;
    [self.cancelButton setTitle:cancelStr forState:UIControlStateNormal];
}

-(void)setCanCelType:(CanCelType)canCelType{
    _canCelType = canCelType;
    if (self.canCelType == Cancel) {
        [self.cancelButton setTitleColor:[UIColor zx_tintColor] forState:UIControlStateNormal];
    }else{
        [self.cancelButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }
}

#pragma mark - 取消
-(void)cancelButtonClick:(UIButton *)sender{
    if (self.canCelType == Delete && _ZXDeleteDateBlock) {
        _ZXDeleteDateBlock(_model);
    }
    [self removeFromSuperview];
}

#pragma mark - 确定
-(void)confirmButtonClick:(UIButton *)sender{
    
    //设置默认选中时间为08:30
    if (self.hourStr.length == 0) {
        self.hourStr = [NSString stringWithFormat:@"%@",@"08"];
    }

    if (self.minuteStr == 0) {
        self.minuteStr = [NSString stringWithFormat:@"%@",@"30"];
    }
    
    NSString *currentDate = [ZXDateUtils getCurrentDateisChinese:false];
    NSString *dateStr = [NSString stringWithFormat:@"%@ %@:%@:%@",currentDate,self.hourStr,self.minuteStr,@"00"];
    if (self.ZXDateViewBlock) {
        self.ZXDateViewBlock(dateStr);
    }
    [self removeFromSuperview];
}

#pragma mark - UIPickerViewDetaSource
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    NSInteger rowNum = 0;
    
    switch (component) {
        case 0:
            rowNum = self.hoursArray.count;
            break;
        case 1:
            rowNum = self.minuteArray.count;
            break;
        default:
            break;
    }
    
    return rowNum;
}
- (CGSize)rowSizeForComponent:(NSInteger)component{
    CGSize rowSize = CGSizeMake(40, 21);
    return rowSize;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 34;
}

#pragma mark - UIPickerViewDelegate
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    [pickerView tintColorDidChange];
    switch (component) {
        case 0:
        {
            NSString *hourStr = [self.hoursArray objectAtIndex:row];
            return hourStr;
        }
            break;
        case 1:
        {
            NSString *minuteStr = [self.minuteArray objectAtIndex:row];
            return minuteStr;
        }
            break;
            
        default:
            break;
    }
    return nil;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *label = [[UILabel alloc] init];
    label.size = CGSizeMake(40, 21);
    label.backgroundColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:16.0];
    label.textColor = [UIColor zx_textColor];
    switch (component) {
        case 0:
        {
            NSString *hourStr = [self.hoursArray objectAtIndex:row];
            label.text = [NSString stringWithFormat:@"%@点",hourStr];
        }
            break;
        case 1:
        {
            NSString *minuteStr = [self.minuteArray objectAtIndex:row];
            label.text =[NSString stringWithFormat:@"%@分",minuteStr];
        }
            break;
            
        default:
            break;
    }
    
    return label;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    switch (component) {
        case 0:
            self.hourStr = [self.hoursArray objectAtIndex:row];
            break;
        case 1:
            self.minuteStr = [self.minuteArray objectAtIndex:row];
            break;
            
        default:
            break;
    }
}


#pragma mark - show
-(void)show{
    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:self];
}

#pragma mark - touchesBegan
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point = [[touches anyObject] locationInView:self];
    if (!CGRectContainsPoint(self.backView.frame, point)) {
        [self removeFromSuperview];
    }
}

#pragma mark - lazy
-(UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc]init];
        _backView.backgroundColor = [UIColor whiteColor];
    }
    return _backView;
}

-(UIButton *)cancelButton{
    if (!_cancelButton) {
        _cancelButton = [[UIButton alloc]init];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
    }
    return _cancelButton;
}
-(UIButton *)confirmButton{
    if (!_confirmButton) {
        _confirmButton = [[UIButton alloc]init];
        _confirmButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
    }
    return _confirmButton;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:16.0];
    }
    return _titleLabel;
}

-(UIView *)sLine{
    if (!_sLine) {
        _sLine = [[UIView alloc]init];
        _sLine.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.2];
    }
    return _sLine;
}

-(UIPickerView *)datePicker{
    if (!_datePicker) {
        _datePicker = [[UIPickerView alloc]init];
        _datePicker.backgroundColor=[UIColor whiteColor];
        _datePicker.delegate = self;
        _datePicker.dataSource = self;
    }
    return _datePicker;
}

-(NSMutableArray *)hoursArray{
    if (!_hoursArray) {
        _hoursArray = [[NSMutableArray alloc]initWithObjects:@"00",@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23", nil];
    }
    return _hoursArray;
}

-(NSMutableArray *)minuteArray{
    if (!_minuteArray) {
        _minuteArray = [[NSMutableArray alloc]initWithObjects:@"00",@"05",@"10",@"15",@"20",@"25",@"30",@"35",@"40",@"45",@"50",@"55", nil];
    }
    return _minuteArray;
}

-(void)removeSubviews:(UIButton *)sender{
    [self removeFromSuperview];
    
}


@end
