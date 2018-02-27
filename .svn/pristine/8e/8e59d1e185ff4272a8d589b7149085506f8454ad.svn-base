//
//  FAFLongPressRecognitionQRTool.h
//  FAFFramework
//
//  Created by bobo on 16/1/6.
//  Copyright © 2016年 FastAndFurious. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^FAFLongPressRecognitionQRBlock) (NSString *str);

@interface FAFLongPressRecognitionQRTool : NSObject

@property(nonatomic,strong)UIViewController *viewController;
@property(nonatomic,copy)FAFLongPressRecognitionQRBlock block;
/**
 *  使用说明：直接初始化即可，需要将其申明为全局变量或属性
 *  初始化长按识别二维码，注意与外面手势重复或冲突
 *  初始化时就给界面添加了长按手势
 *
 *  @param controller 需要添加长按识别二维码的控制器
 *  @param block      回调
 *
 *  @return self
 */
-(instancetype)initWithLongPressRecognitionQRAddToViewController:(UIViewController*)controller Block:(FAFLongPressRecognitionQRBlock)block;
@end
