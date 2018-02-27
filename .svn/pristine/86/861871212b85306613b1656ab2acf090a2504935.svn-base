//
//  FAFLongPressRecognitionQRTool.m
//  FAFFramework
//
//  Created by bobo on 16/1/6.
//  Copyright © 2016年 FastAndFurious. All rights reserved.
//

#import "FAFLongPressRecognitionQRTool.h"

@interface FAFLongPressRecognitionQRTool ()
@end

@implementation FAFLongPressRecognitionQRTool
/**
 *  初始化长按识别二维码，注意与外面手势重复或冲突
 *
 *  @param controller 需要添加长按识别二维码的控制器
 *  @param block      回调
 *
 *  @return self
 */
-(instancetype)initWithLongPressRecognitionQRAddToViewController:(UIViewController*)controller Block:(FAFLongPressRecognitionQRBlock)block{
    self = [super init];
    if (self) {
        self.viewController = controller;
        self.block =block;
        [self addLongPressRecognitionQRToController];
    }
    return self;
}
/**
 *  给View添加长按手势
 */
-(void)addLongPressRecognitionQRToController{
    
    UILongPressGestureRecognizer*longPress=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(dealLongPress:)];
    [ self.viewController.view addGestureRecognizer:longPress];
}
#pragma mark-> 长按识别二维码
-(void)dealLongPress:(UIGestureRecognizer*)gesture{
    
    
    if(gesture.state==UIGestureRecognizerStateBegan){
        
        UIImage *tempImage = [self screenShot];
        if(tempImage){
            //1. 初始化扫描仪，设置设别类型和识别质量
            CIDetector*detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{ CIDetectorAccuracy : CIDetectorAccuracyLow }];
            //2. 扫描获取的特征组
            NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:tempImage.CGImage]];
            //3. 获取扫描结果
            if (features.count>0) {
                CIQRCodeFeature *feature = [features objectAtIndex:0];
                NSString *scannedResult = feature.messageString;
                self.block(scannedResult);
            }else{
                self.block(nil);
                UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"扫描结果" message:@"没有可扫描的二维码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertView show];
                
            }
            
        }else {
            
            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"扫描结果" message:@"您还没有生成二维码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        }
        
        
    }else if (gesture.state==UIGestureRecognizerStateEnded){
        
    }
    
}
/**
 *  截取当前屏幕生成图片
 *
 *  @return UIImage
 */
-(UIImage*)screenShot{
    UIGraphicsBeginImageContext(self.viewController.view.bounds.size);
    [self.viewController.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image ;
}

@end
