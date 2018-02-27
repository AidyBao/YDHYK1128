//
//  FAFQRViewController.h
//  FAFFramework
//
//  Created by bobo on 16/1/5.
//  Copyright © 2016年 FastAndFurious. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^FAFQRBlock)(NSString *qrStr);
@interface FAFQRViewController : UIViewController

@property(nonatomic, copy)FAFQRBlock block;

@property(nonatomic, copy)UIButton * albumBtn;

@property (nonatomic, strong) UIView *scanWindow;


/**
 *  初始化扫描，controller自带透明导航，使用时根据需求隐藏自己导航栏
 *
 *  @param block 回调，扫描和相册识别都是，返回二维码或条码所携带的字符串信息
 *
 *  @return self
 */
-(instancetype)initWithBlock:(FAFQRBlock)block;

- (void)disMiss;


@end
