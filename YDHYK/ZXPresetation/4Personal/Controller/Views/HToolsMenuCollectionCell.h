//
//  HToolsMenuCollectionCell.h
//  YDHYK
//
//  Created by JuanFelix on 05/12/2016.
//  Copyright © 2016 screson. All rights reserved.
//

#import <UIKit/UIKit.h>

/**用药提醒、化验单分析...菜单Cell*/
@interface HToolsMenuCollectionCell : UICollectionViewCell

- (void)setTitle:(NSString *)title
           image:(NSString *)image;

- (void)setUNReadMessageCount:(NSInteger)count;

@end
