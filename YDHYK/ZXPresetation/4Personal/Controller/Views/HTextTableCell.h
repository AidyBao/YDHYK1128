//
//  HTextTableCell.h
//  YDHYK
//
//  Created by JuanFelix on 05/12/2016.
//  Copyright © 2016 screson. All rights reserved.
//

#import <UIKit/UIKit.h>
/**单行文字+右边事件文本 CELL*/
@interface HTextTableCell : UITableViewCell

/**设置左右文字
 */
- (void)setTitle:(NSString *)title
      extralInfo:(NSString *)extralInfo
       showArrow:(BOOL)showArrow;

@end
