//
//  ZXDrugListViewController+Table.swift
//  YDY_GJ_3_5
//
//  Created by screson on 2017/5/17.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

extension ZXDrugListViewController:UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ZXStoreDrugCell.reuseIdentifier, for: indexPath) as! ZXStoreDrugCell
        let model = self.drugList[indexPath.row]
        cell.reloadData(model)
        cell.delegate = self
        cell.reloadDataForNotReuse(ZXCart.cart.modelFor("\(model.drugId)"))
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
}

extension ZXDrugListViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let model = self.drugList[indexPath.row]
//        let detail = ZXDrugDetailInfoViewController()
//        detail.drugId = "\(model.drugId)"
//        detail.approvalNum = model.approvalNumber
//        self.navigationController?.pushViewController(detail, animated: true)
    }
}

extension ZXDrugListViewController: ZXStoreDrugCellDelegate {
    func zxStoreDrugCell(_ cell: UITableViewCell, controlType type: ZXGrugNumControlType) {
        if let indexPath = self.tblDrugList.indexPath(for: cell) {
            let model = self.drugList[indexPath.row]
            let sid = "\(model.drugId)"
            if type == .plus {
                ZXCart.cart.plusOne(sid)
            } else {
                ZXCart.cart.subOne(sid)
            }
            //勾选购物车数量
            //self.btnDrugCart.setTitle(ZXCart.cart.totalCountStr, for: .normal)
        }
    }
}


