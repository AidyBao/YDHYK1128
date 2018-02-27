//
//  ZXStoreHeaderView.swift
//  ZXStore
//
//  Created by screson on 2017/10/10.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

class ZXStoreHeaderView: UIView {
    var categoryView:ZXStoreCategoryView!
    var searchButton: UIButton!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    convenience init(origin: CGPoint) {
        self.init(frame: CGRect(x: origin.x, y: origin.y, width: ZX.BOUNDS_WIDTH, height: 250))
        self.backgroundColor = UIColor.zx_assist()
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: ZX.BOUNDS_WIDTH, height: 70))
        view.backgroundColor = UIColor.zx_tint()
        self.addSubview(view)
        
        searchButton = UIButton.init(type: .custom)
        searchButton.frame = CGRect(x: 10, y: 10, width: ZX.BOUNDS_WIDTH - 20, height: 40)
        searchButton.backgroundColor = .white
        searchButton.layer.cornerRadius = 5
        searchButton.setTitle("搜索药品名、适应症或功能主治", for: .normal)
        searchButton.titleLabel?.font = UIFont.zx_bodyFont(withSize: zx_bodyFontSize() - 1)
        searchButton.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0)
        searchButton.setImage(UIImage.init(named: "dk_search_gray"), for: .normal)
        searchButton.tintColor = UIColor.lightGray
        searchButton.setTitleColor(.lightGray, for: .normal)
        view.addSubview(searchButton)
        
        
        categoryView = ZXStoreCategoryView.init(origin: CGPoint(x: 0, y: 60))
        self.addSubview(categoryView)
    }

}
