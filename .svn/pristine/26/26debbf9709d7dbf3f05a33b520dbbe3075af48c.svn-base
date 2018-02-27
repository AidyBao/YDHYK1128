//
//  ZXActive1Cell.swift
//  YDHYK
//
//  Created by screson on 2017/10/12.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

protocol ZXStoreActiveCellDelegate: class {
    //MARK: - 多个活动点击
    func zxStoreActiveCell(_ cell:UITableViewCell,selectedAt index:Int,model:ZXStoreActive)
    //MARK: - 单个活动下的商品
    func zxStoreActiveCell(_ cell:UITableViewCell,goodsSelectAt model:ZXDrugModel)
}

extension ZXStoreActiveCellDelegate {
    func zxStoreActiveCell(_ cell:UITableViewCell,selectedAt index:Int,model:ZXStoreActive) {}
    func zxStoreActiveCell(_ cell:UITableViewCell,goodsSelectAt model:ZXDrugModel) {}
}

class ZXActive1Cell: UITableViewCell {

    weak var delegate: ZXStoreActiveCellDelegate?
    
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var btnSeeMore: UIButton!
    @IBOutlet weak var ccvList: UICollectionView!
    var activeList: Array<ZXStoreActive> = []
    var goodsList: Array<ZXDrugModel> = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
        self.selectionStyle = .none
        self.lbName.text = ""
        self.lbName.textColor = UIColor.zx_text()
        self.lbName.font = UIFont.boldSystemFont(ofSize: zx_bodyFontSize())
        self.btnSeeMore.setTitleColor(UIColor.zx_tint(), for: .normal)
        
        self.ccvList.contentInset = UIEdgeInsetsMake(0, 10, 0, 0)
        self.ccvList.register(UINib.init(nibName: ZXActiveGoodsCell.NibName, bundle: nil), forCellWithReuseIdentifier: ZXActiveGoodsCell.reuseIdentifier)
        self.ccvList.delegate = self
        self.ccvList.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }
    
    func reloadData(model: ZXStoreModel?) {
        if let model = model {
            self.activeList =  model.zx_ActiveList
            self.goodsList = model.activeList
            self.ccvList.reloadData()
            if let m = self.activeList.first {
                self.lbName.text = m.title
                if let url = URL.init(string: ZXIMG_Address(m.icon)) {
                    self.imgIcon.setImageWith(url, placeholderImage: UIImage.Default.empty)
                }
            }
        }
    }
    
    @IBAction func activeDetailList(_ sender: UIButton) {
        if self.activeList.count > 0 {
            delegate?.zxStoreActiveCell(self, selectedAt: 0,model: self.activeList[0])
        }
    }
}

extension ZXActive1Cell: UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.zxStoreActiveCell(self, goodsSelectAt: self.goodsList[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = floor((ZX.BOUNDS_WIDTH - 40) / 3)
        return CGSize(width: width, height: 140)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

extension ZXActive1Cell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ZXActiveGoodsCell.reuseIdentifier
            , for: indexPath) as! ZXActiveGoodsCell
        cell.reloadData(model: self.goodsList[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.goodsList.count
    }
    
}
