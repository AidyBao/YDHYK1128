//
//  AZXBalanceOrderGoodsCCVCell.swift
//  YDHYK
//
//  Created by screson on 2017/10/25.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

class AZXBalanceOrderGoodsCCVCell: UICollectionViewCell {

    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbCount: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.lbName.font = UIFont.zx_bodyFont(withSize: zx_bodyFontSize() - 2)
        self.lbName.textColor = UIColor.zx_sub2Text()
        
        self.lbCount.font = UIFont.zx_bodyFont(withSize: zx_bodyFontSize() - 2)
        self.lbCount.textColor = UIColor.zx_sub2Text()
        
        self.lbName.text = ""
        self.lbCount.text = ""
    }
    
    func reloadData(drug: ZXDrugModel?) {
        self.lbName.text = ""
        self.lbCount.text = ""
        self.imgIcon.image = nil
        if let drug = drug {
            if let url = drug.zx_imageUrl {
                self.imgIcon.setImageWith(url,placeholderImage: UIImage.Default.drug)
            } else {
                self.imgIcon.image = UIImage.Default.drug
            }
            self.lbName.text = drug.drugName
            self.lbCount.text = "x\(drug.num)"
        }
    }

}
