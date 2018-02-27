//
//  ZXActiveGoodsCell.swift
//  YDHYK
//
//  Created by screson on 2017/10/13.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

class ZXActiveGoodsCell: UICollectionViewCell {

    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var lbPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.lbPrice.font = UIFont.boldSystemFont(ofSize: zx_bodyFontSize())
        self.lbPrice.textColor = UIColor.zx_customB()
        self.lbPrice.text = ""
    }
    
    func reloadData(model: ZXDrugModel?) {
        self.imgIcon.image = nil
        self.lbPrice.text = ""
        
        if let model = model {
            if let first = model.attachFilesStrs.first,let url =  URL(string:first) {
                self.imgIcon.setImageWith(url, placeholderImage: UIImage.Default.empty)
            } else {
                self.imgIcon.image = UIImage.Default.empty
            }
            self.lbPrice.text = "\(model.zx_truePrice)".zx_priceString()
        }
    }

}
