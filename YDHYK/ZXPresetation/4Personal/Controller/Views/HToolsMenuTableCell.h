//
//  HToolsMenuTableCell.h
//  YDHYK
//
//  Created by JuanFelix on 05/12/2016.
//  Copyright © 2016 screson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HPersonalMenuActionProtocol.h"
/**我的工具菜单*/
@interface HToolsMenuTableCell : UITableViewCell<HPersonalMenuActionProtocol>

@property (nonatomic,weak) id<HPersonalMenuActionProtocol> delegate;

@end
