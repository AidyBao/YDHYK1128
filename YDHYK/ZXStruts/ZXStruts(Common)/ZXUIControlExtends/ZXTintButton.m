//
//  ZXTintButton.m
//  ZXStructure
//
//  Created by JuanFelix on 2016/11/25.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "ZXTintButton.h"
#import "ZXStruts.h"

@implementation ZXTintButton

+ (instancetype)button{
    return [ZXTintButton buttonWithType:UIButtonTypeCustom];
}

- (UIButtonType)buttonType{
    return UIButtonTypeCustom;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self loadColorFromPlist];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self loadColorFromPlist];
}

- (void)loadColorFromPlist{
    [self.titleLabel setFont:[UIFont zx_titleFontWithSize:zx_buttonTitleFontSize()]];
    [self setTitleColor:[UIColor zx_buttonTitleNormalColor] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor zx_buttonTitleSelectedColor] forState:UIControlStateSelected];
    [self setTitleColor:[UIColor zx_buttonTitleSelectedColor] forState:UIControlStateHighlighted];
    [self setTitleColor:[UIColor zx_buttonTitleDisabledColor] forState:UIControlStateDisabled];
    if (self.enabled) {
        [self setBackgroundColor:[UIColor zx_buttonBGNormalColor]];
    }else{
        [self setBackgroundColor:[UIColor zx_buttonBGDisabledColor]];
    }
}


@end
