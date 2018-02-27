//
//  ZXBalanceCouponCell.swift
//  YDHYK
//
//  Created by screson on 2017/10/26.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

protocol ZXBalanceCouponDelegate: class {
    func zxBalanceCouponCellSelect(at cell: ZXBalanceCouponCell)
    func zxBalanceCouponCellDeSelect(at cell: ZXBalanceCouponCell)
}

class ZXBalanceCouponCell: UITableViewCell {
    weak var delegate: ZXBalanceCouponDelegate?
    
    @IBOutlet weak var lbLeftDot: UIView!
    @IBOutlet weak var lbRightDot: UIView!
    @IBOutlet weak var couponBackView: UIView!
    @IBOutlet weak var topInfoView: UIView!
    
    @IBOutlet weak var imgGroupIcon: UIImageView!
    @IBOutlet weak var lbGroupName: UILabel!
    @IBOutlet weak var lbCouponPriceInfo: UILabel!
    
    @IBOutlet weak var btnUse: UIButton!
    
    @IBOutlet weak var bottomInfoView: UIView!
    @IBOutlet weak var lbFullMoneyInfo: UILabel!
    @IBOutlet weak var lbValidDateInfo: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        self.contentView.backgroundColor = .clear
        self.backgroundColor = .clear
        
        self.couponBackView.backgroundColor = UIColor.white
        self.couponBackView.layer.cornerRadius = 5
        self.couponBackView.layer.masksToBounds = true
        self.couponBackView.clipsToBounds = true
        
        self.lbLeftDot.layer.cornerRadius = 5
        self.lbLeftDot.layer.masksToBounds = true
        self.lbLeftDot.backgroundColor = UIColor.zx_assist()
        
        self.lbRightDot.layer.cornerRadius = 5
        self.lbRightDot.layer.masksToBounds = true
        self.lbRightDot.backgroundColor = UIColor.zx_assist()
        
        self.topInfoView.backgroundColor = UIColor.zx_customC()
        self.bottomInfoView.backgroundColor = UIColor.white

        self.imgGroupIcon.layer.cornerRadius = 23
        self.imgGroupIcon.layer.masksToBounds = true
        
        self.lbGroupName.font = UIFont.zx_bodyFont(withSize: zx_bodyFontSize() - 1)
        
        self.lbFullMoneyInfo.font = UIFont.zx_bodyFont(withSize: zx_bodyFontSize() - 1)
        self.lbValidDateInfo.font = UIFont.zx_bodyFont(withSize: zx_bodyFontSize() - 1)
        
        self.lbCouponPriceInfo.font = UIFont.zx_titleFont(withSize: zx_title1FontSize())
        
        self.btnUse.layer.borderColor = UIColor.white.cgColor
        self.btnUse.layer.borderWidth = 1.0
        self.btnUse.layer.cornerRadius = 3
        
        self.lbGroupName.text = ""
        self.lbCouponPriceInfo.text = ""
        self.lbFullMoneyInfo.text = ""
        self.lbValidDateInfo.text = ""
        self.btnUse.setTitle("使用", for: .normal)
        self.btnUse.setTitle("已选", for: .selected)
        self.btnUse.setImage(#imageLiteral(resourceName: "coupon_check"), for: .selected)
    }
    
    func reloadData(coupon: ZXOrderCouponModel?) {
        self.lbGroupName.text = ""
        self.lbCouponPriceInfo.text = ""
        self.lbFullMoneyInfo.text = ""
        self.lbValidDateInfo.text = ""
        if let coupon = coupon {
            if let url = coupon.url {
                self.imgGroupIcon.setImageWith(url, placeholderImage: UIImage.Default.empty)
            }
            self.imgGroupIcon.image = UIImage.Default.empty
            self.lbGroupName.text = coupon.groupName
            self.lbCouponPriceInfo.text = coupon.zx_valueInfo
            self.lbFullMoneyInfo.text = coupon.zx_couponDescription
            self.lbValidDateInfo.text = coupon.zx_expiredDesc
            self.btnUse.isSelected = coupon.zx_isSelected
            self.btnUse.isEnabled = coupon.zx_valid
            if coupon.zx_valid {
                self.topInfoView.backgroundColor = UIColor.zx_customC()
            } else {
                self.topInfoView.backgroundColor = UIColor.lightGray
            }
        }
    }
    
    @IBOutlet weak var userAction: UIButton!
    
    @IBAction func useCouponAction(_ sender: UIButton) {
        if self.btnUse.isSelected {
            delegate?.zxBalanceCouponCellDeSelect(at: self)
            self.btnUse.isSelected = false
        } else {
            delegate?.zxBalanceCouponCellSelect(at: self)
            self.btnUse.isSelected = true
        }
    }
}
