//
//  ZXGoodsListDD.swift
//  YDHYK
//
//  Created by screson on 2017/10/16.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

class ZXGoodsListDD: NSObject,UITableViewDelegate,UITableViewDataSource {
    var drugList:Array<ZXDrugModel> = []
    weak var source: UIViewController?
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ZXStoreDrugCell.reuseIdentifier, for: indexPath) as! ZXStoreDrugCell
        let model = self.drugList[indexPath.row]
        cell.reloadData(model)
        cell.delegate = source as? ZXStoreDrugCellDelegate
        cell.reloadDataForNotReuse(ZXCart.cart.modelFor(storeId: "\(model.drugstoreId)", drugId: "\(model.baseDrugId)"))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.drugList.count > 0 {
            return drugList.count
        }
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.drugList[indexPath.row]
        let detail = ZXDrugDetailInfoViewController()
        detail.goodsShortModel = model
        self.source?.navigationController?.pushViewController(detail, animated: true)
    }
}
