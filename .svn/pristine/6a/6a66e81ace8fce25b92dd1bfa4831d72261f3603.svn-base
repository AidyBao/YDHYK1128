//
//  ZXDrugCategoryViewController+Table.swift
//  YDY_GJ_3_5
//
//  Created by screson on 2017/5/17.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

extension ZXDrugCategoryViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ZXSingleTextCell.reuseIdentifier, for: indexPath) as! ZXSingleTextCell
        if let c = self.categories?[indexPath.row] {
            cell.lbText?.text = c.name
        }else{
            cell.lbText?.text = ""
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let c = self.categories {
            return c.count
        }
        return 0
    }
}

extension ZXDrugCategoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == topIndex {
            return
        }
        topIndex = indexPath.row
        self.ccvSubCategory.reloadData()
    }
}

extension ZXDrugCategoryViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ZXCategoryCCVCell.reuseIdentifier, for: indexPath) as! ZXCategoryCCVCell
        cell.lbName.text = "标签\(indexPath.row + 1)"
        if let c = self.categories?[topIndex],let child = c.childList,child.count > 0 {
            let cc = child[indexPath.row]
            cell.lbName.text = cc.name
            cell.imgvIcon.image = nil
            if let path = cc.zx_iconStr,let url = URL.init(string: path) {
                cell.imgvIcon.setImageWith(url,placeholderImage: UIImage.Default.drug)
            } else {
                cell.imgvIcon.image = UIImage.Default.drug
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let c = self.categories?[topIndex],let child = c.childList,child.count > 0 {
            return child.count
        }
        return 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

extension ZXDrugCategoryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let c = self.categories?[topIndex],let child = c.childList,child.count > 0 {
            let list = ZXDrugListViewController()
            list.category = child[indexPath.row]
            self.navigationController?.pushViewController(list, animated: true)
        }
    }
}

extension ZXDrugCategoryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ((ZX.BOUNDS_WIDTH - 85) - 40) / 3.0, height: 90)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}



