//
//  YDAllAddressView.m
//  ydhyk
//
//  Created by 120v on 2016/11/14.
//  Copyright © 2016年 120v. All rights reserved.
//

#import "YDAllAddressView.h"

@interface YDAllAddressView()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic,strong) UIView *backView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIButton *cancelButton;
@property (nonatomic,strong) UIButton *confirmButton;
@property (nonatomic,strong) UIView *geliView;
@property (nonatomic,strong) UIPickerView *pickerView;

@property (nonatomic,strong) NSArray *AllArray; //取出所有数据(json类型，在plist里面)
@property (nonatomic,strong) NSMutableArray *provinceArray; //装省份数据
@property (nonatomic,strong) NSMutableArray *cityArray;     //装城市数据
@property (nonatomic,strong) NSMutableArray *disArray;      //装区（县）的数组

@property (nonatomic,assign) NSInteger proIndex;     //选择省份的索引
@property (nonatomic,assign) NSInteger cityIndex;    //选择城市的索引
@property (nonatomic,assign) NSInteger distrIndex;    //选择区（县）的索引

@end

@implementation YDAllAddressView

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
    self.frame = [UIScreen mainScreen].bounds;
    self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.2];
    
    CATransition *animation = [CATransition animation];
    animation.duration = 0.3f;   //时间间隔
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.fillMode = kCAFillModeForwards;
    animation.type = kCATransitionMoveIn;         //动画效果
    animation.subtype = kCATransitionFromTop;   //动画方向
    [self.backView.layer addAnimation:animation forKey:@"animation"];
    
    self.alpha = 0.0f;
    [UIView beginAnimations:@"fadeIn" context:nil];   //淡入
    [self addSubview:self.backView];
    [UIView setAnimationDuration:0.3];
    self.alpha = 1.0f;
    [UIView commitAnimations];
    
    //    [self addSubview:self.backView];
    
    [self.backView addSubview:self.cancelButton];
    
    [self.backView addSubview:self.titleLabel];
    
    [self.backView addSubview:self.confirmButton];
    
    [self.backView addSubview:self.geliView];
    
    [self.backView addSubview:self.pickerView];
    //数据
    [self loadData];
    
}


-(void)loadData{
    for (NSDictionary *dic in self.AllArray) {
        [self.provinceArray addObject:[[dic allKeys] firstObject]];
    }
    if (!self.provinceArray.count) {
        NSLog(@"没有城市相关数据");
    }
    for (NSDictionary *dic in self.AllArray) {
        if ([dic objectForKey:self.provinceArray[self.proIndex]]) {
            //1.市
            self.cityArray = [NSMutableArray arrayWithArray:[[dic objectForKey:self.provinceArray[self.proIndex]] allKeys]];
            [self.pickerView reloadComponent:1];
            [self.pickerView selectRow:0 inComponent:1 animated:YES];
            
            //2.区
            self.disArray = [NSMutableArray arrayWithArray:[[dic objectForKey:self.provinceArray[self.proIndex]] objectForKey:self.cityArray[0]]];
            [self.pickerView reloadComponent:2];
            [self.pickerView selectRow:0 inComponent:2 animated:YES];
        }
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.backView.frame = CGRectMake(0, ZX_BOUNDS_HEIGHT - 202, ZX_BOUNDS_WIDTH, 202);
    
    self.cancelButton.frame = CGRectMake(10, 0, 50, 40);
    [self.cancelButton setTitleColor:[UIColor zx_tintColor] forState:UIControlStateNormal];
    self.cancelButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelButton addTarget:self action:@selector(cancelButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.titleLabel.width = 80.0;
    self.titleLabel.height = 40.0;
    self.titleLabel.centerX = self.centerX;
    self.titleLabel.y = 0;
    self.titleLabel.text = @"所在地区";
    self.titleLabel.textColor = [UIColor zx_sub2TextColor];
    
    self.confirmButton.frame = CGRectMake(ZX_BOUNDS_WIDTH - 60, 0, 50, 40);
    [self.confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    [self.confirmButton setTitleColor:[UIColor zx_tintColor] forState:UIControlStateNormal];
    self.confirmButton.titleLabel.textAlignment = NSTextAlignmentRight;
    [self.confirmButton addTarget:self action:@selector(confirmButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.geliView.frame = CGRectMake(0, CGRectGetMaxY(self.cancelButton.frame), ZX_BOUNDS_WIDTH, 1);
    
    self.pickerView.frame = CGRectMake(0, CGRectGetMaxY(self.geliView.frame), ZX_BOUNDS_WIDTH, self.backView.height - self.geliView.y);

}
#pragma mark - 取消
-(void)cancelButtonClick:(UIButton *)sender{
    [self dissmisFromSuperview];
}

#pragma mark - 确定
-(void)confirmButtonClick:(UIButton *)sender{
    __weak typeof(self) weakSelf = self;
    if (self.selectBlock) {
        self.selectBlock(weakSelf.provinceArray[weakSelf.proIndex],weakSelf.cityArray[weakSelf.cityIndex],weakSelf.disArray[weakSelf.distrIndex]);
    }
    [self dissmisFromSuperview];
}


#pragma mark - UIPickerViewDelegate
//自定义每个pickerView的label
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *pickerLabel = [UILabel new];
    pickerLabel.numberOfLines = 0;
    pickerLabel.textAlignment = NSTextAlignmentCenter;
    [pickerLabel setFont:[UIFont systemFontOfSize:16.0]];
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (component == 0) {
        self.proIndex = row;
        self.cityIndex = 0;
        self.distrIndex = 0;
        for (NSDictionary *dic in self.AllArray) {
            if ([dic objectForKey:self.provinceArray[self.proIndex]]) {
                self.cityArray = [NSMutableArray arrayWithArray:[[dic objectForKey:self.provinceArray[self.proIndex]] allKeys]];
                [self.pickerView reloadComponent:1];
                [pickerView selectRow:0 inComponent:1 animated:YES];
                
                self.disArray = [NSMutableArray arrayWithArray:[[dic objectForKey:self.provinceArray[self.proIndex]] objectForKey:self.cityArray[0]]];
                [self.pickerView reloadComponent:2];
                [self.pickerView selectRow:0 inComponent:2 animated:YES];
            }
        }
    }
    if (component == 1) {
        self.cityIndex = row;
        self.distrIndex = 0;
        for (NSDictionary *dic in self.AllArray) {
            if ([dic objectForKey:self.provinceArray[self.proIndex]]) {
                self.disArray = [[dic objectForKey:self.provinceArray[self.proIndex]] objectForKey:self.cityArray[self.cityIndex]];
                [self.pickerView reloadComponent:2];
                [self.pickerView selectRow:0 inComponent:2 animated:YES];
            }
        }
    }
    if (component == 2) {
        self.distrIndex = row;
    }
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0) {
        return self.provinceArray.count;
    }else if (component == 1){
        return self.cityArray.count;
    }else if (component == 2){
        return self.disArray.count;
    }
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == 0) {
        return [self.provinceArray objectAtIndex:row];
    }else if (component == 1){
        return [self.cityArray objectAtIndex:row];
    }else if (component == 2){
        return [self.disArray objectAtIndex:row];
    }
    return nil;
}

#pragma mark - 默认地址
-(void)setDefaultAddress:(NSString *)defaultAddress{
    
    //1.赋值
    _defaultAddress = defaultAddress;
    
    //2.按照“-”截取字符串
    NSArray *aArray = [defaultAddress componentsSeparatedByString:@"-"];
    NSString *province = [aArray objectAtIndex:0];
    NSString *city = [aArray objectAtIndex:1];
    NSString *area = [aArray objectAtIndex:2];
    
    //3.置空
    if (defaultAddress) {
        self.cityArray = nil;
        self.disArray = nil;
    }
    
    //4.
    __block NSInteger provinceIdx = 0;
    __weak typeof(self) weakSelf = self;
    
    //5.查找
    //查找省
    if (province) {
        __block NSString *provinceStr = nil;
        [self.provinceArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            provinceStr = obj;
            if ([provinceStr isEqualToString:province]) {
                *stop = true;
                //保存省份索引
                provinceIdx = idx;
                //选中指定行
                [weakSelf.pickerView reloadComponent:0];
                [weakSelf.pickerView selectRow:idx inComponent:0 animated:YES];
                //查找城市数据
                NSDictionary *dic = self.AllArray[idx];
                NSArray *array = [dic objectForKey:province];
                [self.cityArray addObjectsFromArray:array];
                }
        }];
    }

    //查找市
    if (city) {
        __block NSString *cityStr = nil;
        [self.cityArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            cityStr = obj;
            if ([cityStr isEqualToString:city]) {
                *stop = true;
                //选中指定行
                [weakSelf.pickerView reloadComponent:1];
                [weakSelf.pickerView selectRow:idx inComponent:1 animated:YES];
                //查找区域数据
                NSDictionary *dic = weakSelf.AllArray[provinceIdx];
                NSDictionary *tempDic = [dic objectForKey:province];
                [self.disArray addObjectsFromArray:tempDic[city]];
            }
        }];
    }
    
    //查找区
    if (area) {
        __block NSString *areaStr = nil;
        [self.disArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            areaStr = obj;
            if ([areaStr isEqualToString:[aArray objectAtIndex:2]]) {
                *stop = true;
                //选中指定行
                [weakSelf.pickerView reloadComponent:2];
                [weakSelf.pickerView selectRow:idx inComponent:2 animated:YES];
            }
        }];
    }
}
#pragma mark - Show
-(void)show{
    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:self];
}

#pragma mark - touchesBegan
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point = [[touches anyObject] locationInView:self];
    if (!CGRectContainsPoint(self.backView.frame, point)) {
        [self dissmisFromSuperview];
    }
}

-(void)dissmisFromSuperview{
    
    CATransition *animation = [CATransition animation];
    animation.duration = 0.3f;   //时间间隔
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.fillMode = kCAFillModeRemoved;
    animation.type = kCATransitionReveal;         //动画效果
    animation.subtype = kCATransitionFromBottom;   //动画方向
    [self.backView.layer addAnimation:animation forKey:@"animation"];
    
    [UIView beginAnimations:@"fadeOut" context:nil];   //淡出
    [UIView setAnimationDuration:0.3];
    self.backView.alpha = 0.0f;
    self.alpha = 0.0f;
    [UIView commitAnimations];
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
    }
    return _cancelButton;
}
-(UIButton *)confirmButton{
    if (!_confirmButton) {
        _confirmButton = [[UIButton alloc]init];
    }
    return _confirmButton;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
    }
    return _titleLabel;
}

-(UIView *)geliView{
    if (!_geliView) {
        _geliView = [[UIView alloc]init];
        _geliView.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.2];
    }
    return _geliView;
}

-(UIPickerView *)pickerView{
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc]init];
        _pickerView.delegate = self;
        _pickerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _pickerView.showsSelectionIndicator = YES;
    }
    return _pickerView;
}

-(NSArray *)AllArray{
    if (!_AllArray) {
        _AllArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Address" ofType:@"plist"]];
    }
    return _AllArray;
}

-(NSMutableArray *)provinceArray{
    if (!_provinceArray) {
        _provinceArray = [NSMutableArray array];
    }
    return _provinceArray;
}
-(NSMutableArray *)cityArray{
    if (!_cityArray) {
        _cityArray = [NSMutableArray array];
    }
    return _cityArray;
}
-(NSMutableArray *)disArray{
    if (!_disArray) {
        _disArray = [NSMutableArray array];
    }
    return _disArray;
}

@end
