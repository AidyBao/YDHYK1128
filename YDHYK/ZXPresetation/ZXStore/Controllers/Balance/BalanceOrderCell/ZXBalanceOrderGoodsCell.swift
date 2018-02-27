//
//  ZXBalanceOrderGoodsCell.swift
//  YDHYK
//
//  Created by screson on 2017/10/25.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

class ZXBalanceOrderGoodsCell: UITableViewCell, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {

    static let rowHeight:CGFloat = 100
    @IBOutlet weak var ccvList: UICollectionView!
    
    fileprivate var storeModel: ZXStoreDetailModel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        self.ccvList.delegate = self
        self.ccvList.dataSource = self
        self.ccvList.contentInset = UIEdgeInsetsMake(0, 10, 0, 0)
        self.ccvList.register(UINib.init(nibName: AZXBalanceOrderGoodsCCVCell.NibName, bundle: nil), forCellWithReuseIdentifier: AZXBalanceOrderGoodsCCVCell.reuseIdentifier)
    }

    func reloadData(store: ZXStoreDetailModel?) {
        self.storeModel = store
        self.ccvList.reloadData()
    }
    
    //MARK: - CCV
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AZXBalanceOrderGoodsCCVCell.reuseIdentifier, for: indexPath) as! AZXBalanceOrderGoodsCCVCell
        cell.reloadData(drug: self.storeModel?.drugCounterList[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (ZX.BOUNDS_WIDTH - 60) / 5.5, height: ZXBalanceOrderGoodsCell.rowHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let store = self.storeModel {
            return store.drugCounterList.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    
}
