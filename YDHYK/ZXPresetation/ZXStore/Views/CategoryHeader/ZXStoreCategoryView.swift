//
//  ZXStoreCategoryView.swift
//  ZXStore
//
//  Created by screson on 2017/10/10.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

protocol ZXStoreCategoryViewDelegate: class {
    func zxStoreCategoryView(_ view:ZXStoreCategoryView,selectAt index:Int)
}

extension ZXStoreCategoryViewDelegate {
    func zxStoreCategoryView(_ view:ZXStoreCategoryView,selectAt index:Int){}
}
/// 分类
class ZXStoreCategoryView: UIView {
    weak var delegate:ZXStoreCategoryViewDelegate?
    
    var ccvCategory: UICollectionView!
    fileprivate var contentView:UIView!
    var storeModel: ZXStoreModel?
    fileprivate var firstLoad = true
    
    convenience init (origin: CGPoint) {
        self.init(frame: CGRect(x: origin.x, y: origin.y, width: ZX.BOUNDS_WIDTH, height: 180))
        self.backgroundColor = .clear
        
        contentView = UIView(frame: CGRect(x: 10, y: 0, width: ZX.BOUNDS_WIDTH - 20, height: 180))
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 5.0
        contentView.layer.shadowColor = UIColor.zx_tint().cgColor
        contentView.layer.shadowOpacity = 0.5
        contentView.layer.shadowRadius = 5
        contentView.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.addSubview(contentView)
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: floor((ZX.BOUNDS_WIDTH - 20) / 4.0), height: 90)
        self.ccvCategory = UICollectionView.init(frame: CGRect(x: 0, y: 0, width: contentView.frame.size.width, height: contentView.frame.size.height), collectionViewLayout: layout)
        self.ccvCategory.register(UINib(nibName: ZXCategoryCCVCell.NibName, bundle: nil), forCellWithReuseIdentifier: ZXCategoryCCVCell.reuseIdentifier)
        ccvCategory.backgroundColor = .clear
        self.ccvCategory.delegate = self
        self.ccvCategory.dataSource = self
        self.ccvCategory.isScrollEnabled = false
        contentView.addSubview(ccvCategory)
    }
    
    func reloadData(_ model: ZXStoreModel)  {
        self.storeModel = model
        self.firstLoad = false
        self.ccvCategory.reloadData()
    }
}

extension ZXStoreCategoryView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ZXCategoryCCVCell.reuseIdentifier, for: indexPath) as! ZXCategoryCCVCell
        cell.imgvIcon.image =  nil
        if let model = self.storeModel,let sort = model.zx_sorts {
            let count = sort.count
            if indexPath.row == count {//全部
                cell.imgvIcon.image =  UIImage.init(named: "category-icon-8")
                cell.lbName.text = "全部"

            } else {
                cell.lbName.text = sort[indexPath.row].name
                
                if let url = URL(string: ZXIMG_Address(sort[indexPath.row].icon)) {
                    cell.imgvIcon.setImageWith(url,placeholderImage: UIImage.Default.drug)
                } else {
                    cell.imgvIcon.image = UIImage.Default.drug
                }
            }
        } else {
            cell.imgvIcon.image =  UIImage.init(named: "category-icon-8")
            cell.lbName.text = "全部"
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let model = self.storeModel,let sort = model.zx_sorts {
            return sort.count + 1//全部
        }
        if firstLoad {
            return 0
        }
        return 1//没有其他小分类，显示全部分类
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

extension ZXStoreCategoryView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.zxStoreCategoryView(self, selectAt: indexPath.row)
    }
}
