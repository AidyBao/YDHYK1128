//
//  FAFCreatQRTool.m
//  FAFFramework
//
//  Created by Bob on 15/12/30.
//  Copyright © 2015年 FastAndFurious. All rights reserved.
//

#import "FAFCreatQRTool.h"

@implementation FAFCreatQRTool
/**
 *  生成二维码，默认大小是500*500
 *
 *  @param qrStr
 *
 *  @return UIImage
 */
-(UIImage* )faf_creatQRWithString:(NSString *)qrStr{
    //创建过滤器
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    //
    NSData *data = [qrStr dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKey:@"inputMessage"];
    CIImage *outputImage = [filter outputImage];
    return  [self faf_convertImageFromCIImage:outputImage withSize:500.0];
}
/**
 *  将生成的模糊图片变成清晰图片
 *
 *  @param image image description
 *
 *  @param size  转化后的图片大小（正方形的）
 *
 *  @return UIImage
 */
-(UIImage *)faf_convertImageFromCIImage:(CIImage*) image withSize:(CGFloat)size{
    
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    //创建bitMap
    size_t width = CGRectGetWidth(extent)*scale;
    size_t height = CGRectGetHeight(extent)*scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs,(CGBitmapInfo) kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    //保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

@end
