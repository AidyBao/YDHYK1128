//
//  ZXValidCouponListViewController.swift
//  YDHYK
//
//  Created by screson on 2017/10/25.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

protocol ZXValidCouponListCheckDelegate: class {
    func zxValidCouponListChecked(storeId: String,coupon: ZXOrderCouponModel)
    func zxValidCouponListUnChecked(storeId: String,coupon: ZXOrderCouponModel)

}

/// 下单时可用的现金券
class ZXValidCouponListViewController: ZXSTUIViewController {

    weak var delegate: ZXValidCouponListCheckDelegate?
    //上个界面传过来 控制 已选状态
    var selectedCouponList: Array<ZXOrderCouponModel> = []
    override var preferredCartButtonHidden: Bool { return true }
    
    @IBOutlet weak var tblList: UITableView!
    
    var couponList: Array<ZXOrderCouponModel> = []
    var storeIds: String? // 店铺Id 逗号分隔
    var fullMoneys: String? // 店铺订单总金额  逗号分隔
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "现金券"
        self.view.backgroundColor = UIColor.zx_assist()
        self.tblList.backgroundColor = .clear
        self.tblList.register(UINib.init(nibName: ZXBalanceCouponCell.NibName, bundle: nil), forCellReuseIdentifier: ZXBalanceCouponCell.reuseIdentifier)
        self.tblList.zx_addHeaderRefreshActionUseZXImage(true, target: self, action: #selector(zx_refresh))
        self.loadCouponList(showHUD: true)
    }
    
    override func zx_refresh() {
        self.loadCouponList(showHUD: false)
    }
    
    func couponInSelectedCouponList(with cId: String) -> ZXOrderCouponModel? {
        if self.selectedCouponList.count > 0 {
            var coupon: ZXOrderCouponModel?
            for c in self.selectedCouponList {
                if c.couponId == cId {
                    coupon = c
                    break
                }
            }
            return coupon
        }
        return nil
    }
    
    func loadCouponList(showHUD: Bool) {
        if let storeIds = storeIds, let fullMoneys = fullMoneys {
            if showHUD {
                ZXHUD.mbShowLoading(in: self.view, text: ZX_LOADING_TEXT, delay: 0)
            }
            ZXDrugStoreViewModel.couponList(drugstoreIds: storeIds , fullMoneys: fullMoneys, memberId: ZXStoreParams.memberId, token: ZXStoreParams.token, completion: { (success, code, list, errorMsg) in
                self.tblList.mj_header.endRefreshing()
                ZXHUD.mbHide(for: self.view, animate: true)
                if success {
                    self.couponList = list ?? []
                    for c in self.couponList {
                        if self.couponInSelectedCouponList(with: c.couponId) != nil {
                            c.zx_isSelected = true
                            c.zx_valid = true
                            self.setSameStoreCouponValid(false, storeId: c.drugstoreIdNow,exceptCouponId: c.couponId)
                        }
                    }
                    self.tblList.reloadData()
                } else {
                    if code != ZXAPI_LOGIN_INVALID {
                        ZXHUD.mbShowFailure(in: self.view, text: errorMsg, delay: ZX.DELAY_INTERVAL)
                    }
                }
            })
        } else {
            ZXHUD.mbShowFailure(in: self.view, text: "店铺ID列表为空", delay: ZX.DELAY_INTERVAL)
        }
    }
}

extension ZXValidCouponListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
}

extension ZXValidCouponListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ZXBalanceCouponCell.reuseIdentifier, for: indexPath) as! ZXBalanceCouponCell
        cell.reloadData(coupon: self.couponList[indexPath.section])
        cell.delegate = self
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.couponList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}

extension ZXValidCouponListViewController: ZXBalanceCouponDelegate {
    func zxBalanceCouponCellSelect(at cell: ZXBalanceCouponCell) {
        if let indexPath = self.tblList.indexPath(for: cell) {
            let model = self.couponList[indexPath.section]
            model.zx_isSelected = true
            model.zx_valid = true
            delegate?.zxValidCouponListChecked(storeId: model.drugstoreIdNow, coupon: model)
            self.setSameStoreCouponValid(false, storeId: model.drugstoreIdNow,exceptCouponId: model.couponId)
            self.tblList.reloadData()
        }
    }
    
    func zxBalanceCouponCellDeSelect(at cell: ZXBalanceCouponCell) {
        if let indexPath = self.tblList.indexPath(for: cell) {
            let model = self.couponList[indexPath.section]
            model.zx_isSelected = false
            model.zx_valid = true
            delegate?.zxValidCouponListUnChecked(storeId: model.drugstoreIdNow, coupon: model)
            self.setSameStoreCouponValid(true, storeId: model.drugstoreIdNow,exceptCouponId: model.couponId)
            self.tblList.reloadData()
        }
    }
    
    func setSameStoreCouponValid(_ valid:Bool,storeId: String,exceptCouponId: String) {
        if self.couponList.count > 0 {
            for coupon in self.couponList {
                if coupon.drugstoreIdNow == storeId,coupon.couponId != exceptCouponId {
                    coupon.zx_valid = valid
                }
            }
        }
    }
}
