//
//  ZXStoreIntroductionCell.swift
//  YDHYK
//
//  Created by screson on 2017/10/18.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

class ZXStoreIntroductionCell: UITableViewCell {

    @IBOutlet weak var imgGroupIcon: UIImageView!
    @IBOutlet weak var lbGroupName: UILabel!
    @IBOutlet weak var lbGroupIntroduction: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.lbGroupName.font = UIFont.zx_titleFont(withSize: zx_title2FontSize())
        self.lbGroupName.textColor = UIColor.zx_text()
        self.lbGroupIntroduction.font = UIFont.zx_bodyFont(withSize: zx_bodyFontSize())
        self.lbGroupIntroduction.textColor = UIColor.zx_text()
        
        self.lbGroupName.text = ""
        self.lbGroupIntroduction.text = ""
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func reloadData(model: ZXStoreDetailModel?) {
        if let model = model {
            self.lbGroupName.text = model.groupName
            self.lbGroupIntroduction.text = model.groupProfile
        }
    }
    
}
