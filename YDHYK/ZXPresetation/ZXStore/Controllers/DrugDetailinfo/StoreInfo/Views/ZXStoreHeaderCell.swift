//
//  ZXStoreHeaderCell.swift
//  YDHYK
//
//  Created by screson on 2017/10/18.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit


/// 店铺详情 - 名称、标签
class ZXStoreHeaderCell: UITableViewCell {

    @IBOutlet weak var lbStoreName: UILabel!
    @IBOutlet weak var lbPromise: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.lbPromise.font = UIFont.zx_bodyFont(withSize: zx_bodyFontSize() - 2)
        self.lbPromise.textColor = UIColor.zx_text()

        self.selectionStyle = .none
        self.lbStoreName.text = ""
        self.lbPromise.text = ""

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func reloadData(model: ZXStoreDetailModel?) {
        if let model = model {
            self.lbStoreName.text = model.name
            self.lbPromise.attributedText = model.zx_promiseAttributeString
        }
    }
    
}
