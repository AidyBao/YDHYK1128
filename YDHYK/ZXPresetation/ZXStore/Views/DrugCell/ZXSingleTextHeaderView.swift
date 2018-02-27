//
//  ZXSingleTextHeaderView.swift
//  YDY_GJ_3_5
//
//  Created by screson on 2017/5/16.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

class ZXSingleTextHeaderView: UITableViewHeaderFooterView {
    
    fileprivate var btnText = UIButton(type: .custom)
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = UIColor.white
        self.contentView.addSubview(btnText)
        
        self.btnText.isUserInteractionEnabled = false
        self.btnText.titleLabel?.font = UIFont.zx_titleFont(withSize: 15)
        self.btnText.setTitleColor(UIColor.zx_tint(), for: .normal)
        self.contentView.clipsToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.btnText.frame = self.contentView.frame
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setText(_ text:String,image:UIImage?) {
        if let image = image {
            self.btnText.setImage(image, for: .normal)
            self.btnText.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
        } else {
            self.btnText.setImage(nil, for: .normal)
            self.btnText.titleEdgeInsets = UIEdgeInsets.zero
        }
        self.btnText.setTitle(text, for: .normal)
    }
}
