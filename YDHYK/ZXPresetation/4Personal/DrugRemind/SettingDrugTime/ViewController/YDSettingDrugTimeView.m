//
//  YDSettingDrugTimeView.m
//  YDHYK
//
//  Created by Aidy Bao on 2016/12/15.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "YDSettingDrugTimeView.h"
/** 用药时间Cell*/
#import "YDSettinDrugTimeCollectionViewCell.h"
/** 点击添加Cell*/
#import "YDAddTimeCollectionViewCell.h"
/** 时间选择器*/
#import "ZXDateView.h"

#import "YDAddDrugTimeModel.h"

#import "SetTimeCollectionViewLayout.h"

/** 间距*/
#define SPACE 14
/** CollectionView高度*/
#define CollectionViewHeight 184

/**  用药时间Cell*/
static NSString *const SettingDrugTimeCell = @"SettingDrugTimeCell";
/**  点击添加Cell*/
static NSString *const AddTimeCell = @"AddTimeCell";

@interface YDSettingDrugTimeView()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) NSMutableArray *tempTimeArray;

@end

@implementation YDSettingDrugTimeView

-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        self.frame = frame;
        [self initWithUI];
    }
    return self;
}


-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if ([super initWithCoder:aDecoder]) {
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    
    [self initWithUI];
}

#pragma mark - 初始化UI
-(void)initWithUI{
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.collectionView];
    [self.collectionView registerClass:[UICollectionViewCell class]  forCellWithReuseIdentifier:SettingDrugTimeCell];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([YDSettinDrugTimeCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:SettingDrugTimeCell];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([YDAddTimeCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:AddTimeCell];
    
}

-(void)layoutSubviews{
    
    self.collectionView.width = self.width;
    
    self.collectionView.height = self.height;
}

#pragma mark - UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == self.dataArray.count - 1) {
        YDAddTimeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:AddTimeCell forIndexPath:indexPath];
        return cell;
    }else{
        YDSettinDrugTimeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SettingDrugTimeCell forIndexPath:indexPath];
        cell.model = [self.dataArray objectAtIndex:indexPath.row];
        return cell;
    }
    return nil;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat contenW = (ZX_BOUNDS_WIDTH - 4*SPACE)/3;
    CGFloat contenH = contenW*0.67;
    return CGSizeMake(contenW, contenH);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0,SPACE,SPACE,SPACE);
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //1.判断设置是否达上限
    if(indexPath.row == self.dataArray.count - 1){
        if (self.dataArray.count >= 6) {
            [ZXHUD MBShowFailureInView:[ZXRootViewControllers window] text:@"设置已达上限" delay:1.2];
            return;
        }
    }
    
    //2.时间视图
    ZXDateView *dateView = [[ZXDateView alloc]init];
    [dateView show];
    
    //3.新增时间已经修改时间
    [self setDefaultTimeAndDeleteTime:dateView andWithIndexPath:indexPath];
    
    //4.设置默认时间及删除时间设置
    [self addAndModifyTimeWith:dateView andWithIndexPath:indexPath];
}

#pragma mark - 点击用药时间
#pragma mark 新增时间/修改时间
-(void)addAndModifyTimeWith:(ZXDateView *)dateView andWithIndexPath:(NSIndexPath *)indexPath{
    __weak typeof(self) weakSelf = self;
    dateView.ZXDateViewBlock = ^(NSString *dateStr){
        if ((indexPath.row == self.dataArray.count - 1)) {//1.添加
            
            if (self.dataArray.count >= 6) {
                [ZXHUD MBShowFailureInView:[ZXRootViewControllers window] text:@"设置已达上限" delay:1.2];
                return;
            }
            
            //1.2 查找相同设置
            __block NSString *temStr = nil;
            [weakSelf.tempTimeArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                temStr = obj;
                if ([temStr isEqualToString:dateStr]) {
                    *stop = true;
                    [weakSelf.tempTimeArray removeObjectAtIndex:idx];
                    [ZXHUD MBShowFailureInView:[ZXRootViewControllers window] text:@"已经设置过了" delay:1.2];
                    return;
                }
            }];
            
            //1.3 添加
            [weakSelf.tempTimeArray addObject:dateStr];
            
            //1.4 公共方法
            [weakSelf commonForAddAndModifyTimeWithTemArray:weakSelf.tempTimeArray];
            
        }else{//2.修改
            
            //2.1 查找相同设置
//            for (NSString *temStr in weakSelf.tempTimeArray) {
//                if ([temStr isEqualToString:dateStr]) {
//                    [ZXHUD showFailureWithinText:@"已经设置过了"];
//                    return;
//                }
//            }
            for (YDAddDrugTimeModel *model in weakSelf.dataArray) {
                if ([model isKindOfClass:[YDAddDrugTimeModel class]]) {
                    if ([dateStr isEqualToString:model.drugTime]) {
                        [ZXHUD MBShowFailureInView:[ZXRootViewControllers window] text:@"已经设置过了" delay:1.2];

                        return;
                    }
                }
            }
            
            //2.2 修改时间
            YDAddDrugTimeModel *model = [self.dataArray objectAtIndex:indexPath.row];
            model.drugTime = dateStr;
            
            //2.2 从dataArray取出放入temArray
            NSMutableArray *temArray = [[NSMutableArray alloc]initWithCapacity:5];
            for (int i = 0; i<self.dataArray.count - 1; i ++) {
                YDAddDrugTimeModel *model = self.dataArray[i];
                [temArray addObject:model.drugTime];
            }
            
            //2.3 公共方法
            [weakSelf commonForAddAndModifyTimeWithTemArray:temArray];
        }
        
        //3. 更新UI
        [weakSelf.collectionView reloadData];
        
        //4. 传值
        if (_setDrugTimeBlock) {
            NSMutableArray *tempArray = [[NSMutableArray alloc]init];
            for (int i = 0; i < self.dataArray.count - 1; i++) {
                YDAddDrugTimeModel *model = [self.dataArray objectAtIndex:i];
                [tempArray addObject:model];
            }
            _setDrugTimeBlock(tempArray);
        }
    };
}

#pragma mark 添加/修改用药时间公共方法
-(void)commonForAddAndModifyTimeWithTemArray:(NSMutableArray *)temArray{
   
    //1. 执行排序
    temArray =(NSMutableArray *)[temArray sortedArrayUsingSelector:@selector(compare:)];
    
    //2. 除最后一条数据其他全部移除
    if (self.dataArray.count != 1) {
        NSUInteger loc = self.dataArray.count - 1;
        [self.dataArray removeObjectsInRange:NSMakeRange(0, loc)];
    }
    
    //3. 从temArray添加dataArray
    for (int i = 0; i< temArray.count; i++) {
        NSString *str = temArray[i];
        YDAddDrugTimeModel *model =  [YDAddDrugTimeModel setAddModelWithDrugTime:str withAddTime:[NSString stringWithFormat:@"%zd",i + 1]];
        [self.dataArray insertObject:model atIndex:self.dataArray.count - 1];
    }
}

#pragma mark 设置默认时间/删除时间
-(void)setDefaultTimeAndDeleteTime:(ZXDateView *)dateView andWithIndexPath:(NSIndexPath *)indexPath{
     __weak typeof(self) weakSelf = self;
     if ((indexPath.row == self.dataArray.count - 1)) {//1.添加
         dateView.title = @"选择用药时间";
         dateView.cancelStr = @"取消";
         dateView.canCelType = Cancel;
     }else{//2.修改
         dateView.title = @"修改用药时间";
         dateView.cancelStr = @"删除";
         dateView.canCelType = Delete;
         
         //3.默认时间
         YDAddDrugTimeModel *model = [self.dataArray objectAtIndex:indexPath.row];
         dateView.model = model;
         
         NSLog(@"%@",self.tempTimeArray);
         
         //4.删除时间回调
         dateView.ZXDeleteDateBlock = ^(YDAddDrugTimeModel *model){
             NSUInteger index = model.addTime.integerValue - 1;
             
             //4.1 移除
             [weakSelf.dataArray removeObjectAtIndex:index];
             [weakSelf.tempTimeArray removeObjectAtIndex:index];
             
             //4.2 替换
             for (int i = 0; i< weakSelf.dataArray.count - 1; i++) {
                 YDAddDrugTimeModel *oldModel = weakSelf.dataArray[i];
                 YDAddDrugTimeModel *newMoel = [[YDAddDrugTimeModel alloc]init];
                 newMoel.addTime =[NSString stringWithFormat:@"%d",(i + 1)];
                 newMoel.drugTime = oldModel.drugTime;
                 [weakSelf.dataArray replaceObjectAtIndex:i withObject:newMoel];
             }
             
             //4.3 刷新
             [weakSelf.collectionView reloadData];
             
             //4.4 传值
             if (_setDrugTimeBlock) {
                 NSMutableArray *tArray = [NSMutableArray arrayWithArray:[weakSelf.dataArray subarrayWithRange:NSMakeRange(0, weakSelf.dataArray.count - 1)]] ;

                 _setDrugTimeBlock(tArray);
             }
         };
     }
}

#pragma mark - Getter
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        SetTimeCollectionViewLayout *flowLayout = [[SetTimeCollectionViewLayout alloc]init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        flowLayout.minimumInteritemSpacing = SPACE;
        flowLayout.minimumLineSpacing = SPACE;
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0,self.width, 125) collectionViewLayout:flowLayout];
        [_collectionView setBackgroundColor:[UIColor whiteColor]];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]initWithObjects:@"点击添加", nil];
    }
    return _dataArray;
}

-(NSMutableArray *)tempTimeArray{
    if (!_tempTimeArray) {
        _tempTimeArray = [[NSMutableArray alloc]initWithCapacity:10];
    }
    return _tempTimeArray;
}


@end
