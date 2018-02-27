//
//  XLLayout.m
//  XLCollectionLayout
//
//  Created by yuanxiaolong on 16/3/30.
//  Copyright © 2016年 yuanxiaolong. All rights reserved.
//

#import "LLCarouselCollectionLayout.h"

#define itemSpace 28
#define itemH 229

@interface LLCarouselCollectionLayout ()

@end

@implementation LLCarouselCollectionLayout

-(instancetype)init{
    if ([super init]) {
        self.minimumLineSpacing = -10;
        self.minimumInteritemSpacing = 0;
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.itemSize = CGSizeMake(ZX_BOUNDS_WIDTH - itemSpace * 2, itemH);
    }
    return self;
}

/**
 *  collectionView的显示范围发生改变的时候，调用下面这个方法是否重新刷新
 *  @param newBounds
 *  @return 是否重新刷新
 */
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return !CGRectEqualToRect(newBounds, self.collectionView.bounds);
}

/**
 *  布局的初始化操作
 */
- (void)prepareLayout{
    [super prepareLayout];
    self.sectionInset = UIEdgeInsetsMake(0, itemSpace, 0, itemSpace);
}

/**
 *  设置cell的显示大小
 *  @param rect 范围
 *  @return 返回所有元素的布局
 */
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    // 获取计算好的布局属性
    NSArray *arr = [super layoutAttributesForElementsInRect:rect];
     //collectionView中心点的x值
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width * 0.5;
    
    // 对原有布局进行调整
    for (UICollectionViewLayoutAttributes *attributes in arr){
        // cell的中点X 与 collectionView中心点的X间距
        CGFloat gapX = ABS(attributes.center.x - centerX);
        
        //设置cell距离中心点100以内的时候进行放缩
        if (gapX > 100) {
            gapX = 100;
        }
        // 根据间距值计算 cell的缩放比例
        CGFloat scale = 1 - gapX / 588;//588可以根据需求任意设置比例
        
        // 设置缩放比例
        attributes.transform = CGAffineTransformMakeScale(scale, scale);
    }
    return arr;
}

//确保滑动停止时始终居中显示
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity{
    //停止滚动的时候定位在中心
    //1.拿到区域内的cell
    //1.1.确定加载item的区域
    CGFloat  x = self.collectionView.contentOffset.x;
    CGFloat  y = 0;
    CGFloat  w = self.collectionView.frame.size.width;
    CGFloat  h = self.collectionView.frame.size.height;
    CGRect myrect = CGRectMake(x, y, w, h);
    
    //1.2.获得这个区域的item
    NSArray *arr =[super layoutAttributesForElementsInRect:myrect];
    
    CGFloat mindelta =MAXFLOAT;
    for (UICollectionViewLayoutAttributes *atts in arr) {
        
        //2.计算距离中心点的距离
        //1.获得item距离左边的边框的距离
        CGFloat leftdelta =atts.center.x -proposedContentOffset.x;
        //2.获得屏幕的中心点
        CGFloat centerX =self.collectionView.frame.size.width *0.5;
        //3.获得距离中心的距离
        CGFloat dela = fabs(centerX -leftdelta);
        //4.获得最小的距离
        if(dela <= mindelta)
            mindelta = centerX -leftdelta;
    }
    
    //定位在中心，注意是-号，回到之前的位置
    proposedContentOffset.x -= mindelta;
    
    //防止在第一个和最后一个 滑到中间时  卡住
    if (proposedContentOffset.x < 0) {
        proposedContentOffset.x = 0;
    }
    
    if (proposedContentOffset.x > (self.collectionView.contentSize.width - self.sectionInset.left - self.sectionInset.right - self.itemSize.width)) {
        proposedContentOffset.x = floor(proposedContentOffset.x);
    }
    return proposedContentOffset;
}

- (CGSize)collectionViewContentSize{
    return [super collectionViewContentSize];
}


@end
