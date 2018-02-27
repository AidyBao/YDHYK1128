//
//  ZXSexAgeInputTableCell.h
//  YDHYK
//
//  Created by screson on 2016/12/19.
//  Copyright © 2016年 screson. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ZX_ITEMAGE_TXT_TAG 200200

@class ZXSexAgeInputTableCell;

@protocol ZXSexAgeInputTableCellDelegate <NSObject>

@optional
- (void)sexAgeInputTableCellDidSexSelected:(NSInteger)sex sexTitle:(NSString *)sexTitle cell:(ZXSexAgeInputTableCell *)cell;
- (void)sexAgeInputTableCellDidAgeInputed:(NSString *)age textField:(UITextField *)textF cell:(ZXSexAgeInputTableCell *)cell;

@end

/**新增化验单-性别年龄录入*/
@interface ZXSexAgeInputTableCell : UITableViewCell<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lbSexTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnSex;
@property (weak, nonatomic) IBOutlet UILabel *lbAgeTitle;
@property (weak, nonatomic) IBOutlet UITextField *txtAgeInput;

@property (nonatomic,weak) id<ZXSexAgeInputTableCellDelegate> delegate;

- (void)reloadSex:(NSString *)sex age:(NSString *)age;

@end
