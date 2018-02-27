//
//  ZXBalanceOrderLRTextCell.swift
//  YDHYK
//
//  Created by screson on 2017/10/25.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

class ZXBalanceOrderLRTextCell: UITableViewCell {

    @IBOutlet weak var lbLeftText: UILabel!
    @IBOutlet weak var lbRightText: UILabel!
    
    @IBOutlet weak var imgArrow: UIImageView!
    
    @IBOutlet weak var lbCouponLabel: UILabel!
    @IBOutlet weak var lbRightOffset: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        self.lbLeftText.font = UIFont.zx_titleFont(withSize: zx_bodyFontSize())
        self.lbLeftText.textColor = UIColor.zx_sub2Text()
        
        self.lbRightText.font = UIFont.zx_titleFont(withSize: zx_bodyFontSize())
        self.lbRightText.textColor = UIColor.zx_text()
        
        self.lbLeftText.text = ""
        self.lbRightText.text = ""
        self.imgArrow.isHidden = true
        self.lbCouponLabel.text = ""
        self.lbCouponLabel.isHidden = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func showRightArrow(_ show: Bool) {
        if show {
            self.imgArrow.isHidden = false
            self.lbRightOffset.constant = 5
        } else {
            self.imgArrow.isHidden = true
            self.lbRightOffset.constant = -10
        }
    }
}
