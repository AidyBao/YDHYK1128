//
//  HDiscoverCollectionViewDelegateFlowLayout.h
//  YDHYK
//
//  Created by JuanFelix on 01/12/2016.
//  Copyright © 2016 screson. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HDiscoverViewController;

@interface HDiscoverCollectionViewDelegateFlowLayout : NSObject <UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic,weak) HDiscoverViewController * discoverVC;

@end
