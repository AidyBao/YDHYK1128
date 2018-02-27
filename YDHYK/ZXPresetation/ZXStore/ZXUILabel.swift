//
//  ZXUILabel.swift
//  YDY_GJ_3_5
//
//  Created by screson on 2017/4/21.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

@IBDesignable

class ZXUILabel: UILabel {
    enum ZXFType:Int {
        case title  = 0
        case body   = 1
        case mark   = 2
    }
    
    @IBInspectable  var typeIndex: Int = 0{
        didSet{
            self.type = ZXFType.init(rawValue: typeIndex) ?? ZXFType.title
        }
    }
    
    @IBInspectable  var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius  = cornerRadius
            layer.masksToBounds = true
        }
    }
    
    @IBInspectable var borderColor:UIColor = UIColor () {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    var type:ZXFType = ZXFType.title {
        didSet{
            self.buildUI()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.buildUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.buildUI()
    }
    
    fileprivate func buildUI() {
        switch type {
            case .title:
                self.font = UIFont.zx_titleFont(withSize: zx_title1FontSize())
                self.textColor = UIColor.zx_text()
            case .body:
                self.font = UIFont.zx_bodyFont(withSize: zx_bodyFontSize())
                self.textColor = UIColor.zx_sub1Text()
            case .mark:
                self.font = UIFont.zx_bodyFont(withSize: zx_bodyFontSize() - 2)
                self.textColor = UIColor.zx_sub2Text()
        }
    }
    
    func fontSize(_ size:CGFloat) {
        let fontName = self.font.fontName
        self.font = UIFont.init(name: fontName, size: size)
    }
}

//MARK: - Define
struct ZX {
    static let BOUNDS_WIDTH     = UIScreen.main.bounds.size.width
    static let BOUNDS_HEIGHT    = UIScreen.main.bounds.size.height
    static let DELAY_INTERVAL   = 1.25
}

//MARK: - Reuseable
protocol ReuseableView: class {}

extension ReuseableView where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

protocol NibLoadableView: class {}

extension NibLoadableView where Self: UIView {
    static var NibName: String {
        return String(describing: self)
    }
}


extension UITableViewCell: ReuseableView,NibLoadableView {}

extension UICollectionViewCell: ReuseableView,NibLoadableView {}

extension UITableViewHeaderFooterView: ReuseableView, NibLoadableView{}

