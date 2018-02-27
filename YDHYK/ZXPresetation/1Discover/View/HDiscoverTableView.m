//
//  HDiscoverTableView.m
//  YDHYK
//
//  Created by JuanFelix on 29/11/2016.
//  Copyright © 2016 screson. All rights reserved.
//

#import "HDiscoverTableView.h"

@implementation HDiscoverTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    if (point.y < 0) {
        return nil;
    }
    return self;
}

@end
