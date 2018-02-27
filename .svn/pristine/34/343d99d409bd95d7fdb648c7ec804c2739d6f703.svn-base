//
//  ZXActive3.swift
//  YDHYK
//
//  Created by screson on 2017/10/12.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

class ZXActive3: UITableViewCell {
    weak var delegate: ZXStoreActiveCellDelegate?
    
    @IBOutlet weak var active1View: UIView!
    @IBOutlet weak var active2View: UIView!
    
    @IBOutlet weak var active3View: UIView!
    
    @IBOutlet weak var active1Title: UILabel!
    @IBOutlet weak var active1SubTitle: UILabel!
    @IBOutlet weak var active1Image: UIImageView!
    @IBOutlet weak var active2Title: UILabel!
    @IBOutlet weak var active2SubTitle: UILabel!
    @IBOutlet weak var active2Image: UIImageView!
    @IBOutlet weak var active3Title: UILabel!
    @IBOutlet weak var active3SubTitle: UILabel!
    @IBOutlet weak var active3Image: UIImageView!
    var activeList:Array<ZXStoreActive> = []
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        
        self.active1Title.text = ""
        self.active1Title.textColor = UIColor.zx_text()
        self.active1Title.font = UIFont.boldSystemFont(ofSize: zx_bodyFontSize())
        
        self.active1SubTitle.text = ""
        self.active1SubTitle.textColor = UIColor.zx_tint()
        self.active1SubTitle.font = UIFont.zx_bodyFont(withSize: zx_bodyFontSize() - 2)
        
        self.active2Title.text = ""
        self.active2Title.textColor = UIColor.zx_text()
        self.active2Title.font = UIFont.boldSystemFont(ofSize: zx_bodyFontSize())
        
        self.active2SubTitle.text = ""
        self.active2SubTitle.textColor = UIColor(red: 142 / 255.0, green: 216 / 255.0, blue: 79 / 255.0, alpha: 1.0)
        self.active2SubTitle.font = UIFont.zx_bodyFont(withSize: zx_bodyFontSize() - 2)
        
        self.active3Title.text = ""
        self.active3Title.textColor = UIColor.zx_text()
        self.active3Title.font = UIFont.boldSystemFont(ofSize: zx_bodyFontSize())
        
        self.active3SubTitle.text = ""
        self.active3SubTitle.textColor = UIColor(red: 235 / 255.0, green: 196 / 255.0, blue: 76 / 255.0, alpha: 1.0)
        self.active3SubTitle.font = UIFont.zx_bodyFont(withSize: zx_bodyFontSize() - 2)
        
        let tap1 = UITapGestureRecognizer.init(target: self, action: #selector(active1Action(_:)))
        self.active1View.addGestureRecognizer(tap1)
        
        let tap2 = UITapGestureRecognizer.init(target: self, action: #selector(active2Action(_:)))
        self.active2View.addGestureRecognizer(tap2)
        
        let tap3 = UITapGestureRecognizer.init(target: self, action: #selector(active3Action(_:)))
        self.active3View.addGestureRecognizer(tap3)
    }
    
    func reloadData(model: ZXStoreModel?) {
        if let model = model {
            self.activeList =  model.zx_ActiveList
            for (idx,m) in self.activeList.enumerated() {
                switch idx {
                    case 0:
                        self.active1Title.text = m.title
                        self.active1SubTitle.text = m.title
                        if let url = URL.init(string: ZXIMG_Address(m.image)) {
                            self.active1Image.setImageWith(url, placeholderImage: UIImage.Default.empty)
                        }
                    case 1:
                        self.active2Title.text = m.title
                        self.active2SubTitle.text = m.subTitle
                        if let url = URL.init(string: ZXIMG_Address(m.image)) {
                            self.active2Image.setImageWith(url, placeholderImage: UIImage.Default.empty)
                        }
                    case 2:
                        self.active3Title.text = m.title
                        self.active3SubTitle.text = m.subTitle
                        if let url = URL.init(string: ZXIMG_Address(m.image)) {
                            self.active3Image.setImageWith(url, placeholderImage: UIImage.Default.empty)
                        }
                    default:
                        break
                }
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func active1Action(_ sender: UITapGestureRecognizer) {
        if self.activeList.count > 0 {
            delegate?.zxStoreActiveCell(self, selectedAt: 0,model: self.activeList[0])
        }
        
    }
    
    @IBAction func active2Action(_ sender: UITapGestureRecognizer) {
        if self.activeList.count > 0 {
            delegate?.zxStoreActiveCell(self, selectedAt: 0,model: self.activeList[1])
        }
    }
    
    @IBAction func active3Action(_ sender: UITapGestureRecognizer) {
        if self.activeList.count > 0 {
            delegate?.zxStoreActiveCell(self, selectedAt: 0,model: self.activeList[2])
        }
    }
}
