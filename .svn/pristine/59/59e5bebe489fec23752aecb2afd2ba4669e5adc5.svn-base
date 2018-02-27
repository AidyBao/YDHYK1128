//
//  HTakePhotoViewController.m
//  ydhyk
//
//  Created by screson on 2016/11/22.
//  Copyright © 2016年 120v. All rights reserved.
//

#import "HTakePhotoViewController.h"
#import <AVFoundation/AVFoundation.h>


@interface HTakePhotoViewController ()<AVCapturePhotoCaptureDelegate>

@property (nonatomic, strong) AVCaptureSession * session;
@property (nonatomic, strong) AVCaptureDeviceInput * videoInput;
@property (nonatomic, strong) AVCaptureStillImageOutput * stillImageOutput;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer * previewLayer;
/**提示文字*/
@property (weak, nonatomic) IBOutlet UILabel *lbTips;
/**拍摄预览*/
@property (weak, nonatomic) IBOutlet UIView *previewView;

@property (weak, nonatomic) IBOutlet UIView *controlView;

@property (weak, nonatomic) IBOutlet UIButton *btnChoosePhoto;
@property (weak, nonatomic) IBOutlet UIButton *btnTakePhoto;
@property (weak, nonatomic) IBOutlet UIButton *btnClose;

@end

@implementation HTakePhotoViewController

//- (instancetype)init{
//    return [self initWithNibName:@"HTakePhotoViewController" bundle:nil];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //
    [self.lbTips setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.8]];
    [self.lbTips.layer setMasksToBounds:true];
    [self.lbTips.layer setCornerRadius:5.0];
    [self.lbTips setFont:[UIFont zx_titleFontWithSize:14]];
    [self.lbTips setTextColor:[UIColor zx_tintColor]];
    //
    [self.btnChoosePhoto setImage:[UIImage imageNamed:@"h_photofromphone-down"] forState:UIControlStateHighlighted];
    [self.btnTakePhoto setImage:[UIImage imageNamed:@"h_takephoto-down"] forState:UIControlStateHighlighted];
    [self.btnClose setImage:[UIImage imageNamed:@"h_cameraclose-down"] forState:UIControlStateHighlighted];
    
    if ([self isCameraAvailable]) {
        [self initialSession];
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if ([self isCameraAvailable]) {
        [self setUpCameralayer];
        
        if (self.session) {
            [self.session startRunning];
            [self checkEnvironmentAndRun];
        }
    }else{
        [ZXAlertUtils showAAlertMessage:@"该设备相机不可用" title:@"提示"];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.35 animations:^{
            [self.lbTips setAlpha:0];
        } completion:^(BOOL finished) {
            [self.lbTips removeFromSuperview];
        }];
    });
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    if (self.session) {
        [self.session stopRunning];
    }
}

- (AVCaptureDevice *)cameraWithPostition:(AVCaptureDevicePosition)position {
    NSArray * devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice * device in devices) {
        if ([device position] == position) {
            return device;
        }
    }
    return nil;
}

- (void)initialSession{
        self.session = [[AVCaptureSession alloc]  init];
        self.videoInput = [[AVCaptureDeviceInput alloc] initWithDevice:[self backCamera] error:nil];
        self.stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
        
        NSDictionary * outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys:AVVideoCodecJPEG,AVVideoCodecKey, nil];
        [self.stillImageOutput setOutputSettings:outputSettings];
        if ([self.session canAddInput:self.videoInput]) {
            [self.session addInput:self.videoInput];
        }
        if ([self.session canAddOutput:self.stillImageOutput]) {
            [self.session addOutput:self.stillImageOutput];
        }
}

- (AVCaptureDevice *)frontCamera{
    return [self cameraWithPostition:AVCaptureDevicePositionFront];
}

- (AVCaptureDevice *)backCamera{
    return [self cameraWithPostition:AVCaptureDevicePositionBack];
}

- (void)setUpCameralayer{
    if (self.previewLayer == nil) {
        self.previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
        //        self.previewLayer.orientation
        self.previewLayer.connection.videoOrientation = AVCaptureVideoOrientationLandscapeRight;
        UIView * view = self.previewView;
        CALayer * viewLayer = [view layer];
        [viewLayer setMasksToBounds:true];
        
        [self.previewLayer setFrame:self.previewView.bounds];
        [self.previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
        [viewLayer insertSublayer:self.previewLayer below:[[viewLayer sublayers] objectAtIndex:0]];
    }
}


- (void)checkEnvironmentAndRun{
    AVAuthorizationStatus  authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    switch (authStatus) {
        case AVAuthorizationStatusAuthorized:
        {
            [self initCamera];
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
                        [self initCamera];
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


- (void)initCamera {
    NSUInteger cameraCount = [[AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo] count];
    if (cameraCount > 1) {
        NSError *error;
        AVCaptureDeviceInput * newVideoInput = [[AVCaptureDeviceInput alloc] initWithDevice:[self backCamera] error:&error];
        if (newVideoInput != nil) {
            [self.session beginConfiguration];
            [self.session removeInput:self.videoInput];
            if ([self.session canAddInput:newVideoInput]) {
                [self.session addInput:newVideoInput];
                [self setVideoInput:newVideoInput];
            } else {
                [self.session addInput:self.videoInput];
            }
            [self.session commitConfiguration];
        } else if (error) {
            NSLog(@"init camera failed, error = %@", error);
        }
    }
}

- (BOOL)isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

//相册选取
- (IBAction)choosePhotoAction:(id)sender {
    
}

//拍照
- (IBAction)takePhotoAction:(id)sender {
    if ([self isCameraAvailable]) {
        AVCaptureConnection * videoConnection = [self.stillImageOutput connectionWithMediaType:AVMediaTypeVideo];
        if (!videoConnection) {
            NSLog(@"take photo failed!");
            return;
        }
        [self.stillImageOutput captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
            if (imageDataSampleBuffer == NULL) {
                return;
            }
            NSData * imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
            UIImage * image = [UIImage imageWithData:imageData];
            NSLog(@"image size = %@",NSStringFromCGSize(image.size));
        }];
    }
}


- (IBAction)closeAction:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -

- (BOOL)shouldAutorotate{
    return false;
}


- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskLandscapeRight;
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
