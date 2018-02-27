//
//  HDrugNoticeViewController.h
//  YDHYK
//
//  Created by screson on 2016/12/26.
//  Copyright © 2016年 screson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXDrugNoticeControlViewModel.h"

@interface HDrugNoticeViewController : UIViewController

//@property (nonatomic,copy) NSString * remindIds;
@property (nonatomic,copy) NSString * remindTime;
@property (nonatomic,strong) NSArray<ZXTakeMedicineModel *> * list;

@end
