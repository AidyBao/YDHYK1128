//
//  ZXBalanceOrderFooterCell.swift
//  YDHYK
//
//  Created by screson on 2017/10/25.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

class ZXBalanceOrderFooterCell: UITableViewCell {

    @IBOutlet weak var lbText: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        self.lbText.font = UIFont.zx_titleFont(withSize: zx_bodyFontSize())
        self.lbText.textColor = UIColor.zx_sub2Text()
        self.lbText.text = ""
    }

    func reloadData(store: ZXStoreDetailModel?) {
        if let store = store {
            let count = store.drugCounterList.count
            let freight = store.zx_freightInfo
            let totalPrice = "\(store.zx_balanceTotalPrice)".zx_priceString()
            let attr = NSMutableAttributedString.init(string: "共\(count)件商品 小计(\(freight)): ")
            let price = NSMutableAttributedString.init(string: totalPrice)
            price.zx_append(UIFont.zx_titleFont(withSize: zx_title2FontSize()), at: NSMakeRange(0, totalPrice.characters.count))
            price.zx_append(UIColor.zx_customB(), at: NSMakeRange(0, totalPrice.characters.count))
            attr.append(price)
            self.lbText.attributedText = attr
        } else {
            self.lbText.text = ""
        }
    }
    
}
