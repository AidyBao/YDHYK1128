//
//  MyNormalAnnotationView.m
//  ydhyk
//
//  Created by 120v on 2016/11/2.
//  Copyright © 2016年 120v. All rights reserved.
//

#import "MyNormalAnnotationView.h"

@interface MyNormalAnnotationView()

@property (nonatomic, strong) UIImageView *normalImageView;

@end

@implementation MyNormalAnnotationView

- (id)initWithAnnotation:(id<BMKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setBounds:CGRectMake(0.f, 0.f, 50.25, 60.25)];
        self.normalImageView.frame = self.bounds;
        [self setBackgroundColor:[UIColor clearColor]];
        self.normalImageView.contentMode = UIViewContentModeCenter;
        [self addSubview:self.normalImageView];
    }
    return self;
}

-(void)layoutSubviews{

}

-(void)setNormalImage:(UIImage *)normalImage{
    _normalImage = normalImage;
    self.normalImageView.image = normalImage;
    self.normalImageView.animationDuration= 3.0;
}

-(void)tap:(UITapGestureRecognizer *)sender{
    
}

#pragma mark - lazy
-(UIImageView *)normalImageView{
    if (!_normalImageView) {
        _normalImageView = [[UIImageView alloc]init];
    }
    return _normalImageView;
}


@end
