//
//  YDNotificationStatusView.m
//  YDHYK
//
//  Created by 120v on 2016/12/20.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "YDNotificationStatusView.h"

@implementation YDNotificationStatusView

+(instancetype)show{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([YDNotificationStatusView class]) owner:self options:nil].firstObject;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if ([super initWithCoder:aDecoder]) {
        
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
}


-(void)layoutSubviews{
    self.width = ZX_BOUNDS_WIDTH;
    self.height = 72;
}

#pragma mark - 开启通知
- (IBAction)turnOnBtn:(id)sender {
    if ([self.delegate respondsToSelector:@selector(didNotificationStatusViewDelegate:)]) {
        [self.delegate didNotificationStatusViewDelegate:sender];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
