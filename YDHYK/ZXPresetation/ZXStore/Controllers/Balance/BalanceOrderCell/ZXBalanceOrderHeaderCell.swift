//
//  ZXBalanceOrderHeaderCell.swift
//  YDHYK
//
//  Created by screson on 2017/10/25.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

class ZXBalanceOrderHeaderCell: UITableViewCell {

    @IBOutlet weak var imgStoreIcon: UIImageView!
    @IBOutlet weak var lbStoreName: ZXUILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        self.lbStoreName.text = ""
    }

    func reloadData(store: ZXStoreDetailModel?) {
        self.imgStoreIcon.image = UIImage.Default.drug
        if let store = store {
            self.lbStoreName.text = store.name
            if let url = URL.init(string: ZXIMG_Address(store.headPortrait) ) {
                self.imgStoreIcon.setImageWith(url,placeholderImage: UIImage.Default.drug)
            }
        }
    }
    
}
