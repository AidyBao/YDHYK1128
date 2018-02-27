//
//  HItemInputHeader.h
//  YDHYK
//
//  Created by screson on 2016/12/19.
//  Copyright © 2016年 screson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXCheckItemListModel.h"

#define ZX_ITEMSEARCH_TXT_TAG 200100
#define ZX_ITEMSEARCH_ADDBUTTON_TAG 200102

/**检查项检索*/
@class HItemInputHeader;

@protocol HItemInputHeaderDelegate <NSObject>

@optional

/**TextFiled右侧列表选择点击*/
- (void)inputHeaderSelectItemAction:(HItemInputHeader *)header;
/**添加按钮事件*/
- (void)inputHeaderDidAddedItem:(id)item;

- (void)inputHeaderSearchResultChangeWithItemList:(NSArray<ZXCheckItemListModel *> *)list;

@end

/**化验单录入-检查项搜索 添加*/
@interface HItemInputHeader : UITableViewHeaderFooterView<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *txtfItemSearch;
@property (weak, nonatomic) IBOutlet ZXTintButton *btnAdd;

@property (nonatomic,weak) id<HItemInputHeaderDelegate> delegate;

@end
