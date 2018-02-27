//
//  ZXStoreDrugCell.swift
//  YDY_GJ_3_5
//
//  Created by screson on 2017/5/16.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

enum ZXGrugNumControlType {
    case sub
    case plus
}

protocol ZXStoreDrugCellDelegate: class {
    func zxStoreDrugCell(_ cell:UITableViewCell,controlType type:ZXGrugNumControlType)
    func zxStoreDrugCell(_ cell:UITableViewCell,checked:Bool)
}

extension ZXStoreDrugCellDelegate {
    func zxStoreDrugCell(_ cell:UITableViewCell,controlType type:ZXGrugNumControlType) {}
    func zxStoreDrugCell(_ cell:UITableViewCell,checked:Bool){}
}

/// 药品库药品Cell
class ZXStoreDrugCell: UITableViewCell {

    weak var delegate: ZXStoreDrugCellDelegate?
    
    @IBOutlet weak var imgvIcon: UIImageView!
    @IBOutlet weak var lbDrugName: UILabel! //名字和规格拼接在一起
    @IBOutlet weak var lbDrugEffect: UILabel!
    @IBOutlet weak var lbPrice: UILabel!
    @IBOutlet weak var btnPlus: UIButton!
    @IBOutlet weak var btnSub: UIButton!
    @IBOutlet weak var lbNumber: UILabel!
    
    @IBOutlet weak var sepratorLine: UIView!
    
    var minValue = 0
    var maxValue = 99
    
    
    fileprivate var isPrescription = false
    fileprivate var number:Int = 0
    fileprivate var checked:Bool = false
    
    @IBOutlet weak var imgvIconOffsetX: NSLayoutConstraint!
    
    @IBOutlet weak var checkBackView: UIView!
    @IBOutlet weak var checkImage: UIImageView!
    @IBOutlet weak var btnCheck: UIButton!
    @IBOutlet weak var checkViewWidth: NSLayoutConstraint!
    
    @IBOutlet weak var checkImgCenterOffset: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        self.lbDrugEffect.textColor = UIColor.zx_sub2Text()
        self.lbPrice.textColor = UIColor.zx_customB()
        
        self.showCheckButton(false)
        self.lbDrugName.text = ""
        self.lbDrugEffect.text = ""
        self.lbDrugName.textColor = UIColor.zx_text()
        self.lbNumber.textColor = UIColor.zx_text()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func showCheckButton(_ show:Bool) {
        if show {
            self.checkBackView.isHidden = false
            self.checkViewWidth.constant = 44
            if UIDevice.zx_deviceSizeType() == ZX_IPHONE4 {
                self.imgvIconOffsetX.constant = -10
                self.checkImgCenterOffset.constant = -5
            } else {
                self.imgvIconOffsetX.constant = 4
                self.checkImgCenterOffset.constant = -0
            }
        } else {
            self.checkBackView.isHidden = true
            self.checkViewWidth.constant = 0
            self.imgvIconOffsetX.constant = 14
            self.checkImgCenterOffset.constant = -0
        }
    }
    
    func reloadData(_ model:ZXDrugModel) {
        self.imgvIcon.image = UIImage.Default.empty
       
        if let first = model.attachFilesStrs.first,let url =  URL(string:ZXIMG_Address(first)) {
            self.imgvIcon.setImageWith(url, placeholderImage: UIImage.Default.empty)
        } else {
            self.imgvIcon.image = UIImage.Default.empty
        }
        if model.isPrescription == 1 {//处方药
            isPrescription = true
            self.hidControl(true)
        } else {
            isPrescription = false
            self.hidControl(false)
        }
        setDrugName(model.drugName, isPrescription: isPrescription, spec: model.packingSpec)
        //var effectInfo = model.functionIndications //功能主治
        if !model.indication.isEmpty {
            var effectInfo = "适应症:" + model.indication //适应症
            effectInfo = effectInfo.replacingOccurrences(of: "</*[^<>]*>*", with: "", options: .regularExpression, range: effectInfo.startIndex..<effectInfo.endIndex)
            self.lbDrugEffect.text = effectInfo
        }
        
        self.lbPrice.text = "\(model.zx_truePrice)".zx_priceString()

    }
    
    fileprivate func setDrugName(_ name:String,isPrescription:Bool,spec:String) {
        var drugName = " \(name)"
        if spec.characters.count > 0 {
            drugName += " \(spec)"
        }
        let attachment = NSTextAttachment(data: nil, ofType: nil)
        var image = #imageLiteral(resourceName: "otc") //非处方药
        if isPrescription {
            image = #imageLiteral(resourceName: "rx")
        }
        attachment.image = image
        attachment.bounds = CGRect(x: 0, y: -3, width: 31, height: 15)
        let imgAttr = NSAttributedString(attachment: attachment)
        let textAttr = NSAttributedString.zx_addFont(toText: drugName, with: UIFont.zx_bodyFont(withSize: 16), at: NSMakeRange(0, drugName.characters.count))
        textAttr?.insert(imgAttr, at: 0)
        self.lbDrugName.textColor = UIColor.zx_text()
        self.lbDrugName.attributedText = textAttr
    }
    
    /// 数量 选中状态
    ///
    /// - Parameter model: ZXDrugBuyModel
    func reloadDataForNotReuse(_ model:ZXDrugBuyModel?) {
        if let model = model {
            self.resetNumForNotReuse(model.selectedCount)
            self.resetCheckForNotReuse(model.checked)
        } else {
            self.resetNumForNotReuse(0)
            self.resetCheckForNotReuse(false)
        }
    }
    
    fileprivate func resetCheckForNotReuse(_ check:Bool) {
        if check {
            self.checkImage.isHighlighted = true
        } else {
            self.checkImage.isHighlighted = false
        }
        self.checked = check
    }

    
    fileprivate func resetNumForNotReuse(_ num: Int) {
        self.number = num
        if self.number < 0 {
            self.number = 0
        }
        self.lbNumber.text = "\(num)"
        if isPrescription {
            self.hidControl(true)
        } else {
            self.hidControl(false)
        }
    }
    
    fileprivate func hidControl(_ hide:Bool) {
        if hide {
            self.lbNumber.isHidden = true
            self.btnPlus.isHidden = true
            self.btnSub.isHidden = true
        } else {
            if self.number <= 0 {
                self.btnPlus.isHidden = false
                self.btnSub.isHidden = true
                self.lbNumber.isHidden = true
            } else {
                self.lbNumber.isHidden = false
                self.btnPlus.isHidden = false
                self.btnSub.isHidden = false
            }
        }
    }
    
    @IBAction func plusAction(_ sender: UIButton) {
        if self.number + 1 > maxValue {
            return
        }
        resetNumForNotReuse(self.number + 1)
        delegate?.zxStoreDrugCell(self, controlType: .plus)
    }
    
    @IBAction func subAction(_ sender: UIButton) {
        if minValue > 0,(self.number - 1) < minValue {
            return
        }
        resetNumForNotReuse(self.number - 1)
        delegate?.zxStoreDrugCell(self, controlType: .sub)
    }
    
    @IBAction func checkAction(_ sender: UIButton) {
        self.checked = !self.checked
        self.checkImage.isHighlighted = self.checked
        delegate?.zxStoreDrugCell(self, checked: self.checked)
    }
}
