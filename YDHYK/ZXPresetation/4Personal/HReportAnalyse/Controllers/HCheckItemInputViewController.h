//
//  HCheckItemInputViewController.h
//  YDHYK
//
//  Created by screson on 2016/12/13.
//  Copyright © 2016年 screson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HItemTypeModel.h"
#import "HItemModel.h"

typedef enum : NSUInteger {
    HItemDataInputTypeRefrence, //参考值
    HItemDataInputTypeResult    //结果值
} HItemDataInputType;

typedef void(^ZXRefrenceValue)(HItemResultType type,NSString * minRef,NSString * maxRef,NSString * refValue,NSInteger selIndex);

typedef void(^ZXResultValue)(HItemResultType type,NSInteger selIndex,NSString * resultValue);

/**检查项数据-输入 选择*/
@interface HCheckItemInputViewController : UIViewController

@property (nonatomic,copy) ZXRefrenceValue refrenceValueCompletion;
@property (nonatomic,copy) ZXResultValue   resultValueCompletion;


/**弹出参考值选择界面
 *dataOnly    是否跳过类型选择，直接选择或输入数据
 *typeIndex   跳过选择 typeindex
 */

+ (void)showRefrenceDataSelectOnVC:(UIViewController *)vc
                          dataOnly:(BOOL)dataOnly
                         typeIndex:(NSInteger)typeIndex
                        completion:(ZXRefrenceValue)completion;
/**弹出结果值选择界面
 *dataOnly    是否跳过类型选择，直接选择或输入数据
 *typeIndex   跳过选择 typeindex
 */
+ (void)showResultDataSelectOnVC:(UIViewController *)vc
                        dataOnly:(BOOL)dataOnly
                       typeIndex:(NSInteger)typeIndex
                      completion:(ZXResultValue)completion;

@end
