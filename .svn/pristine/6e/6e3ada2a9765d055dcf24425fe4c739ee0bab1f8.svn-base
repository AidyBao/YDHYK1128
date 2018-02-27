//
//  YDMedicineDetailView.m
//  ydhyk
//
//  Created by 120v on 2016/10/28.
//  Copyright © 2016年 120v. All rights reserved.
//

#import "YDMedicineDetailView.h"
#import "YDMedicineDetailTableViewCell.h"


static NSString *const medicineDetailCell = @"medicineDetailCell";
@interface YDMedicineDetailView()<UITableViewDelegate,UITableViewDataSource>

/** 背景*/
@property (nonatomic,strong) UIView *backgroundView;
/** tableView*/
@property (nonatomic,strong) UITableView *tableView;
/** 清楚按钮*/
@property (nonatomic,strong) UIButton *clearButton;
/** 背景图片*/
@property (nonatomic,strong) UIImageView *backImgView;
/** 缓存高度*/
@property (nonatomic, strong) NSMutableDictionary *heightAtIndexPath;
/** 现在服药*/
@property (nonatomic, strong) UIButton *takeMedicineButton;
/** 稍后提醒*/
@property (nonatomic, strong) UIButton *remindButton;
/** 数据源*/
@property (nonatomic, strong) NSMutableArray *dataArray;
/** 数据源*/
@property (nonatomic, copy) NSString *drugTime;

@end

@implementation YDMedicineDetailView

-(void)awakeFromNib{
    [super awakeFromNib];
    [self initWithUI];
}

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
    //背景
    [self addSubview:self.backgroundView];
    //tableView
    [self addSubview:self.tableView];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.layer.cornerRadius = 10.0;
    self.tableView.layer.masksToBounds = YES;
    [self.tableView addSubview:self.backImgView];
    //清楚
    [self addSubview:self.clearButton];
}

-(void)setIsTakeMedicine:(BOOL)isTakeMedicine{
    if (!isTakeMedicine) {//服药提醒
        //现在服药
        [self addSubview:self.takeMedicineButton];
        
        //售后提醒
        [self addSubview:self.remindButton];
        
        //隐藏clearButton
        self.clearButton.hidden = YES;
    }
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    //tableView
    self.tableView.x = 28;
    self.tableView.y = 107;
    self.tableView.width= (ZX_BOUNDS_WIDTH - self.tableView.x *2);
    self.tableView.height = self.height - self.tableView.y - 200;
    
    //背景图片
    UIImage *image = [UIImage imageNamed:@"clock"];
    self.backImgView.image = image;
    self.backImgView.width = image.size.width;
    self.backImgView.height = image.size.height;
    self.backImgView.x = self.tableView.width - self.backImgView.width*0.9;
    self.backImgView.y = self.tableView.height - self.backImgView.height*0.9;
    
    //删除按钮
    UIImage *clearImage = [UIImage imageNamed:@"icon-close"];
    self.clearButton.width = clearImage.size.width;
    self.clearButton.height = clearImage.size.height;
    self.clearButton.centerX = self.centerX;
    self.clearButton.y = CGRectGetMaxY(self.tableView.frame)+75;
    [self.clearButton setImage:clearImage forState:UIControlStateNormal];
    [self.clearButton addTarget:self action:@selector(clearButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //现在服药
    self.takeMedicineButton.x = CGRectGetMinX(self.tableView.frame);
    self.takeMedicineButton.y = CGRectGetMaxY(self.tableView.frame)+ 15;
    self.takeMedicineButton.width = (ZX_BOUNDS_WIDTH - self.takeMedicineButton.x * 2 -20)/2;
    self.takeMedicineButton.height = 49.0;
    self.takeMedicineButton.backgroundColor = [UIColor whiteColor];
    self.takeMedicineButton.layer.cornerRadius = 5.0;
    self.takeMedicineButton.layer.masksToBounds = YES;
    [self.takeMedicineButton setTitle:@"现在服药" forState:UIControlStateNormal];
    [self.takeMedicineButton setTitleColor:ZXRGB_COLOR(59, 135, 239) forState:UIControlStateNormal];
    UIImage *normalImage = [self createImageWithColor:ZXRGB_COLOR(255, 255, 255)];
    UIImage *selectedImage = [self createImageWithColor:ZXRGB_COLOR(239, 239, 239)];
    [self.takeMedicineButton setBackgroundImage:normalImage forState:UIControlStateNormal];
    [self.takeMedicineButton setBackgroundImage:selectedImage forState:UIControlStateSelected];
    [self.takeMedicineButton addTarget:self action:@selector(takeMedicineButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //稍后提醒
    self.remindButton.x = CGRectGetMaxX(self.takeMedicineButton.frame) + 20;
    self.remindButton.y = CGRectGetMaxY(self.tableView.frame)+ 15;
    self.remindButton.width = self.takeMedicineButton.width;
    self.remindButton.height = 49.0;
    self.remindButton.backgroundColor = [UIColor whiteColor];
    self.remindButton.layer.cornerRadius = 5.0;
    self.remindButton.layer.masksToBounds = YES;
    [self.remindButton setTitle:@"稍后提醒" forState:UIControlStateNormal];
    [self.remindButton setTitleColor:ZXRGB_COLOR(255, 255, 255) forState:UIControlStateNormal];
    UIImage *remindNormal = [self createImageWithColor:ZXRGB_COLOR(103, 103, 103)];
    UIImage *remindSelected = [self createImageWithColor:ZXRGB_COLOR(74, 74, 74)];
    [self.remindButton setBackgroundImage:remindNormal forState:UIControlStateNormal];
    [self.remindButton setBackgroundImage:remindSelected forState:UIControlStateSelected];
    [self.remindButton addTarget:self action:@selector(remindButtonClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (UIImage *)createImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}


#pragma mark - SetdataArray
-(void)setDataDict:(NSDictionary *)dataDict{
    _dataDict = dataDict;
    if (dataDict) {
        NSString *key = dataDict.allKeys.firstObject;
        if (key && ![key isKindOfClass:[NSNull class]]) {
            [self.dataArray addObjectsFromArray:[dataDict objectForKey:key]];
            self.drugTime = key;
        }
    }
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSNumber *height = [self.heightAtIndexPath objectForKey:indexPath];
    if(height){
        return height.floatValue;
    }else{
        return 33;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = cell.frame.size.height;
    [self.heightAtIndexPath setObject:[NSNumber numberWithFloat:height] forKey:indexPath];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YDMedicineDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:medicineDetailCell forIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.model = [self.dataArray objectAtIndex:indexPath.row];
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.width,60)];
    
    headerView.backgroundColor = [UIColor whiteColor];
    
    //时间
    UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 40)];
    timeLabel.text =self.drugTime;
    timeLabel.font = [UIFont systemFontOfSize:34.0];
    timeLabel.textColor = ZXRGB_COLOR(59, 135, 239);
    [headerView addSubview:timeLabel];
    
    //需要服用的yaop
    UILabel *titleLable = [[UILabel alloc]init];
    titleLable.text = @"需要服用的药品";
    titleLable.x = CGRectGetMaxX(timeLabel.frame);
    titleLable.width = 120;
    titleLable.height = 30;
    titleLable.y = headerView.height - titleLable.height - 10;
    titleLable.font = [UIFont systemFontOfSize:13.0];
    titleLable.textColor = ZXRGB_COLOR(59, 135, 239);
    [headerView addSubview:titleLable];
    
    
    //隔离线
    UIView *geliView = [[UIView alloc]init];
    geliView.x = 0;
    geliView.height = 1;
    geliView.width = headerView.width;
    geliView.y =headerView.height - geliView.height;
    geliView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [headerView addSubview:geliView];
    
    return headerView;
}

#pragma mark - 现在服药
-(void)takeMedicineButtonClick:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(didSelectedTakeMedicineButton:)]) {
        [self.delegate didSelectedTakeMedicineButton:sender];
    }
     [self removeFromSuperview];
}

#pragma mark - 稍后提醒
-(void)remindButtonClick:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(didSelectedRemindButton:)]) {
        [self.delegate didSelectedRemindButton:sender];
    }
     [self removeFromSuperview];
}

#pragma mark - clearButtonClick
-(void)clearButtonClick:(UIButton *)sender{
    [self removeFromSuperview];
}


#pragma mark - Getter
-(UIView *)backgroundView{
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _backgroundView.backgroundColor = [UIColor blackColor];
        _backgroundView.alpha = 0.3f;
    }
    return _backgroundView;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YDMedicineDetailTableViewCell class]) bundle:nil] forCellReuseIdentifier:medicineDetailCell];
    }
    return _tableView;
}

-(UIButton *)clearButton{
    if (!_clearButton) {
        _clearButton = [[UIButton alloc]init];
    }
    return _clearButton;
}

-(UIButton *)takeMedicineButton{
    if (!_takeMedicineButton) {
        _takeMedicineButton = [[UIButton alloc]init];
    }
    return _takeMedicineButton;
}

-(UIButton *)remindButton{
    if (!_remindButton) {
        _remindButton = [[UIButton alloc]init];
    }
    return _remindButton;
}

-(UIImageView *)backImgView{
    if (!_backImgView) {
        _backImgView = [[UIImageView alloc]init];
        _backImgView.contentMode = UIViewContentModeCenter;
    }
    return _backImgView;
}

- (NSMutableDictionary *)heightAtIndexPath
{
    if (!_heightAtIndexPath) {
        _heightAtIndexPath = [NSMutableDictionary dictionary];
    }
    return _heightAtIndexPath;
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]initWithCapacity:10];
    }
    return _dataArray;
}

-(void)show{
    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:self];
}
@end
