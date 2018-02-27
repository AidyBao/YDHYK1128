//
//  ZXRButton.swift
//  rbstore
//
//  Created by screson on 2017/7/25.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

@IBDesignable
class ZXRButton: UIButton {

    @IBInspectable var colorType: Int = 2
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override class var layerClass:Swift.AnyClass { return CAGradientLayer.self }
    
    fileprivate var disabelColor: UIColor {
        get {
            if colorType == 1 {
                return UIColor.init(red: 178 / 255.0, green: 181 / 255.0, blue: 186 / 255.0, alpha: 1.0)
            } else {
                return UIColor.init(red: 188 / 255.0, green: 188 / 255.0, blue: 188 / 255.0, alpha: 1.0)
            }
        }
    }
    
    fileprivate var startColor: UIColor {
        get {
            if colorType == 1 {
                return UIColor.init(red: 247 / 255.0, green: 140 / 255.0, blue: 2 / 255.0, alpha: 1.0)
            } else {
                return UIColor.init(red: 233 / 255.0, green: 30 / 255.0, blue: 99 / 255.0, alpha: 1.0)
            }
        }
    }
    
    fileprivate var endColor: UIColor {
        get {
            if colorType == 1 {
                return UIColor.init(red: 244 / 255.0, green: 162 / 255.0, blue: 45 / 255.0, alpha: 1.0)
            } else {
                return UIColor.init(red: 240 / 255.0, green: 54 / 255.0, blue: 71 / 255.0, alpha: 1.0)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.clear
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.configUI()
    }
    
    func configUI() {
        if isEnabled {
            if let layer = self.layer as? CAGradientLayer {
                layer.colors = [startColor.cgColor,endColor.cgColor]
                layer.locations = [NSNumber.init(value: 0),NSNumber.init(value: 1)]
                layer.startPoint = CGPoint(x: 0, y: 0.5)
                layer.endPoint = CGPoint(x: 1, y: 0.5)
            }
            self.titleLabel?.font = UIFont.zx_titleFont(withSize: zx_title2FontSize())
            self.setTitleColor(UIColor.white, for: .normal)
        } else {
            if let layer = self.layer as? CAGradientLayer {
                layer.colors = [disabelColor.cgColor,disabelColor.cgColor]
                layer.locations = [NSNumber.init(value: 0),NSNumber.init(value: 1)]
                layer.startPoint = CGPoint(x: 0, y: 0.5)
                layer.endPoint = CGPoint(x: 1, y: 0.5)
            }
            self.titleLabel?.font = UIFont.zx_titleFont(withSize: zx_title2FontSize())
            self.setTitleColor(UIColor.white, for: .normal)
        }
    }
}
