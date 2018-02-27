//
//  FAFCreatQRTool.h
//  FAFFramework
//
//  Created by Bob on 15/12/30.
//  Copyright © 2015年 FastAndFurious. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FAFCreatQRTool : NSObject
/**
 *  根据字符串生成二维码
 *
 *  @param qrStr 需要转换成二维码的字符串
 *
 *  @return UIImage
 */
-(UIImage* )faf_creatQRWithString:(NSString *)qrStr;
@end
