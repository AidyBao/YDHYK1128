//
//  ZXStoreContactInfoCell.swift
//  YDHYK
//
//  Created by screson on 2017/10/18.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

class ZXStoreContactInfoCell: UITableViewCell {

    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var lbTextInfo: UILabel!
    @IBOutlet weak var imgArrow: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
