//
//  HDiscoverCollectionViewDataSource.m
//  YDHYK
//
//  Created by JuanFelix on 01/12/2016.
//  Copyright © 2016 screson. All rights reserved.
//

#import "HDiscoverCollectionViewDataSource.h"
#import "HDiscoverCollectionViewCell.h"

@implementation HDiscoverCollectionViewDataSource


#pragma mark - CollectionView DataSource

- (instancetype)init{
    if (self = [super init]) {
        arrIcon = @[@"btn-join",@"btn-Test",@"btn-tool"];
        arrTitle = @[@"加入会员",@"验证会员",@"智能工具"];
    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HDiscoverCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:HDICOVER_CC_CELLID forIndexPath:indexPath];
    [cell.imgIcon setImage:[UIImage imageNamed:arrIcon[indexPath.row]]];
    [cell.lbTitle setText:arrTitle[indexPath.row]];
    return cell;
}

@end
