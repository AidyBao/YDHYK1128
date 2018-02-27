//
//  ZXRelateGoodsListCell.swift
//  YDHYK
//
//  Created by screson on 2017/10/17.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

class ZXRelateGoodsListCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {
    
    static let cellHeight:CGFloat = 165
    
    weak var delegate: ZXStoreActiveCellDelegate?

    var drugList: Array<ZXDrugModel> = [] {
        didSet {
            self.ccvLIst.reloadData()
        }
    }
    
    @IBOutlet weak var ccvLIst: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        self.ccvLIst.register(UINib(nibName: ZXRelateGoodsCCVCell.NibName, bundle: nil), forCellWithReuseIdentifier: ZXRelateGoodsCCVCell.reuseIdentifier)
        self.ccvLIst.contentInset = UIEdgeInsetsMake(0, 10, 0, 0)
        self.ccvLIst.delegate = self
        self.ccvLIst.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.zxStoreActiveCell(self, goodsSelectAt: drugList[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ZXRelateGoodsCCVCell.reuseIdentifier, for: indexPath) as! ZXRelateGoodsCCVCell
        cell.reloadData(model: drugList[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return drugList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: floor((ZX.BOUNDS_WIDTH - 60) / 3.0), height: ZXRelateGoodsListCell.cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
}
