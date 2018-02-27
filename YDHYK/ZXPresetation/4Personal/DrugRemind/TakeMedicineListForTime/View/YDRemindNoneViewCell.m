//
//  YDRemindNoneViewCell.m
//  ydhyk
//
//  Created by screson on 2016/10/31.
//  Copyright © 2016年 120v. All rights reserved.
//

#import "YDRemindNoneViewCell.h"

@interface YDRemindNoneViewCell (){
    UIImageView *_logoImageView;
    UILabel *_titleLabel;
    UILabel *_subTileLabel;
}
@end

@implementation YDRemindNoneViewCell

+(NSString *)reuseID{
    return @"YDRemindNoneViewCell";
}

-(void)setButtonWithImage:(UIImage *)image title:(NSString *)title{
    _logoImageView.image = image;
    _titleLabel.text = title;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame])  {
        self.backgroundColor = [UIColor whiteColor];
        [self.layer setCornerRadius:6.0];
        [self.layer setMasksToBounds:YES];
        
        //
        _logoImageView = [[UIImageView alloc] init];
        _logoImageView.contentMode = UIViewContentModeCenter;
        _logoImageView.image = [UIImage imageNamed:@"illstration"];
        _logoImageView.backgroundColor = [UIColor clearColor];
        [self addSubview:_logoImageView];
        
        //
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textColor =[UIColor blackColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.numberOfLines = 1;
        [self addSubview:_titleLabel];
        
        //
        _subTileLabel = [[UILabel alloc] init];
        _subTileLabel.font = [UIFont systemFontOfSize:15];
        _subTileLabel.textColor =[UIColor blackColor];
        _subTileLabel.textAlignment = NSTextAlignmentCenter;
        _subTileLabel.numberOfLines = 1;
        [self addSubview:_subTileLabel];
        
        

        _titleLabel.text = @"点击右上方“+”添加用药提醒";
        _titleLabel.textColor = [UIColor zx_textColor];
        
        _subTileLabel.text = @"按时服药，身体才能健康哦";
        _subTileLabel.textColor =[UIColor zx_textColor];
    }
    return self;
}

-(void)layoutSubviews{
    //
    _logoImageView.width = 96;
    _logoImageView.height = 119;
    _logoImageView.x = (self.width - _logoImageView.width)*0.5;
    _logoImageView.y = 25;
 
    //
    _titleLabel.x = 20.f;
    _titleLabel.height = 21;
    _titleLabel.y = CGRectGetMaxY(_logoImageView.frame) + 15;
    _titleLabel.width = self.width - 2*_titleLabel.x;
    _subTileLabel.centerX = self.centerX;
    
    //
    _subTileLabel.x = 20.f;
    _subTileLabel.height = 21;
    _subTileLabel.y = CGRectGetMaxY(_titleLabel.frame) + 5;
    _subTileLabel.width = self.width - 2*_titleLabel.x;
    _subTileLabel.centerX = CGRectGetMidX(_titleLabel.frame);
    

}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
