//
//  YDRemindInfoViewCell.m
//  ydhyk
//
//  Created by screson on 2016/10/31.
//  Copyright © 2016年 120v. All rights reserved.
//

#import "YDRemindInfoViewCell.h"
#import "YDRemindInfoHeaderViewCell.h"

static NSString *const moreDrugRemindInfoCell = @"moreDrugRemindInfoCell";

@interface YDRemindInfoViewCell ()<UITableViewDelegate,UITableViewDataSource>{
    __weak IBOutlet UITableView *infoTable;
}
@property(nonatomic,strong)NSMutableArray *dataArray;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIButton *checkInfroBtn;
@property (weak, nonatomic) IBOutlet UILabel *drugTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleW;


@end
@implementation YDRemindInfoViewCell

+(NSString *)reuseID{
    return @"YDRemindInfoViewCell";
}

- (instancetype)initWithCoder:(NSCoder *)coder{
    self = [super initWithCoder:coder];
    if (self) {
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.layer setCornerRadius:5.0];
    self.backView.layer.masksToBounds = NO;
    self.backView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.backView.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
    self.backView.layer.shadowOpacity = 1.0f;
    [self.backView.layer setShadowRadius:5.0];
    [self.backView.layer setCornerRadius:5.0];
    
    [self.checkInfroBtn.layer setBorderWidth:1.0];
    [self.checkInfroBtn.layer setBorderColor:[UIColor zx_tintColor].CGColor];
    [self.checkInfroBtn.layer setCornerRadius:5.0];
    [self.checkInfroBtn.layer setMasksToBounds:YES];
    
    infoTable.dataSource = self;
    infoTable.delegate = self;
    [infoTable registerNib:[UINib nibWithNibName:NSStringFromClass([YDRemindInfoHeaderViewCell class]) bundle:nil]  forCellReuseIdentifier:[YDRemindInfoHeaderViewCell reuseID]];
    [infoTable registerClass:[UITableViewCell class] forCellReuseIdentifier:moreDrugRemindInfoCell];
    
    if ([UIDevice zx_deviceSizeType] == ZX_IPHONE5) {
        [self.drugTimeLabel setFont:[UIFont zx_titleFontWithSize:28.f]];
        self.titleW.constant = 75.f;
    }
}

#pragma mark - setter
-(void)setDataDict:(NSDictionary *)dataDict{
    _dataDict = dataDict;
    [self.dataArray removeAllObjects];
    if (dataDict || [dataDict isKindOfClass:[NSDictionary class]]) {
        NSString *key = dataDict.allKeys.firstObject;
        if (key && ![key isKindOfClass:[NSNull class]]) {
            [self.dataArray addObjectsFromArray:[dataDict objectForKey:key]];
            self.drugTimeLabel.text = key;
        }
    }

    [infoTable reloadData];
}

-(void)setDrugTime:(NSString *)drugTime{
    _drugTime = drugTime;
    NSString *resultStr = [drugTime substringWithRange:NSMakeRange(11, 5)];
    self.drugTimeLabel.text = resultStr;
}

#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger rowNum = 0;
    if (self.dataArray.count>=5) {
        rowNum = 5;
    }else{
        rowNum = self.dataArray.count;
    }
    return rowNum;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    CGFloat rowH = 0.0;
    if (indexPath.row >= 4) {
        rowH = 8;
    }else{
        rowH = 28;
    }
    
    return rowH;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YDRemindInfoHeaderViewCell *cell=[tableView dequeueReusableCellWithIdentifier:[YDRemindInfoHeaderViewCell reuseID] forIndexPath:indexPath];
    if (indexPath.row >= 4) {
        cell.medicinesName.text = @"......";
        cell.quantityLabel.text = @"";
    }else{
        cell.model = [self.dataArray objectAtIndex:indexPath.row];
    }
    return cell;
}

#pragma mark - 查看详情
- (IBAction)checkInfo:(id)sender {
    if (_handleDidCheckInfoBtn) {
        _handleDidCheckInfoBtn(self.dataDict);
    }
}

#pragma mark - 修改时间
- (IBAction)modifyTimeBtn:(id)sender {
    if (_modifyRemindTime) {
        _modifyRemindTime(self.dataDict);
    }
}


#pragma mark - Getter
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]initWithCapacity:10];
    }
    return _dataArray;
}

@end
