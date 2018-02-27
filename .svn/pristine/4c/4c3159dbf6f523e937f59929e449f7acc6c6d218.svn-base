//
//  YDJoinMemberHeaderView.m
//  ydhyk
//
//  Created by 120v on 2016/10/28.
//  Copyright © 2016年 120v. All rights reserved.
//

#import "YDJoinMemberHeaderView.h"

@interface YDJoinMemberHeaderView()

@property (nonatomic, strong) UIImageView *iconImage;
@property (nonatomic, strong) UILabel *detailLable;

@end

@implementation YDJoinMemberHeaderView



-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.iconImage];
        [self addSubview:self.detailLable];
        
    }
    
    return self;
}


-(void)layoutSubviews{
   
    //图片
    UIImage *image = [UIImage imageNamed:@"noneofcard"];
    self.iconImage.image = image;
    self.iconImage.width = image.size.width;
    self.iconImage.height = image.size.height;
    self.iconImage.y = 30.0;
    self.iconImage.centerX = self.centerX;
    
    //lable
    self.detailLable.y = CGRectGetMaxY(self.iconImage.frame)+20;
    self.detailLable.x = 25;
    self.detailLable.height = 45;
    self.detailLable.width = ZX_BOUNDS_WIDTH - 2*self.detailLable.x;
    self.detailLable.text = @"您还没有会员卡，快去附近药店扫描二维码加入会员吧，更多优惠属于您。";
    if ([UIDevice zx_deviceSizeType] == ZX_IPHONE5 || [UIDevice zx_deviceSizeType] == ZX_IPHONE4) {
        self.detailLable.font = [UIFont systemFontOfSize:15.0];
    }else{
        self.detailLable.font = [UIFont systemFontOfSize:16.0];
    }

    self.detailLable.numberOfLines = 0;
    self.detailLable.textColor = ZXRGB_COLOR(159, 164, 172);
    self.detailLable.textAlignment = NSTextAlignmentCenter;
    
    
}



#pragma mark - lazy
-(UIImageView *)iconImage{
    if (!_iconImage) {
        _iconImage = [[UIImageView alloc]init];
    }
    return _iconImage;
}

-(UILabel *)detailLable{
    if (!_detailLable) {
        _detailLable = [[UILabel alloc]init];
    }
    return _detailLable;
}


@end
