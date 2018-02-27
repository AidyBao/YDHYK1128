//
//  ZXMaxSpacingCCVLayout.swift
//  rbstore
//
//  Created by screson on 2017/7/31.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

class ZXMaxSpacingCCVLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let list = super.layoutAttributesForElements(in: rect) else {
            return nil
        }
        
        if list.count > 0 {
            let maxSpacing:CGFloat = 10
            
            for i in 0..<list.count {
                let current = list[i]
                if current.indexPath.row == 0 {
                    var frame = current.frame
                    frame.origin.x = 0
                    current.frame = frame
                } else {
                    let pre = list[i - 1]
                    let origin = pre.frame.maxX
                    if(origin + maxSpacing + current.frame.size.width < self.collectionViewContentSize.width && current.frame.origin.x > pre.frame.origin.x) {
                        var frame = current.frame
                        frame.origin.x = origin + maxSpacing
                        current.frame = frame
                    } else {//换行 靠左
                        var frame = current.frame
                        frame.origin.x = 0
                        current.frame = frame
                    }
                }
            }
        }
        return list
    }
}
