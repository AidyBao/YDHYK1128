//
//  ZXOrderSuccessViewController.swift
//  YDHYK
//
//  Created by screson on 2017/10/25.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

/// 订单完成
class ZXOrderSuccessViewController: ZXSTUIViewController {
    
    override var preferredCartButtonHidden: Bool { return true }
    
    var recommendList: Array<ZXDrugModel> = []

    @IBOutlet weak var tblList: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = "下单完成"
        self.view.backgroundColor = UIColor.zx_assist()
        self.tblList.backgroundColor = UIColor.clear
        self.loadRecommendList()
        self.tblList.register(UINib.init(nibName: ZXTakeOrderSuccessCell.NibName, bundle: nil), forCellReuseIdentifier: ZXTakeOrderSuccessCell.reuseIdentifier)
        self.tblList.register(UINib.init(nibName: ZXStoreDrugCell.NibName, bundle: nil), forCellReuseIdentifier: ZXStoreDrugCell.reuseIdentifier)
        self.tblList.register(ZXSingleTextHeaderView.classForCoder(), forHeaderFooterViewReuseIdentifier: ZXSingleTextHeaderView.reuseIdentifier)
        //self.zx_addLeftBarItems(withImageNames: ["back"], originalColor: true)
    }
    
    //override func zx_leftBarButtonActionsIndex(_ index: Int) {
    //    self.navigationController?.popViewController(animated: true)
    //}
    
    //MARK: - 推荐商品
    fileprivate func loadRecommendList () {
        ZXStoreHomeViewModel.recommendList(storeId: ZXStoreParams.storeId, memberId: ZXStoreParams.memberId, token: ZXStoreParams.token) { (s, c, errorMsg, list) in
            if s {
                self.recommendList = list
                self.tblList.reloadData()
            }//失败不作处理
        }
    }
}

extension ZXOrderSuccessViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1,self.recommendList.count > 0 {
            let model = self.recommendList[indexPath.row]
            let detail = ZXDrugDetailInfoViewController()
            detail.goodsShortModel = model
            self.navigationController?.pushViewController(detail, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 175
        }
        return 125
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 40
        }
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
}

extension ZXOrderSuccessViewController: ZXTakeOrderSuccessCellDelegate {
    
    //MARK: - 查看订单
    func zxTakeOrderSuccessCellReviewOrder() {
        //多个订单 无法到详情
        let orderList = HOrderListViewController()
        orderList.dispatchWay = HDispatchWayAll
        orderList.orderStatus = HDrugOrderTypeAll
        self.navigationController?.pushViewController(orderList, animated: true)
    }
    
    //MARK: - 回到首页
    func zxTakeOrderSuccessCellPopToRootAction() {
        self.navigationController?.popToRootViewController(animated: true)
    }

}

extension ZXOrderSuccessViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ZXStoreDrugCell.reuseIdentifier, for: indexPath) as! ZXStoreDrugCell
            cell.delegate = self
            cell.showCheckButton(false)
            cell.minValue = 0
            let model = self.recommendList[indexPath.row]//indexPath.row
            cell.reloadData(model)
            let nativeCartModel = ZXCart.cart.modelFor(storeId: "\(model.drugstoreId)", drugId: "\(model.baseDrugId)")
            cell.reloadDataForNotReuse(nativeCartModel)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: ZXTakeOrderSuccessCell.reuseIdentifier, for: indexPath) as! ZXTakeOrderSuccessCell
            cell.delegate = self
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: ZXSingleTextHeaderView.reuseIdentifier) as! ZXSingleTextHeaderView
            view.setText("猜您需药", image: #imageLiteral(resourceName: "hot-drug"))
            return view
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return self.recommendList.count
        }
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
}

//MARK: - 数量加减
extension ZXOrderSuccessViewController: ZXStoreDrugCellDelegate{
    func zxStoreDrugCell(_ cell: UITableViewCell, controlType type: ZXGrugNumControlType) {
        if let indexPath = self.tblList.indexPath(for: cell) {
            let model = self.recommendList[indexPath.row]
            let sid = "\(model.baseDrugId)"
            if type == .plus {
                ZXCart.cart.plus(storeId: "\(model.drugstoreId)", drugId: sid)
            } else {
                ZXCart.cart.sub(storeId: "\(model.drugstoreId)", drugId: sid)
            }
        }
    }
}
