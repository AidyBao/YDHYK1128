//
//  YDLaunchRootViewController.m
//  ydhyk
//
//  Created by 120v on 2016/10/24.
//  Copyright © 2016年 120v. All rights reserved.
//

#import "YDFlashScreenViewController.h"
/**管理程序主控制器*/
#import "ZXRootViewControllers.h"
#import "UIImageView+AFNetworking.h"

@interface YDFlashScreenViewController ()<UIWebViewDelegate>
/** 显示图片*/
@property(nonatomic,strong)UIImageView *imageView;
/** 底部Logo*/
@property(nonatomic,strong)UIImageView *logoImageView;
/** 图片url*/
@property(nonatomic,copy)NSString *flashImageURL;
/** 标题*/
@property (strong, nonatomic)UILabel *titleLabel;
/** 跳过按钮*/
@property (strong, nonatomic)UIButton *timeButton;
/**计时器，控制跳转*/
@property(nonatomic,strong)NSTimer *countTimer;
/**跳转时间*/
@property (nonatomic, assign) NSInteger flashCount;

@end

@implementation YDFlashScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    //闪屏时间
    self.flashCount = 5.0;
    
    //添加广告ImageView
    [self.view addSubview:self.imageView];
    
    //跳过按钮
    [self addTimeButton];
    
    
    //判断沙盒中是否存有广告图片
    [self loadFlashScreen];
    
   
    //Logo
    [self addLogoImage];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [UIApplication sharedApplication].statusBarHidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [UIApplication sharedApplication].statusBarHidden = NO;
}


#pragma mark - 跳过按钮
-(void)addTimeButton{
    self.timeButton.width = 100;
    self.timeButton.height = 38;
    self.timeButton.x = ZX_BOUNDS_WIDTH - 15 - self.timeButton.width;
    self.timeButton.y = 45;
    [self.timeButton setTitle:@"5s 点击跳过" forState:UIControlStateNormal];
    self.timeButton.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    [self.timeButton.layer setCornerRadius:self.timeButton.height*0.5];
    [self.timeButton.layer setMasksToBounds:YES];
    [self.timeButton addTarget:self action:@selector(timeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.timeButton setTitleColor:ZXWHITE_COLOR forState:UIControlStateNormal];
    self.timeButton.titleLabel.font = [UIFont zx_bodyFontWithSize:13.0];
    [self.view addSubview:self.timeButton];

}

#pragma mark - 加载广告
-(void)loadFlashScreen{
    self.flashImageURL=[[YDAPPManager shareManager] getFlashImageURL];
    UIImage *flashImage = [[YDAPPManager shareManager] getFlashImage];
    
    if (flashImage) {
        self.imageView.image=flashImage;
        
        [self.countTimer invalidate];
        self.countTimer = nil;
        
        //倒计时
        [[NSRunLoop mainRunLoop] addTimer:self.countTimer forMode:NSRunLoopCommonModes];
        
    }else if(self.flashImageURL.length){
        [self.imageView setImageWithURL:[NSURL URLWithString:self.flashImageURL] placeholderImage:nil];
        
        [self.countTimer invalidate];
        self.countTimer = nil;
        
        //倒计时
        [[NSRunLoop mainRunLoop] addTimer:self.countTimer forMode:NSRunLoopCommonModes];
        
    }else{
        self.imageView.image = [UIImage imageNamed:@""];
        [self.timeButton setHidden:YES];
        self.flashCount = 0;
        [self backToLogin];
    }
}

#pragma mark - logo
-(void)addLogoImage{
    self.logoImageView.width = ZX_BOUNDS_WIDTH;
    self.logoImageView.height = 100;
    self.logoImageView.x = 0;
    self.logoImageView.y = ZX_BOUNDS_HEIGHT - 100;
    self.logoImageView.image = [UIImage imageNamed:@"logo.png"];
    self.logoImageView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.logoImageView];
}

//倒计时
- (void)countDown{
    self.flashCount --;
    [self.timeButton setTitle:[NSString stringWithFormat:@"%lds 点击跳过",self.flashCount] forState:UIControlStateNormal];
    if (self.flashCount == 0) {
        [self dismissFlashScreen];
    }
}


// 移除广告页面
- (void)dismissFlashScreen{
    //
    [self backToLogin];
}


#pragma mark - 5秒后跳过按钮
-(void)timeBtnClick:(UIButton *)sender{
    [self backToLogin];
}


#pragma mark - 广告Web页面返回按钮
-(void)backToLogin{
    //关闭定时器
    [self.countTimer invalidate];
    self.countTimer = nil;
    
    //切换主控制器场景
    [ZXRouter changeRootViewController:[ZXRootViewControllers zx_tabbarController]];
}

#pragma mark - lazy
-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ZX_BOUNDS_WIDTH, ZX_BOUNDS_HEIGHT - 100)];
        _imageView.clipsToBounds = true;
        _imageView.contentMode=UIViewContentModeScaleAspectFill;
        _imageView.backgroundColor = [UIColor clearColor];
        _imageView.userInteractionEnabled = YES;
    }
    return _imageView;
}

-(UIImageView *)logoImageView{
    if (!_logoImageView) {
        _logoImageView = [[UIImageView alloc]init];
        _logoImageView.contentMode = UIViewContentModeCenter;
    }
    return _logoImageView;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel=[[UILabel alloc]init];
        CGFloat titlelabW=[UIScreen mainScreen].bounds.size.width/2+50;
        CGFloat titlelabH=44;
        CGFloat  titlelabX=[UIScreen mainScreen].bounds.size.width/2-titlelabW/2;
        CGFloat  titlelabY=20;
        _titleLabel.frame=CGRectMake(titlelabX, titlelabY, titlelabW, titlelabH);
        _titleLabel.textAlignment=NSTextAlignmentCenter;
        _titleLabel.textColor=[UIColor whiteColor];
    }
    return _titleLabel;
}

-(UIButton *)timeButton{
    if (!_timeButton) {
        _timeButton = [[UIButton alloc]init];
    }
    return _timeButton;
}

- (NSTimer *)countTimer{
    if (!_countTimer) {
        _countTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
    }
    return _countTimer;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
