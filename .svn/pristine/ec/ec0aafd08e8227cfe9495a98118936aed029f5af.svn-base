//
//  ZXSingleTextCell.swift
//  YDY_GJ_3_5
//
//  Created by screson on 2017/5/17.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

class ZXSingleTextCell: UITableViewCell {

    @IBOutlet weak var lbText: UILabel!
    @IBOutlet weak var separatorLine: UIView!
    @IBOutlet weak var leftOffset: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.lbText.font = UIFont.zx_bodyFont(withSize: zx_bodyFontSize())
        self.lbText.textColor = UIColor.zx_sub2Text()
        self.separatorLine.backgroundColor = UIColor.zx_border()
        self.contentView.backgroundColor = UIColor.zx_assist()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        if selected {
            self.contentView.backgroundColor = UIColor.white
            self.lbText.textColor = UIColor.zx_text()
        } else {
            self.contentView.backgroundColor = UIColor.zx_assist()
            self.lbText.textColor = UIColor.zx_sub2Text()
        }
    }
}
