//
//  YDDetailView.m
//  ydhyk
//
//  Created by 120v on 2016/10/26.
//  Copyright © 2016年 120v. All rights reserved.
//

#import "YDDetailView.h"
#import "YDDetailCollectionViewCell.h"


static NSString *const detailCollCell = @"detailCollCell";

@interface YDDetailView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,YDDetailCollectionViewCellDelegate>

@property (nonatomic ,strong) UICollectionView *collectionView;

@end

@implementation YDDetailView



-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor zx_assistColor];
        
        self.collectionView.showsVerticalScrollIndicator = NO;
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        [self addSubview:self.collectionView];

    }
    return self;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.collectionView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);

    
}


#pragma mark - 刷新数据
-(void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    [self.collectionView reloadData];
}


#pragma mark - UICollectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(self.frame.size.width, self.frame.size.height);
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    YDDetailCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:detailCollCell forIndexPath:indexPath];
    cell.delegate = self;
    
    YDSearchModel *model = [self.dataArray objectAtIndex:indexPath.row];
    cell.model = model;
    
    return  cell;
}

#pragma mark - YDDetailCollectionViewCellDelegate
#pragma mark 加入会员
-(void)didSelectedJoinMemberButton:(UIButton *)sender withDataModel:(YDSearchModel *)model{
    if ([self.delegate respondsToSelector:@selector(didDetailViewJoinMemberButton:withDataModel:)]) {
        [self.delegate didDetailViewJoinMemberButton:sender withDataModel:model];
    }
}

#pragma mark 导航
-(void)didSelectedNavigationButton:(UIButton *)sender withDataModel:(YDSearchModel *)model{
    if ([self.delegate respondsToSelector:@selector(didDetailViewNavigationButton:withDataModel:)]) {
        [self.delegate didDetailViewNavigationButton:sender withDataModel:model];
    }
}

#pragma mark 打电话
-(void)didSelectedTelephoneButton:(UIButton *)sender withDataModel:(YDSearchModel *)model{
    if ([self.delegate respondsToSelector:@selector(didDetailViewTelephoneButton:withDataModel:)]) {
        [self.delegate didDetailViewTelephoneButton:sender withDataModel:model];
    }
}


#pragma mark - collectionView
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        //设置水平滑动
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:flowLayout];
        [_collectionView registerNib:[UINib nibWithNibName:@"YDDetailCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:detailCollCell];
        _collectionView.backgroundColor = [UIColor zx_assistColor];
    }
    return _collectionView;
}


@end
