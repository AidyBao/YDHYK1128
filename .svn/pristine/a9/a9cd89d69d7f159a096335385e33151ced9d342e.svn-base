//
//  ZXDrugStoreViewModel.swift
//  YDHYK
//
//  Created by screson on 2017/10/18.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

class ZXBalanceAddress: NSObject {
    var id = ""
    var consignee = ""
    var cityAddress = ""
    var address = ""
    var tel = ""
    var status = 1
    var remark = ""
    var code = ""
    var isDefault = 0
    var isDefaultStr = "是"
    var memberId = ""
    
    var zx_isDefault: Bool {
        return isDefault == 1 ? true : false
    }
    var zx_address: String {
        return cityAddress + address
    }
}

//结算界面Model
class ZXBalanceModel: NSObject {
    var storeDrugList: Array<ZXStoreDetailModel> = []
    var errorDurgIdList: Array<String> = []
    var address: ZXBalanceAddress?
    var couponCount: Int = 0
}

class ZXDrugStoreViewModel: NSObject {
    /// 获取店铺详情
    ///
    /// - Parameters:
    ///   - storeId:
    ///   - memberId:
    ///   - token:
    ///   - completion: 
    static func storeDetail(storeId: String,
                            memberId: String,
                            token: String,
                            completion:((_ status: Bool,_ code: Int,_ errorMsg: String,_ model: ZXStoreDetailModel?) -> Void)?) {
        ZXNetworkEngine.asycnRequest(withURL: ZXStore_Address(ZXAPI_STORE_INFO), params: ["drugstoreId":storeId,"memberId":memberId], token: token, method: POST) { (obj, code, success, msg) in
            if code == ZXAPI_SUCCESS {
                if let obj = obj as? Dictionary<String,Any>,let data = obj["data"] as? Dictionary<String,Any>,let model = ZXStoreDetailModel.mj_object(withKeyValues: data) {
                    completion?(true,code,"",model)
                } else {
                    completion?(true,code,msg ?? "",nil)
                }
            } else {
                completion?(false,code,msg ?? "",nil)
            }
        }
    }
    
    
    /// 获取购物车列表
    ///
    /// - Parameters:
    ///   - cartData: jsonString：[{drugstoreId="111","items":[{"drugId":111},{"drugId":222}]}]
    ///   - memberId:
    ///   - token:
    ///   - completion: 
    static func cartList(cartData: String,
                         memberId: String,
                         token: String,
                         completion:((_ code: Int, _ status: Bool,_ drugList:[ZXDrugModel]?,_ storeList:Dictionary<String,ZXStoreDetailModel>?,_ errordrugList:[String]?,_ errorMsg: String) -> Void)?) {
        ZXNetworkEngine.asycnRequest(withURL: ZXStore_Address(ZXAPI_STORE_CART), params: ["cartData":cartData,"memberId":memberId], token: token, method: POST) { (obj, code, success, msg) in
            if success {
                if let obj = obj as? Dictionary<String,Any> {
                    var drugList = [ZXDrugModel]()
                    if let listData = obj["data"] as? Array<Any>,listData.count > 0 {
                        for dic in listData {
                            drugList.append(ZXDrugModel.mj_object(withKeyValues: dic))
                        }
                    }
                    var errorDrugList = [String]()
                    if let listData = obj["errorDrugIdList"] as? Array<String> {
                        errorDrugList = listData
                    }
                    var storeList: Dictionary<String,ZXStoreDetailModel> = [:]
                    if let listData = obj["drugstoreList"] as? Array<Any>,listData.count > 0 {
                        for dic in listData {
                            if let model = ZXStoreDetailModel.mj_object(withKeyValues: dic) {
                                storeList[model.storeId] = model
                            }
                        }
                    }
                    completion?(code,true,drugList,storeList,errorDrugList,"解析失败")
                } else {
                    completion?(code,true,nil,nil,nil,"解析失败")
                }
            }else{
                completion?(code,false,nil,nil,nil,msg ?? "")
            }
        }
    }
    
    
    /// 结算
    ///
    /// - Parameters: cartData: jsonString：[{"drugstoreId":"2000002","items":[{"drugId":111,"num":1},{"drugId":222,"num":1}]}]
    ///   - cartData:
    ///   - memberId:
    ///   - token:
    ///   - completion: errordrugList: (storeId###drugId）
    static func balanceAction(cartData: String,
                              memberId: String,
                              token: String,
                              completion:((_ status: Bool,_ code: Int,_ balanceModel: ZXBalanceModel?,_ errorMsg: String) -> Void)?) {
        ZXNetworkEngine.asycnRequest(withURL: ZXStore_Address(ZXAPI_DRUG_BALANCE), params: ["cartData":cartData,"memberId":memberId], token: token, method: POST) { (obj, code, success, msg) in
            if code == ZXAPI_SUCCESS {
                if let obj = obj as? Dictionary<String,Any>,let data = obj["data"] as? Array<Dictionary<String,Any>> {
                    if data.count > 0 {
                        var sList: Array<ZXStoreDetailModel> = []
                        for s in data {
                            if let store = ZXStoreDetailModel.mj_object(withKeyValues: s) {
                                //结算界面用来存储 备注 
                                store.remark = ""
                                sList.append(store)
                            }
                        }
                        var address: ZXBalanceAddress?
                        if let addr = obj["memberAddress"] as? Dictionary<String,Any> {
                            address = ZXBalanceAddress.mj_object(withKeyValues: addr)
                        }
                        var cCount = 0
                        if let count = obj["couponCount"] as? Int {
                            cCount = count
                        }
                        var errorDrugIdList: Array<String> = []
                        if let errList = obj["errorDrugIdList"] as? Array<String> {
                            errorDrugIdList = errList
                        }
                        let bModel = ZXBalanceModel()
                        bModel.storeDrugList = sList
                        bModel.errorDurgIdList = errorDrugIdList
                        bModel.address = address
                        bModel.couponCount = cCount
                        completion?(true,code,bModel,"无相关数据")
                    } else {
                        completion?(true,code,nil,"无相关数据")
                    }
                } else {
                    completion?(true,code,nil,msg ?? "无法解析数据")
                }
            } else {
                completion?(false,code,nil,msg ?? "")
            }
        }
    }
    
    
    static func couponList(drugstoreIds: String,
                           fullMoneys: String,
                           memberId: String,
                           token: String,
                           completion:((_ success: Bool, _ code: Int, _ couponList: [ZXOrderCouponModel]?, _ errorMsg: String ) -> Void)?) {
        ZXNetworkEngine.asycnRequest(withURL: ZXStore_Address(ZXAPI_ORDER_COUPON), params: ["drugstoreIds":drugstoreIds,"fullMoneys":fullMoneys,"memberId":memberId], token: token, method: POST) { (obj, code, success, msg) in
            if code == ZXAPI_SUCCESS {
                if let obj = obj as? Dictionary<String,Any>,let data = obj["data"] as? Array<Dictionary<String,Any>> {
                    if data.count > 0 {
                        var cList: Array<ZXOrderCouponModel> = []
                        for m in data {
                            if let coupon = ZXOrderCouponModel.mj_object(withKeyValues: m) {
                                cList.append(coupon)
                            }
                        }
                        completion?(true,code,cList,"")
                    } else {
                        completion?(true,code,nil,"")
                    }
                } else {
                    completion?(false,code,nil,"数据无法解析")
                }
            } else {
                completion?(false,code,nil,msg ?? "")
            }
        }
    }
    
    /// 保存订单
    ///
    /// - Parameters:
    ///   - orderContent: JsonString
    ///   - memberId:
    ///   - consignee:
    ///   - tel:
    ///   - address:
    ///   - token:
    ///   - completion:
    static func saveOrder(orderContent: String,
                          memberId: String,
                          consignee: String,
                          tel: String,
                          address: String,
                          token: String,
                          completion:((_ success: Bool,_ code: Int,_ errorMsg: String) -> Void)?) {
        ZXNetworkEngine.asycnRequest(withURL: ZXStore_Address(ZXAPI_SAVE_ORDER), params: ["orderContent":orderContent,"consignee":consignee,"tel":tel,"address":address,"memberId":memberId], token: token, method: POST) { (obj, code, success, msg) in
            if code == ZXAPI_SUCCESS {
                completion?(true,code,msg ?? "")
            } else {
                 completion?(false,code,msg ?? "")
            }
        }
    }
}
