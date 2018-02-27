//
//  ZXBuyCountCollectionReusableView.swift
//  YDHYK
//
//  Created by screson on 2017/10/19.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

protocol ZXCartControlProtocol: class {
    func zxCartChangeSpec(for cell:UIView)
    func zxCartChecked(_ check:Bool,cell:UIView)
    func zxCartAddOne(for cell:UIView)
    func zxCartSubOne(for cell:UIView)
}

extension ZXCartControlProtocol {
    func zxCartChangeSpec(for cell:UIView) {}
    func zxCartChecked(_ check:Bool,cell:UIView) {}
    func zxCartAddOne(for cell:UIView) {}
    func zxCartSubOne(for cell:UIView) {}
}

class ZXBuyCountCollectionReusableView: UICollectionReusableView {

    weak var delegate:ZXCartControlProtocol?
    
    @IBOutlet weak var lbNum: ZXUILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func subAction(_ sender: Any) {
        delegate?.zxCartSubOne(for: self)
    }
    
    @IBAction func plusAction(_ sender: Any) {
        delegate?.zxCartAddOne(for: self)
    }
    
}
