//
//  HPHeaderView.h
//  YDHYK
//
//  Created by JuanFelix on 05/12/2016.
//  Copyright © 2016 screson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HPersonalMenuActionProtocol.h"

/**个人中心 顶部个人中心*/
@interface HPHeaderView : UIView<HPersonalMenuActionProtocol>

@property (nonatomic,weak) id<HPersonalMenuActionProtocol> delegate;

- (void)refreshData;

@end
