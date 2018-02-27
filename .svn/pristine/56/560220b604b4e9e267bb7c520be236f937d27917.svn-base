//
//  BTextView.m
//  SubWayWifi
//
//  Created by bao_aidy on 16/8/31.
//  Copyright © 2016年 apple. All rights reserved.
//  自定义带占位符的TextView

#import "BTextView.h"

@interface BTextView()
/** 占位文字label */
@property (nonatomic, weak) UILabel *placeholderLabel;

@end

@implementation BTextView

-(void)awakeFromNib{
    [super awakeFromNib];
    [self initMethod];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initMethod];
     }
     return self;
 }

-(void)initMethod{
    
    // 垂直方向上永远有弹簧效果
    self.alwaysBounceVertical = YES;
    // 默认字体
    self.font = [UIFont systemFontOfSize:17.0f];
    // 默认的占位文字颜色
    self.placeholderColor = [UIColor lightGrayColor];
    // 监听文字改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];
}

- (void)dealloc{
     [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/**
* 监听文字改变
*/
- (void)textDidChange{
    // 只要有文字, 就隐藏占位文字label
    self.placeholderLabel.hidden = self.hasText;
 }

/**
* 更新占位文字的尺寸
*/
- (void)updatePlaceholderLabelSize{
    CGSize maxSize = CGSizeMake(ZX_BOUNDS_WIDTH -20 - 2 * self.placeholderLabel.x, MAXFLOAT);
   self.placeholderLabel.size = [self.placeholder boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.font} context:nil].size;
}

#pragma mark - 重写setter
- (void)setPlaceholderColor:(UIColor *)placeholderColor{
    _placeholderColor = placeholderColor;

    self.placeholderLabel.textColor = placeholderColor;
}


- (void)setPlaceholder:(NSString *)placeholder{
     _placeholder = [placeholder copy];

     self.placeholderLabel.text = placeholder;

     [self updatePlaceholderLabelSize];
}

- (void)setFont:(UIFont *)font{
     [super setFont:font];

     self.placeholderLabel.font = font;
     [self updatePlaceholderLabelSize];
}

- (void)setText:(NSString *)text{
    [super setText:text];

     [self textDidChange];
}

- (void)setAttributedText:(NSAttributedString *)attributedText{
     [super setAttributedText:attributedText];
    [self textDidChange];
}


- (void)drawRect:(CGRect)rect {
    // Drawing code
}


- (UILabel *)placeholderLabel{
    if (!_placeholderLabel) {
        // 添加一个用来显示占位文字的label
        UILabel *placeholderLabel = [[UILabel alloc] init];
        placeholderLabel.numberOfLines = 0;
         placeholderLabel.x = 4;
         placeholderLabel.y = 7;
         [self addSubview:placeholderLabel];
         _placeholderLabel = placeholderLabel;
     }
     return _placeholderLabel;
 }

@end
