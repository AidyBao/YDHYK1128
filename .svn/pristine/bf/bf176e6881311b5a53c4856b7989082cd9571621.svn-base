//
//  ZXRefreshHeader.m
//  YDHYK
//
//  Created by JuanFelix on 30/11/2016.
//  Copyright © 2016 screson. All rights reserved.
//

#import "ZXRefreshHeader.h"

@implementation ZXRefreshHeader


#pragma mark - 重写方法
#pragma mark 基本设置
- (void)prepare
{
    [super prepare];
    
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=48; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"loading-%zd", i]];
        [idleImages addObject:image];
    }
    [self setImages:idleImages forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
//    for (NSUInteger i = 1; i<=65; i++) {
//        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"loading-%zd", i]];
//        [refreshingImages addObject:image];
//    }
    for (NSUInteger i = 48; i<=65; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"loading-%zd", i]];
        [refreshingImages addObject:image];
    }
    for (NSUInteger i = 1; i<=48; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"loading-%zd", i]];
        [refreshingImages addObject:image];
    }

    [self setImages:refreshingImages duration:refreshingImages.count * 0.03 forState:MJRefreshStatePulling];
    [self setImages:refreshingImages duration:refreshingImages.count * 0.03 forState:MJRefreshStateRefreshing];
    //[self setImages:refreshingImages forState:MJRefreshStatePulling];
//    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
