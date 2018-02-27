//
//  ZXBalanceViewController.swift
//  YDHYK
//
//  Created by screson on 2017/10/25.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

/// 结算界面
class ZXBalanceViewController: ZXSTUIViewController {
    override var preferredCartButtonHidden: Bool { return true }
    @IBOutlet weak var tblList: UITableView!
    @IBOutlet weak var lbTotalInfo: UILabel!
    var balanceModel: ZXBalanceModel?
    var selectedAddress: ZXBalanceAddress?
    var selectedCouponList: Dictionary<String,ZXOrderCouponModel> = [:]
    var couponList: Array<ZXOrderCouponModel> {
        get {
            if self.selectedCouponList.count > 0 {
                var list: Array<ZXOrderCouponModel> = []
                for c in self.selectedCouponList.values {
                    list.append(c)
                }
                return list
            }
            return []
        }
    }
    
    var orderAddress: ZXBalanceAddress? {
        get {
            if selectedAddress != nil {
                return selectedAddress
            }
            return self.balanceModel?.address
        }
    }
    
    var toalCouponPrice: Double {
        get {
            if self.selectedCouponList.count > 0 {
                var total:Double = 0
                for coupon in self.selectedCouponList.values {
                    total += coupon.couponMoney
                }
                return total
            }
            return 0
        }
    }
    
    var totalFreight: Double {
        get {
            if let model = self.balanceModel {
                var freight: Double = 0
                for store in model.storeDrugList {
                    freight += store.zx_freight
                }
                return freight
            }
            return 0
        }
    }
    
    var totalOriginalPrice: Double {
        get {
            if let model = self.balanceModel {
                var price: Double = 0
                for store in model.storeDrugList {
                    price += store.zx_balanceTotalPrice
                }
                return price
            }
            return 0
        }
    }
    
    var totalPayPrice: Double {
        get {
            var t = totalOriginalPrice + totalFreight - toalCouponPrice
            if t < 0 {
                t = 0
            }
            return t
        }
    }
    
    //MARK: - 下单json数据
    var orderContentJsonString: String? {
        get {
            if let model = self.balanceModel {
                var orderList: Array<Dictionary<String,Any>> = []
                for store in model.storeDrugList {
                    var storeOrder: Dictionary<String,Any> = [:]
                    var drugItems: Array<Dictionary<String,Any>> = []
                    
                    storeOrder["memberId"] = ZXStoreParams.memberId
                    
                    storeOrder["groupId"] = store.groupId
                    storeOrder["groupName"] = store.groupName
                    storeOrder["total"] = store.zx_balanceTotalPrice //商品总金额
                    storeOrder["originalPrice"] = store.zx_balanceTotalPrice + store.zx_freight //商品金额 + 运费
                    storeOrder["price"] = "0" //线上支付金额
                    storeOrder["discountTotal"] = "0"
                    storeOrder["receiveType"] = store.zx_receiveType
                    storeOrder["paymentMethod"] = store.zx_paymentType
                    storeOrder["remark"] = store.remark
                    storeOrder["freight"] = store.freight  //运费
                    storeOrder["freeSndPrice"] = store.freeSndPrice //满xx包邮
                    storeOrder["drugstoreId"] = store.storeId
                    storeOrder["drugstoreName"] = store.name
                    //现金券数据 ，无 传 -1
                    var couponPirce: Double = 0
                    if let coupon =  self.selectedCouponList[store.storeId] {
                        storeOrder["couponId"] = coupon.couponId
                        storeOrder["couponCode"] = coupon.code
                        storeOrder["couponMoney"] = coupon.couponMoney
                        couponPirce = coupon.couponMoney
                    } else {
                        //现金券数据 ，无 传 -1
                        storeOrder["couponId"] = "-1"
                        storeOrder["couponCode"] = "-1"
                        storeOrder["couponMoney"] = "-1"
                    }
                    //支付总金额
                    storeOrder["payTotal"] = store.zx_balanceTotalPrice + store.zx_freight - couponPirce // originalPrice - 现金券
                    storeOrder["tel"] = self.orderAddress?.tel ?? ""
                    storeOrder["consignee"] = self.orderAddress?.consignee ?? ""
                    storeOrder["address"] = self.orderAddress?.zx_address ?? ""
                    
                    for drug in store.drugCounterList {
                        var item: Dictionary<String,Any> = [:]
                        item["drugId"] = drug.baseDrugId
                        item["drugstoreId"] = drug.drugstoreId
                        item["approvalNumber"] = drug.approvalNumber
                        item["packingSpec"] = drug.packingSpec
                        item["price"] = drug.price
                        item["num"] = drug.num
                        drugItems.append(item)
                    }
                    storeOrder["items"] = drugItems
                    orderList.append(storeOrder)
                }
                if orderList.count > 0 {
                    if (!JSONSerialization.isValidJSONObject(orderList)) {
                        return nil
                    }
                    if let data = try? JSONSerialization.data(withJSONObject: orderList, options: []) {
                        return String(data:data, encoding: String.Encoding.utf8)
                    }
                }
            }
            return nil
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = "结算"
        self.view.backgroundColor = UIColor.zx_assist()
        self.tblList.backgroundColor = UIColor.clear
        
        self.tblList.register(UINib.init(nibName: ZXOrderAddressCell.NibName, bundle: nil), forCellReuseIdentifier: ZXOrderAddressCell.reuseIdentifier)
        self.tblList.register(UINib.init(nibName: ZXBalanceOrderHeaderCell.NibName, bundle: nil), forCellReuseIdentifier: ZXBalanceOrderHeaderCell.reuseIdentifier)
        self.tblList.register(UINib.init(nibName: ZXBalanceOrderGoodsCell.NibName, bundle: nil), forCellReuseIdentifier: ZXBalanceOrderGoodsCell.reuseIdentifier)
        self.tblList.register(UINib.init(nibName: ZXBalanceOrderLRTextCell.NibName, bundle: nil), forCellReuseIdentifier: ZXBalanceOrderLRTextCell.reuseIdentifier)
        self.tblList.register(UINib.init(nibName: ZXBalanceOrderFooterCell.NibName, bundle: nil), forCellReuseIdentifier: ZXBalanceOrderFooterCell.reuseIdentifier)
        
        self.tblList.estimatedRowHeight = 90
        
        self.lbTotalInfo.font = UIFont.zx_bodyFont(withSize: zx_bodyFontSize())
        self.lbTotalInfo.textColor = UIColor.zx_text()
        self.lbTotalInfo.text = ""
        self.updateTotalPrice()
    }
    
    fileprivate func updateTotalPrice() {
        let attr = NSMutableAttributedString.init(string: "实付金额 ")
        let priceStr = "\(self.totalPayPrice)".zx_priceString()
        let attrPrice = NSMutableAttributedString.init(string: priceStr)
        attrPrice.zx_append(UIFont.zx_titleFont(withSize: zx_title2FontSize()), at: NSMakeRange(0, priceStr.characters.count))
        attrPrice.zx_append(UIColor.zx_customB(), at: NSMakeRange(0, priceStr.characters.count))
        attr.append(attrPrice)
        self.lbTotalInfo.attributedText = attr
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.balanceModel == nil {
            ZXHUD.mbShowFailure(in: self.view, text: "无相关订单数据", delay: ZX.DELAY_INTERVAL)
        }
    }
    
    //MARK: - 提交订单
    @IBAction func commitAction(_ sender: ZXRButton) {
        if let address = self.orderAddress {
            if let orderContent = self.orderContentJsonString {
                ZXHUD.mbShowLoading(in: self.view, text: ZX_LOADING_TEXT, delay: 0)
                ZXDrugStoreViewModel.saveOrder(orderContent: orderContent, memberId: ZXStoreParams.memberId, consignee: address.consignee, tel: address.tel, address: address.zx_address, token: ZXStoreParams.token, completion: { (success, code, errorMsg) in
                    ZXHUD.mbHide(for: self.view, animate: true)
                    if success {
                        ZXShoppingCartViewController.postBalanceSuccess()
                        let successVC = ZXOrderSuccessViewController()
                        var list = self.navigationController?.viewControllers
                        list?.removeLast()
                        list?.append(successVC)
                        self.navigationController?.setViewControllers(list!, animated: true)
                    } else {
                        if code == ZXAPI_COUPON_ERROR {
                            ZXHUD.mbShowFailure(in: self.view, text: "现金券异常,重新结算", delay: ZX.DELAY_INTERVAL)
                            self.selectedCouponList.removeAll()
                            self.tblList.reloadData()
                            self.updateTotalPrice()
                        } else if code != ZXAPI_LOGIN_INVALID {
                            ZXHUD.mbShowFailure(in: self.view, text: errorMsg, delay: ZX.DELAY_INTERVAL)
                        }
                    }
                })
            } else {
                ZXHUD.mbShowFailure(in: self.view, text: "订单数据不存在", delay: ZX.DELAY_INTERVAL)
            }
            
        } else {
            ZXHUD.mbShowFailure(in: self.view, text: "请填写收货地址", delay: ZX.DELAY_INTERVAL)
        }
    }
    
}

extension ZXBalanceViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let model = self.balanceModel {
            let storeGroupCount = model.storeDrugList.count
            switch indexPath.section {
            //MARK: - 收货地址
            case 0:
                let addressVC = YDReceiverAddressTableViewController()
                addressVC.delegagte = self
                self.navigationController?.pushViewController(addressVC, animated: true)
            case 1 + storeGroupCount:
                if indexPath.row == 0 {//现金券
                    let cCount = model.couponCount ?? 0
                    if cCount > 0 {
                        let couponListVC = ZXValidCouponListViewController()
                        var storeIds: Array<String> = []
                        var totalPrices: Array<String> = []
                        for store in model.storeDrugList {
                            storeIds.append(store.storeId)
                            totalPrices.append("\(store.zx_balanceTotalPrice)")
                        }
                        couponListVC.storeIds = storeIds.joined(separator: ",")
                        couponListVC.fullMoneys = totalPrices.joined(separator: ",")
                        couponListVC.selectedCouponList = self.couponList
                        couponListVC.delegate = self
                        self.navigationController?.pushViewController(couponListVC, animated: true)
                    } else {
                        ZXHUD.mbShowFailure(in: self.view, text: "无可用的现金券", delay: ZX.DELAY_INTERVAL)
                    }
                }
            default:
                let index = indexPath.section - 1
                if indexPath.row == 2 {//支付方式 配送方式
                    if index >= 0 {
                        if let store = self.balanceModel?.storeDrugList[indexPath.section - 1] {
                            DispatchQueue.main.async {
                                let take_payWay = ZXTakePayWayViewController()
                                take_payWay.tagIndex = index
                                take_payWay.isSupportDistribution = store.zx_isSupportDistribution
                                take_payWay.payType = store.zx_paymentType
                                take_payWay.receiveType = store.zx_receiveType
                                take_payWay.delegate = self
                                self.present(take_payWay, animated: true, completion: nil)
                            }
                        }
                    } else {
                        ZXHUD.mbShowFailure(in: self.view, text: "信息不存在", delay: ZX.DELAY_INTERVAL)
                    }
                   
                } else if indexPath.row == 3 { //备注
                    if index >= 0 {
                        if let store = self.balanceModel?.storeDrugList[indexPath.section - 1] {
                            DispatchQueue.main.async {
                                let remark = ZXBalanceRemarkViewController()
                                remark.delegate = self
                                remark.tagIndex = indexPath.section - 1//第一行地址
                                remark.remark = store.remark
                                self.present(remark, animated: true, completion: nil)
                            }
                        }
                    } else {
                        ZXHUD.mbShowFailure(in: self.view, text: "信息不存在", delay: ZX.DELAY_INTERVAL)
                    }
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let model = self.balanceModel {
            let storeGroupCount = model.storeDrugList.count
            switch indexPath.section {
                case 0:
                    return UITableViewAutomaticDimension
                case 1 + storeGroupCount:
                    return 45
                default:
                    switch indexPath.row {
                        case 1://商品列表
                            return ZXBalanceOrderGoodsCell.rowHeight
                        default:
                            return 45
                    }
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
}

extension ZXBalanceViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let model = self.balanceModel {
            let storeGroupCount = model.storeDrugList.count
            switch indexPath.section {
            case 0://收货地址
                let cell = tableView.dequeueReusableCell(withIdentifier: ZXOrderAddressCell.reuseIdentifier, for: indexPath) as! ZXOrderAddressCell
                if let selectedAddress = self.selectedAddress {
                    cell.reloadData(address: selectedAddress)
                } else {
                    cell.reloadData(address: balanceModel?.address)
                }
                return cell
            case 1 + storeGroupCount:// 现金券、总运费、总金额
                let cell = tableView.dequeueReusableCell(withIdentifier: ZXBalanceOrderLRTextCell.reuseIdentifier, for: indexPath) as! ZXBalanceOrderLRTextCell
                cell.showRightArrow(false)
                cell.lbCouponLabel.isHidden = true
                cell.lbCouponLabel.text = ""
                switch indexPath.row {
                    case 0:
                        cell.showRightArrow(true)
                        cell.lbLeftText.text = "现金券"
                        let cPrice = self.toalCouponPrice
                        if cPrice > 0 {
                            cell.lbRightText.text = "-" + "\(cPrice)".zx_priceString()
                        } else {
                            cell.lbRightText.text = "未使用"
                        }
                        cell.lbCouponLabel.isHidden = false
                        let cCount = self.balanceModel?.couponCount ?? 0
                        cell.lbCouponLabel.text = "\(cCount)张可用"
                    case 1:
                        cell.lbLeftText.text = "总运费"
                        cell.lbRightText.text = "\(self.totalFreight)".zx_priceString()
                    case 2:
                        cell.lbLeftText.text = "药品总金额"
                        cell.lbRightText.text = "\(self.totalOriginalPrice)".zx_priceString()
                    default:
                        break
                }
                return cell
            default:
                //商品数据
                let index = indexPath.section - 1
                if index >= 0 {
                    let store = self.balanceModel?.storeDrugList[index]
                    switch indexPath.row {
                        case 0://店铺
                            let cell = tableView.dequeueReusableCell(withIdentifier: ZXBalanceOrderHeaderCell.reuseIdentifier, for: indexPath) as! ZXBalanceOrderHeaderCell
                            cell.reloadData(store: store)
                            return cell
                        case 1://药品
                            let cell = tableView.dequeueReusableCell(withIdentifier: ZXBalanceOrderGoodsCell.reuseIdentifier, for: indexPath) as! ZXBalanceOrderGoodsCell
                            cell.reloadData(store: store)
                            return cell
                        case 2,3:
                            
                            let cell = tableView.dequeueReusableCell(withIdentifier: ZXBalanceOrderLRTextCell.reuseIdentifier, for: indexPath) as! ZXBalanceOrderLRTextCell
                            cell.lbCouponLabel.text = ""
                            cell.lbCouponLabel.isHidden = true
                            cell.showRightArrow(true)
                            if indexPath.row == 2 {
                                cell.lbLeftText.text = "配送及支付方式"
                                cell.lbRightText.text = store?.zx_expressDecription
                            } else {//备注
                                cell.lbLeftText.text = "备注"
                                if let store = store,!store.remark.isEmpty {
                                    cell.lbRightText.text = store.remark
                                } else {
                                    cell.lbRightText.text = "无"
                                }
                            }
                            return cell
                        case 4://单店总金额
                            let cell = tableView.dequeueReusableCell(withIdentifier: ZXBalanceOrderFooterCell.reuseIdentifier, for: indexPath) as! ZXBalanceOrderFooterCell
                            cell.reloadData(store: store)
                            return cell
                        default:
                            break
                    }
                }
            }
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ZXBalanceOrderLRTextCell.reuseIdentifier, for: indexPath) as! ZXBalanceOrderLRTextCell
        cell.lbCouponLabel.text = ""
        cell.lbCouponLabel.isHidden = true
        cell.showRightArrow(true)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let model = self.balanceModel {
            let storeGroupCount = model.storeDrugList.count
            switch section {
            case 0:
                return 1
            case 1 + storeGroupCount:
                return 3
            default:
                return 5
            }
        }
        
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let model = self.balanceModel {
            //地址        店铺商品                  总金额信息
            return 1 + model.storeDrugList.count + 1
        }
        return 0
    }
}
extension ZXBalanceViewController: ZXAddressListSelectedDelegate {
    //MARK: - 地址选择
    func zxAddressListSelected(_ address: YDReceiverAddressModel?) {
        if let address = address {
            let sAddr = ZXBalanceAddress()
            sAddr.id = address.uid
            sAddr.consignee = address.consignee
            sAddr.cityAddress = address.cityAddress
            sAddr.address = address.detailAddress
            sAddr.tel = address.tel
            if address.status == "1" {
                sAddr.status = 1
            } else {
                sAddr.status = 0
            }
            if address.isDefault == "1" {
                sAddr.isDefault = 1
            } else {
                sAddr.isDefault = 0
            }
            sAddr.isDefaultStr = address.isDefaultStr
            sAddr.memberId = address.memberId
            self.selectedAddress = sAddr
            self.tblList.reloadSections(IndexSet([0]), with: .none)
        }
    }
}

extension ZXBalanceViewController: ZXBalanceRemarkDelegate,ZXValidCouponListCheckDelegate,ZXTakePayWayDelegate {
    //MARK: - 地址选择
    
    //MARK: - 备注填写
    func zxRemarkInputDone(text: String, tag index: Int) {
        if index >= 0 {
            let store = self.balanceModel?.storeDrugList[index]
            store?.remark = text
            self.tblList.reloadSections(IndexSet([index + 1]), with: .none)
        }
    }
    
    //MARK: - 现金券选择
    func zxValidCouponListChecked(storeId: String, coupon: ZXOrderCouponModel) {
        selectedCouponList[storeId] = coupon
        var count = 0
        if let model = self.balanceModel,model.storeDrugList.count > 0 {
            count += model.storeDrugList.count
        }
        self.tblList.reloadSections(IndexSet([1 + count]), with: .none)
        self.updateTotalPrice()
    }
    //MARK: - 现金券取消选择
    func zxValidCouponListUnChecked(storeId: String, coupon: ZXOrderCouponModel) {
        selectedCouponList.removeValue(forKey: storeId)
        var count = 0
        if let model = self.balanceModel,model.storeDrugList.count > 0 {
            count += model.storeDrugList.count
        }
        self.tblList.reloadSections(IndexSet([1 + count]), with: .none)
        self.updateTotalPrice()
    }
    //MARK: - 支付方式 收货方式
    func zxTakePayWayViewController(vc: ZXTakePayWayViewController, at index: Int, payType: Int, receiveType: Int) {
        if let store = self.balanceModel?.storeDrugList[index] {
            store.zx_receiveType = receiveType
            store.zx_paymentType = payType
        }
        //self.tblList.reloadSections(IndexSet([1 + index]), with: .none)
        //会涉及运费更新 影响总价格 还是全部刷新
        self.tblList.reloadData()
        self.updateTotalPrice()
    }
}
