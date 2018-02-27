//
//  ZXShoppingCart+Table.swift
//  YDHYK
//
//  Created by screson on 2017/10/23.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

//MARK: - 选中店铺  店铺跳转
extension ZXShoppingCartViewController: ZXSPCartStoreHeaderDelegate {
    //选中店铺
    func zxSPCartStoreHeader(_ storeHeader: ZXSPCartStoreHeader, checked: Bool,selectAt storeModel: ZXStoreDetailModel?) {
        if storeModel != nil {
            if self.cartList.count > 0 {
                for model in self.cartList {
                    let drugId = "\(model.baseDrugId)"
                    let storeId = "\(model.drugstoreId)"
                    ZXCart.cart.check(storeId: storeId, drugId: drugId, checked: checked)
                    //ZXDrugModel 选中状态 数量
                    let nativeCartModel = ZXCart.cart.modelFor(storeId: storeId, drugId: drugId)
                    if let nm = nativeCartModel {
                        model.zx_buyCount = nm.selectedCount
                        model.zx_checked = nm.checked
                    } else {
                        model.zx_buyCount = 0
                        model.zx_checked = false
                    }
                }
                self.reloadAction(reBuild: false)
            }
        }
    }
    //点击跳转店铺
    func zxSPCartStoreHeader(_ storeHeader: ZXSPCartStoreHeader, selectAt storeModel: ZXStoreDetailModel?) {
        if let store = storeModel {
            let store = ZXStoreRootViewController.configVC(with: store.storeId, memberId: ZXStoreParams.memberId, token: ZXStoreParams.token)
            if let rootvc = self.navigationController?.viewControllers.first {
                self.navigationController?.setViewControllers([rootvc,store], animated: true)
            } else {
                self.navigationController?.pushViewController(store, animated: true)
            }
        }
    }
}

//MARK: - UITableViewDelegate
extension ZXShoppingCartViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.recommendList.count > 0,indexPath.section == self.cartList.count {
            let model = self.recommendList[indexPath.row]
            let detail = ZXDrugDetailInfoViewController()
            detail.goodsShortModel = model
            self.navigationController?.pushViewController(detail, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if self.recommendList.count > 0,section == self.cartList.count {
            let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: ZXSingleTextHeaderView.reuseIdentifier) as! ZXSingleTextHeaderView
            view.setText("猜您需药", image: #imageLiteral(resourceName: "hot-drug"))
            return view
        }
        if self.cartList.count > 0 {
            if section > 0 {
                let lastModel = self.cartList[section - 1]
                let currentModel = self.cartList[section]
                if currentModel.drugstoreId != lastModel.drugstoreId {
                    let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: ZXSPCartStoreHeader.reuseIdentifier) as! ZXSPCartStoreHeader
                    view.delegate = self
                    view.reloadData(model: self.storeList["\(self.cartList[section].drugstoreId)"])
                    return view
                }
            } else {
                let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: ZXSPCartStoreHeader.reuseIdentifier) as! ZXSPCartStoreHeader
                view.delegate = self
                view.reloadData(model: self.storeList["\(self.cartList[section].drugstoreId)"])
                return view
            }
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if self.recommendList.count > 0,section == self.cartList.count {
            return 40
        }
        if self.cartList.count > 0 {
            let currentModel = self.cartList[section]
            if section > 0 {
                let lastModel = self.cartList[section - 1]
                if currentModel.drugstoreId != lastModel.drugstoreId {
                    if self.isFreeFreight(for: "\(currentModel.drugstoreId)") {
                        return 40
                    }
                    return 80
                }
            } else {
                if self.isFreeFreight(for: "\(currentModel.drugstoreId)") {
                    return 40
                }
                return 80
            }
        }
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if self.recommendList.count > 0,section == self.cartList.count {
            return 10
        }
        if self.cartList.count > 0 {
            let currentModel = self.cartList[section]
            if section + 1 < self.cartList.count {
                let nextModel = self.cartList[section + 1]
                if currentModel.drugstoreId != nextModel.drugstoreId {
                    return 10
                }
            } else {
                return 10
            }
        }
        return CGFloat.leastNormalMagnitude
    }
}

//MARK: - UITableViewDataSource
extension ZXShoppingCartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if self.cartList.count > 0,indexPath.section < self.cartList.count {
                let currentModel = self.cartList[indexPath.section]
                self.deleteCellWith(drugModels: [currentModel])
            }
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if self.recommendList.count > 0,indexPath.section == self.cartList.count {
            return false
        }
        return true
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ZXStoreDrugCell.reuseIdentifier, for: indexPath) as! ZXStoreDrugCell
        cell.delegate = self
        if self.recommendList.count > 0,indexPath.section == self.cartList.count {//推荐商品
            cell.showCheckButton(false)
            cell.minValue = 0
            let model = self.recommendList[indexPath.row]//indexPath.row
            cell.reloadData(model)
            let nativeCartModel = ZXCart.cart.modelFor(storeId: "\(model.drugstoreId)", drugId: "\(model.baseDrugId)")
            cell.reloadDataForNotReuse(nativeCartModel)
        } else {//购物车商品
            cell.showCheckButton(true)
            cell.minValue = 1
            let model = self.cartList[indexPath.section]//indexPath.section
            model.zx_sectionIndex = indexPath.section
            cell.reloadData(model)
            let nativeCartModel = ZXCart.cart.modelFor(storeId: "\(model.drugstoreId)", drugId: "\(model.baseDrugId)")
            cell.reloadDataForNotReuse(nativeCartModel)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.recommendList.count > 0,section == self.cartList.count {//推荐药品
            return self.recommendList.count
        }
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var fixCount = 0
        if self.recommendList.count > 0 {
            fixCount = 1
        }
        return self.cartList.count + fixCount
    }
}

//MARK: - 数量加减
extension ZXShoppingCartViewController: ZXStoreDrugCellDelegate{
    /// 数量加减
    ///
    func zxStoreDrugCell(_ cell: UITableViewCell, controlType type: ZXGrugNumControlType) {
        if let indexPath = self.tblList.indexPath(for: cell) {
            var model:ZXDrugModel?
            var recommendDrugModify = false
            if self.recommendList.count > 0,indexPath.section == self.cartList.count {//推荐商品
                model = self.recommendList[indexPath.row]
                recommendDrugModify = true
            } else {
                model = self.cartList[indexPath.section]
            }
            
            if let model = model {
                let drugId = "\(model.baseDrugId)"
                let storeId = "\(model.drugstoreId)"
                if type == .plus {
                    ZXCart.cart.plus(storeId: storeId, drugId: drugId)
                    let nativeCartModel = ZXCart.cart.modelFor(storeId: storeId, drugId: drugId)
                    if let nm = nativeCartModel {
                        if recommendDrugModify { //修改 cartList 中的Model
                            if let model = self.cartListDrugModel(for: "\(model.baseDrugId)") {
                                model.zx_buyCount = nm.selectedCount
                                model.zx_checked = nm.checked
                            } else {
                                model.zx_buyCount = nm.selectedCount
                                model.zx_checked = nm.checked
                            }
                        } else {
                            model.zx_buyCount = nm.selectedCount
                            model.zx_checked = nm.checked
                        }
                    }
                    if recommendDrugModify {
                        self.drugAddOne(durgId: drugId, storeId: storeId,drugModel: model)
                    } else {
                        self.reloadAction(reBuild: false)
                    }
                } else {
                    ZXCart.cart.sub(storeId: storeId, drugId: drugId)
                    let nativeCartModel = ZXCart.cart.modelFor(storeId: storeId, drugId: drugId)
                    if let nm = nativeCartModel {
                        if recommendDrugModify { //修改 cartList 中的Model
                            if let model = self.cartListDrugModel(for: "\(model.baseDrugId)") {
                                model.zx_buyCount = nm.selectedCount
                                model.zx_checked = nm.checked
                            } else {
                                model.zx_buyCount = nm.selectedCount
                                model.zx_checked = nm.checked
                            }
                        } else {
                            model.zx_buyCount = nm.selectedCount
                            model.zx_checked = nm.checked
                        }
                    } else {
                        model.zx_buyCount = 0
                        model.zx_checked = false
                    }
                    
                    if recommendDrugModify {
                        self.drugSubOne(durgId: drugId, storeId: storeId,drugModel: model)
                    }
                    self.reloadAction(reBuild: false)
                }
            }
        }
    }
    
    /// 选中、取消选中
    ///
    func zxStoreDrugCell(_ cell: UITableViewCell, checked: Bool) {
        if let indexPath = self.tblList.indexPath(for: cell) {
            if self.cartList.count > 0 {
                let model = self.cartList[indexPath.section]
                let drugId = "\(model.baseDrugId)"
                let storeId = "\(model.drugstoreId)"
                ZXCart.cart.check(storeId: storeId, drugId: drugId, checked: checked)
                //ZXDrugModel 选中状态 数量
                let nativeCartModel = ZXCart.cart.modelFor(storeId: storeId, drugId: drugId)
                if let nm = nativeCartModel {
                    model.zx_buyCount = nm.selectedCount
                    model.zx_checked = nm.checked
                } else {
                    model.zx_buyCount = 0
                    model.zx_checked = false
                }
                //Header 是否选中
                self.storeList[storeId]?.zx_checked = self.isAllCheckedfor(storeId: storeId)
                self.reloadAction(reBuild: false)
            }
        }
    }
}
