//
//  ZXTakeOrderSuccessCell.swift
//  YDHYK
//
//  Created by screson on 2017/10/26.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

protocol ZXTakeOrderSuccessCellDelegate: class {
    func zxTakeOrderSuccessCellReviewOrder()
    func zxTakeOrderSuccessCellPopToRootAction()
}

class ZXTakeOrderSuccessCell: UITableViewCell {
    weak var delegate: ZXTakeOrderSuccessCellDelegate?
    @IBOutlet weak var btnReviewOrder: UIButton!
    @IBOutlet weak var btnPopToRoot: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        self.btnReviewOrder.setTitleColor(UIColor.zx_sub2Text(), for: .normal)
        self.btnReviewOrder.layer.borderColor = UIColor.zx_sub2Text().cgColor
        self.btnReviewOrder.layer.borderWidth = 0.5
        self.btnReviewOrder.layer.cornerRadius = 5
        
        self.btnPopToRoot.setTitleColor(UIColor.zx_sub2Text(), for: .normal)
        self.btnPopToRoot.layer.borderColor = UIColor.zx_sub2Text().cgColor
        self.btnPopToRoot.layer.borderWidth = 0.5
        self.btnPopToRoot.layer.cornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func reviewOrderAction(_ sender: Any) {
        delegate?.zxTakeOrderSuccessCellReviewOrder()
    }
    
    @IBAction func popToRootAction(_ sender: Any) {
        delegate?.zxTakeOrderSuccessCellPopToRootAction()
    }
    
    
}
