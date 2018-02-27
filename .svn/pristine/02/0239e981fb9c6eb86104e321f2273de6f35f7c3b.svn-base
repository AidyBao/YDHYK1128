//
//  ZXOrderAddressCell.swift
//  YDHYK
//
//  Created by screson on 2017/10/25.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

class ZXOrderAddressCell: UITableViewCell {

    @IBOutlet weak var receiverContentView: UIView!
    @IBOutlet weak var lbName: ZXUILabel!
    @IBOutlet weak var lbTel: ZXUILabel!
    @IBOutlet weak var lbAddress: ZXUILabel!
    @IBOutlet weak var lbIsDefault: ZXUILabel!
    
    @IBOutlet weak var lbInputAddress: ZXUILabel!
    
    @IBOutlet weak var imgLine: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        self.imgLine.backgroundColor = UIColor.init(patternImage: #imageLiteral(resourceName: "location-border"))
        self.lbIsDefault.textColor = UIColor.zx_customB()
        self.lbIsDefault.layer.borderColor = UIColor.zx_customB().cgColor
        self.lbInputAddress.isHidden = true
        self.receiverContentView.isHidden = true
        self.lbName.text = ""
        self.lbTel.text = ""
        self.lbAddress.text = ""
        self.lbIsDefault.isHidden = true
    }

    func reloadData(address: ZXBalanceAddress?) {
        if let address = address {
            self.receiverContentView.isHidden = false
            self.lbInputAddress.isHidden = true
            self.lbIsDefault.isHidden = address.zx_isDefault ? false : true
            self.lbName.text = address.consignee
            self.lbTel.text = address.tel
            self.lbAddress.text = address.zx_address
        } else {
            self.receiverContentView.isHidden = true
            self.lbInputAddress.isHidden = false
        }
    }
    
}
