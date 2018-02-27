//
//  HQRScanViewController.m
//  YDHYK
//
//  Created by screson on 2016/12/5.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "HQRScanViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "HJoinSuccessViewController.h"
#import "ZXJoinMemberViewModel.h"
#import "YDNearbyRootViewController.h"
#import "YDHYK-Swift.h"

@interface HQRScanViewController ()<AVCaptureMetadataOutputObjectsDelegate>{
    BOOL  checking;//处理扫描数据
    NSString * storeWebURL;
}

@property (weak, nonatomic) IBOutlet UIView * contentView;//承载图像
@property (weak, nonatomic) IBOutlet UIView * scanFrame;//扫描区域

@property (strong, nonatomic) UIImageView * animationImage;
@property (nonatomic, strong) AVCaptureSession *session;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftSapce;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightSpace;
@property (weak, nonatomic) IBOutlet UIView *tipsBackView;

@property (nonatomic,strong) CLLocation * location;

@end

@implementation HQRScanViewController

- (instancetype)init{
    if (self = [super init]) {
        _needHidNavAfterBack = false;
        [self setHidesBottomBarWhenPushed:true];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:false animated:true];
    [self zx_setNavBarBackgroundColor:[UIColor clearColor]];
    if ([UIDevice zx_deviceSizeType] == ZX_IPHONE5 ||
        [UIDevice zx_deviceSizeType] == ZX_IPHONE4) {
        _leftSapce.constant = 20;
        _rightSpace.constant = 20;
    }else{
        _leftSapce.constant = 60;
        _rightSpace.constant = 60;
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if ([CLLocationManager locationServicesEnabled]) {
        CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
        if (kCLAuthorizationStatusAuthorizedAlways == status || kCLAuthorizationStatusAuthorizedWhenInUse == status) {
            [[ZXLocationUtils shareInstance] checkCurrentLoaction:^(BOOL success, CLLocation *location) {
                if (success) {
                    _location = location;
                    [self checkEnvironmentAndRun];
                }else{
                    _location = [[CLLocation alloc] initWithLatitude:ZX_LATITUDE longitude:ZX_LONGITUDE];
                    [self checkEnvironmentAndRun];
                }
            }];
        }else{
            [self locationDisable];
        }
    }else{
        [self locationDisable];
    }
}

- (void)locationDisable{
        [ZXAlertUtils showAAlertMessage:@"位置信息不可用,可以在设置中开启" title:@"提示" buttonTexts:@[@"知道了"] buttonAction:^(int buttonIndex) {
            [[ZXLocationUtils shareInstance] checkCurrentLoaction:^(BOOL success, CLLocation *location) {
                if (success) {
                    _location = location;
                    [self checkEnvironmentAndRun];
                }else{
                    _location = [[CLLocation alloc] initWithLatitude:ZX_LATITUDE longitude:ZX_LONGITUDE];
                    [self checkEnvironmentAndRun];
                }
            }];
        }];
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (_needHidNavAfterBack) {
        [self.navigationController setNavigationBarHidden:true animated:true];
    }
    [self zx_setNavBarBackgroundColor:[UIColor zx_navbarColor]];
}


- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    if (_session && [_session isRunning]) {
        [_session stopRunning];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    checking = false;
    [self setTitle:@"加入会员"];
    [self zx_setNavBarBackgroundColor:[UIColor clearColor]];
    if (_showRightButton) {
        [self zx_addRightBarItemsWithTexts:@[@"附近药店"] font:nil color:ZXRGB_COLOR(112, 172, 255)];
    }
    [self.scanFrame setBackgroundColor:[UIColor clearColor]];
    
    [self.tipsBackView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
    
    //
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(s_enterBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(s_enterForeground) name:UIApplicationWillEnterForegroundNotification object:nil];
}

- (void)s_enterBackground{
    _animationImage.layer.timeOffset = CACurrentMediaTime();
}

- (void)s_enterForeground{
    [self resumeAnimation];
}


#pragma mark - 附近药店
- (void)zx_rightBarButtonActionsIndex:(NSInteger)index{
    if (self.navigationController) {
        __block UIViewController * vc = nil;
        [self.navigationController.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[YDNearbyRootViewController class]]) {
                vc = obj;
                *stop = true;
            }
        }];
        if (vc) {
            [self.navigationController popToViewController:vc animated:true];

        }else{
            [self.navigationController popToRootViewControllerAnimated:false];
            [ZXRouter shouldSelectTabbarIndex:1];

        }
        
    }else{
        [self dismissViewControllerAnimated:true completion:^{
            [ZXRouter shouldSelectTabbarIndex:1];

        }];
    }
}

- (void)checkEnvironmentAndRun{
    AVAuthorizationStatus  authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    switch (authStatus) {
        case AVAuthorizationStatusAuthorized:
        {
            [self beginScanning];
        }
            break;
        case AVAuthorizationStatusDenied:
        {
            if (ZX_IOS8_OR_LATER) {
                [ZXAlertUtils showAAlertMessage:@"您阻止了相机访问权限,请在设置中开启" title:@"提示" buttonTexts:@[@"取消",@"马上打开"] buttonAction:^(int buttonIndex) {
                    if (buttonIndex == 1) {
                        [ZXCommonUtils openApplicationURL:UIApplicationOpenSettingsURLString];
                    }
                }];
            }else{
                [ZXAlertUtils showAAlertMessage:@"请在 '系统设置|隐私|相机' 中开启相机访问权限" title:@"提示" buttonText:@"知道了" buttonAction:nil];
            }
        }
            break;
        case AVAuthorizationStatusNotDetermined:
        {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self beginScanning];
                    });
                    
                }
            }];
        }
            break;
        case AVAuthorizationStatusRestricted:
        {
            
        }
            break;
        default:
            break;
    }
}

- (void)beginScanning
{
    if (!_session) {
        //获取摄像设备
        AVCaptureDevice * device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        //创建输入流
        AVCaptureDeviceInput * input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
        
        if (!input) {
            NSLog(@"设备不可用...");
            return;
        }
        //创建输出流
        AVCaptureMetadataOutput * output = [[AVCaptureMetadataOutput alloc]init];
        //设置代理 在主线程里刷新
        [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        //设置有效扫描区域
        CGRect scanCrop=[self getScanCrop:CGRectMake(0, 0, self.scanFrame.frame.size.width, self.scanFrame.frame.size.height) readerViewBounds:self.contentView.frame];
        //设置扫描范围CGRectMake(Y,X,H,W),1代表最大值 右上角基准
        output.rectOfInterest = scanCrop;
        //初始化链接对象
        _session = [[AVCaptureSession alloc]init];
        //高质量采集率
        [_session setSessionPreset:AVCaptureSessionPresetHigh];
        [_session addInput:input];
        [_session addOutput:output];
        //设置扫码支持的编码格式(如下设置条形码和二维码兼容,)
        output.metadataObjectTypes=@[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeCode128Code,AVMetadataObjectTypeEAN8Code,AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeCode39Code,AVMetadataObjectTypeCode93Code,AVMetadataObjectTypeUPCECode,AVMetadataObjectTypeCode39Mod43Code,AVMetadataObjectTypePDF417Code,AVMetadataObjectTypeAztecCode,AVMetadataObjectTypeITF14Code,AVMetadataObjectTypeDataMatrixCode];
        
        AVCaptureVideoPreviewLayer * layer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
        layer.videoGravity=AVLayerVideoGravityResizeAspectFill;
        layer.frame= CGRectMake(0, 0, ZX_BOUNDS_WIDTH, ZX_BOUNDS_HEIGHT);
        [self.contentView.layer insertSublayer:layer atIndex:0];
        [self addMaskLayer];
    }
    if (_session) {
        if ([_session isRunning]) {
            return;
        }
        [_session startRunning];
        [self resumeAnimation];
    }
}

- (void)addMaskLayer{
    CALayer * maskLayer = [[CALayer alloc] init];
    maskLayer.frame = [UIScreen mainScreen].bounds;
    maskLayer.backgroundColor = ZXRGBA_COLOR(0, 0, 0, 0.6).CGColor;
    CAShapeLayer * empty = [CAShapeLayer layer];
    UIBezierPath * path = [UIBezierPath bezierPathWithRect:maskLayer.frame];
    CGRect frame = self.scanFrame.frame;
    [path appendPath:[[UIBezierPath bezierPathWithRoundedRect:CGRectMake(frame.origin.x, frame.origin.y + 64, frame.size.width, frame.size.height) cornerRadius:0] bezierPathByReversingPath]];
    empty.path = path.CGPath;
    maskLayer.mask = empty;
    
    _animationImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"scan_net"]];
    
    [self.contentView.layer addSublayer:maskLayer];
}



-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    if (checking) {
        return;
    }
    checking = true;
    [_session stopRunning];
    if (metadataObjects.count>0) {
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        NSLog(@"QR:%@",metadataObject.stringValue);
        NSString * result  = metadataObject.stringValue;
        NSRange domainRange = [result rangeOfString:ZX_QRCODE_CONTAIN];
        if (domainRange.length) {
            NSRange storeIdRange = [result rangeOfString:@"drugstoreid=[\\d]*" options:NSRegularExpressionSearch range:NSMakeRange(0, result.length)];
            NSRange userIdRange = [result rangeOfString:@"userid=[\\d]*" options:NSRegularExpressionSearch range:NSMakeRange(0, result.length)];
            if (storeIdRange.length > 0) {
                storeWebURL = result;
                NSString * storeId = [result substringWithRange:storeIdRange];
                storeId = [storeId stringByReplacingOccurrencesOfString:@"drugstoreid=" withString:@""];
                long long sId = [storeId longLongValue];
                if (sId < 2000000) {//ID 小于2,000,000
                    sId += 2000000;
                }
                
                NSString * userId = nil;
                if (userIdRange.length > 0 ) {
                    userId = [result substringWithRange:userIdRange];
                    userId = [userId stringByReplacingOccurrencesOfString:@"userid=" withString:@""];
                }
                
                [_animationImage.layer removeAllAnimations];
                [self joinMemberToStoreId:[NSString stringWithFormat:@"%@",@(sId)] recommendUserId:userId];
            } else {
                [ZXHUD MBShowFailureInView:self.view text:@"二维码不正确" delay:1.2];
                checking = false;
                [self performSelector:@selector(checkEnvironmentAndRun) withObject:nil afterDelay:1.2];
            }
        }else{
            [ZXHUD MBShowFailureInView:self.view text:@"二维码不正确" delay:1.2];
            checking = false;
            [self performSelector:@selector(checkEnvironmentAndRun) withObject:nil afterDelay:1.2];
        }
    }else{
        checking = false;
        [self checkEnvironmentAndRun];
    }
}

- (void)joinMemberToStoreId:(NSString *)storeId recommendUserId:(NSString *)userId{
    [ZXHUD MBShowLoadingInView:self.view text:ZX_LOADING_TEXT delay:0];

    [ZXJoinMemberViewModel joinMemberToStore:storeId
                                    location:_location
                                    memberId:[[ZXGlobalData shareInstance] memberId]
                                      userId:userId
                                       token:[[ZXGlobalData shareInstance] userToken]
                                  completion:^(BOOL isNew, NSInteger status, BOOL success, NSString *errorMsg) {
        if (status == ZXAPI_SUCCESS) {
            [ZXNotificationCenter postNotificationName:ZXNOTICE_JOINMEMBER_SUCCESS object:@{@"storeId":storeId}];
            //获取店铺详情并跳转
            [ZXJoinMemberViewModel getDrugStoreDetailsByID:storeId memberId:[[ZXGlobalData shareInstance] memberId] token:[[ZXGlobalData shareInstance] userToken] completion:^(ZXDrugStoreModel *drugStore, NSInteger status, BOOL success, NSString *errorMsg) {
                checking = false;
                [ZXHUD MBHideForView:self.view animate:true];
                if (status == ZXAPI_SUCCESS) {
                    if (drugStore) {
                        if (isNew) {
                            HJoinSuccessViewController * successVC = [[HJoinSuccessViewController alloc] init];
                            successVC.storeInfo = drugStore;
                            [self.navigationController pushViewController:successVC animated:true];
                        }else{
                            ZXStoreRootViewController * webStore = [ZXStoreRootViewController configVCWith:drugStore.storeId memberId:[[ZXGlobalData shareInstance] memberId] token:[[ZXGlobalData shareInstance] userToken]];
                            
                                NSMutableArray *ViewCtr = [NSMutableArray arrayWithObject:[self.navigationController.viewControllers firstObject]];
                                [ViewCtr addObject:webStore];
                                [self.navigationController setViewControllers:ViewCtr animated:YES];
                                //[webStore.navigationController setNavigationBarHidden:true animated:true];
                        }
                    }else{
                        [self invalidStore];
                    }
                }else{
                    [ZXHUD MBShowFailureInView:self.view text:errorMsg delay:1.2];
                    [self performSelector:@selector(checkEnvironmentAndRun) withObject:nil afterDelay:1.2];

                }
            }];
            if (isNew) {
                //获取历史未失效现金券 失败不做二次处理
                [ZXJoinMemberViewModel getStoreHistoryCashCouponById:storeId memberId:[[ZXGlobalData shareInstance] memberId] token:[[ZXGlobalData shareInstance] userToken]];
                //历史促销信息
                [ZXJoinMemberViewModel getStoreHistoryPromotionById:storeId memberId:[[ZXGlobalData shareInstance] memberId] token:[[ZXGlobalData shareInstance] userToken]];
            }
        }else{
            [ZXHUD MBHideForView:self.view animate:true];
            [ZXHUD MBShowFailureInView:self.view text:errorMsg delay:1.2];
            checking = false;
            [self performSelector:@selector(checkEnvironmentAndRun) withObject:nil afterDelay:1.2];
        }
    }];
}

- (void)invalidStore{
    [ZXAlertUtils showAAlertMessage:@"店铺不存在或已过期" title:@"提示" buttonText:@"确定" buttonAction:^{
        [self checkEnvironmentAndRun];
    }];
}

#pragma mark 恢复动画
- (void)resumeAnimation
{
    CAAnimation *anim = [_animationImage.layer animationForKey:@"translationAnimation"];
    if(anim){
        // 1. 将动画的时间偏移量作为暂停时的时间点
        CFTimeInterval pauseTime = _animationImage.layer.timeOffset;
        // 2. 根据媒体时间计算出准确的启动动画时间，对之前暂停动画的时间进行修正
        CFTimeInterval beginTime = CACurrentMediaTime() - pauseTime;
        
        // 3. 要把偏移时间清零
        [_animationImage.layer setTimeOffset:0.0];
        // 4. 设置图层的开始动画时间
        [_animationImage.layer setBeginTime:beginTime];
        
        [_animationImage.layer setSpeed:1.0];
        
    }else{
        
        CGFloat scanNetImageViewH = self.scanFrame.frame.size.height;
        CGFloat scanNetImageViewW = self.scanFrame.frame.size.width;
        
        _animationImage.frame = CGRectMake(0, -scanNetImageViewH, scanNetImageViewW, scanNetImageViewH);
        CABasicAnimation *scanNetAnimation = [CABasicAnimation animation];
        scanNetAnimation.keyPath = @"transform.translation.y";
        scanNetAnimation.byValue = @(scanNetImageViewW);
        scanNetAnimation.duration = 1.0;
        scanNetAnimation.repeatCount = MAXFLOAT;
        [_animationImage.layer addAnimation:scanNetAnimation forKey:@"translationAnimation"];
        [self.scanFrame addSubview:_animationImage];
    }
}

#pragma mark - 获取扫描区域的比例关系
-(CGRect)getScanCrop:(CGRect)rect readerViewBounds:(CGRect)readerViewBounds
{
    CGFloat x,y,width,height;
    x = (CGRectGetHeight(readerViewBounds)-CGRectGetHeight(rect) - 120)/2/CGRectGetHeight(readerViewBounds);
    //针对navbar 调整一下
    y = (CGRectGetWidth(readerViewBounds)-CGRectGetWidth(rect))/2/CGRectGetWidth(readerViewBounds);
    width = CGRectGetHeight(rect)/CGRectGetHeight(readerViewBounds);
    height = CGRectGetWidth(rect)/CGRectGetWidth(readerViewBounds);
    return CGRectMake(x, y, width, height);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
