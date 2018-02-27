//
//  ZXPromiseCell.swift
//  YDHYK
//
//  Created by screson on 2017/10/20.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

class ZXPromiseCell: UITableViewCell {

    @IBOutlet weak var lbMarks: UILabel!
    @IBOutlet weak var lbTitls: UILabel!
    @IBOutlet weak var lbDetail: UILabel!
    @IBOutlet weak var sLine: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        self.lbTitls.text = ""
        self.lbDetail.text = ""
        self.lbMarks.layer.cornerRadius = 11
        self.lbMarks.layer.masksToBounds = true
        self.lbMarks.backgroundColor = UIColor.zx_tint()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func reloadData(model: ZXPromiseItemModel?) {
        if let model = model {
            self.lbMarks.isHidden = false
            self.lbMarks.text = model.keyWord
            self.lbTitls.text = model.title
            self.lbDetail.text = model.detailInfo

        } else {
            self.lbMarks.isHidden = true
            self.lbMarks.text = ""
            self.lbTitls.text = ""
            self.lbDetail.text = ""
        }
    }
    
}
