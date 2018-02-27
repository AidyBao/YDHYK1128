//
//  ZXCart.swift
//  YDY_GJ_3_5
//
//  Created by screson on 2017/5/24.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit
import MJExtension

/// 会员信息
class ZXMemberInfoModel: NSObject {
    var memberId: String = ""
    var name: String = ""
    var headPortraitFilesStr: String = ""
    var tel: String = ""
    var sex: Int = 0 // 1男
    var sexStr: String = ""
    var recommendedName: String = ""//推荐人姓名
    var ageGroupsStr: String = ""//年龄段
    var joinDateString: String = ""//加入时间 年月
    var recommenderCount: NSNumber?
    var memberIntegral: Int = 0//积分
    var orderSum: Int = 0//消费次数
    var joinDate: Int64 = 0
    
    override static func mj_replacedKeyFromPropertyName() -> [AnyHashable : Any]! {
        return ["memberId": "id"]
    }
}


/// 本地购物篮只存储药品 ID 和 数量
/// 跳转到药篮是，调取接口获取实时数据
class ZXDrugBuyModel: NSObject {
    var drugId:String = ""      //drug id gift id
    //MARK: - 药篮用
    var selectedCount:Int = 0   //加入药篮数量
    var checked:Bool = true    //药篮选中药品
}

/// 购物篮信息
class ZXCartModel: NSObject {
    
    static func postCartUpdateNotice() {
        NotificationCenter.default.post(name: NSNotification.Name.init("CartUpdateNotice"), object: nil, userInfo: nil)
    }
    fileprivate var storeDrugList: Dictionary<String,Dictionary<String,ZXDrugBuyModel>> = [:]
    
    
    /// ZXDrugBuyModel
    ///
    /// - Parameters:
    ///   - storeId:
    ///   - drugId:
    /// - Returns:
    func modelFor(storeId: String,drugId: String) -> ZXDrugBuyModel? {
        if let store = storeDrugList[storeId],let drug = store[drugId] {
            return drug
        } else {
            return nil
        }
    }
    
    /// Drug list for store
    ///
    /// - Parameter storeId:
    /// - Returns: 
    func modelsListFor(storeId: String) -> [ZXDrugBuyModel]? {
        if let store = storeDrugList[storeId] {
            var list: Array<ZXDrugBuyModel> = []
            for drug in store.values {
                list.append(drug)
            }
            return list
        }
        return nil
    }
    
    /// 选中、取消选中
    ///
    /// - Parameters:
    ///   - sid: sid description
    ///   - checked: checked description
    func check(storeId: String,drugId: String,checked: Bool) {
        if let store = storeDrugList[storeId],let drug = store[drugId] {
            drug.checked = checked
        }
    }
    
    /// 选中、取消选中 - 某个店铺全部
    ///
    /// - Parameters:
    ///   - storeId:
    ///   - check:
    func checkAll(storeId: String, check: Bool) {
        if let drugs = storeDrugList[storeId] {
            for model in drugs.values {
                model.checked = check
            }
        }
    }
    
    /// 选中、取消选中 - 全部
    ///
    /// - Parameter check: check description
    func checkAll(_ check:Bool) {
        for drugs in storeDrugList.values {
            for model in drugs.values {
                model.checked = check
            }
        }
    }
    
    /// 删除某一件
    ///
    /// - Parameter sid: sid description
    func delete(storeId: String,drugId: String) {
        storeDrugList[storeId]?.removeValue(forKey: drugId)
        if let storeDrugs = storeDrugList[storeId] {
            if storeDrugs.count == 0 {
                storeDrugList.removeValue(forKey: storeId)
            }
        }
        ZXCartModel.postCartUpdateNotice()
    }
    
    /// 判断所有商品是否选中
    var isAllChecked:Bool {
        get {
            if storeDrugList.count == 0 {
                return false
            }
            if storeDrugList.values.count > 0 {
                var allChecked = true
                for drugs in storeDrugList.values {
                    for model in drugs.values {
                        if !model.checked {
                            allChecked = false
                            break
                        }
                    }
                }
                return allChecked
            }
            return false
        }
    }
    
    ///已选择商品列表
    var selectedModels:Array<ZXDrugBuyModel>? {
        get {
            if storeDrugList.count > 0 {
                var list = [ZXDrugBuyModel]()
                for drugs in storeDrugList.values {
                    for model in drugs.values {
                        if model.checked {
                            list.append(model)
                        }
                    }
                }
                return list
            }
            return nil
        }
    }
    
    
    /// 待结算 jsonstring
    var zx_selectedJsonString: String? {
        if storeDrugList.count > 0 {
            var arrID:Array<Dictionary<String,Any>> = []
            for storeId in storeDrugList.keys {
                var storeDrug:Dictionary<String,Any> = [:]
                var hasGoods = false
                storeDrug["drugstoreId"] = storeId
                if let drugs = storeDrugList[storeId] {
                    var items:Array<Dictionary<String,Any>> = []
                    for model in drugs.values {
                        if model.checked {
                            hasGoods = true
                            items.append(["drugId": model.drugId,"num": model.selectedCount])
                        }
                    }
                    if hasGoods {
                        storeDrug["items"] = items
                    }
                }
                if hasGoods {
                    arrID.append(storeDrug)
                }
            }
            if (!JSONSerialization.isValidJSONObject(arrID)) {
                return nil
            }
            if let data = try? JSONSerialization.data(withJSONObject: arrID, options: []) {
                return String(data:data, encoding: String.Encoding.utf8)
            }
        }
        return nil
    }
    
    /// 数量减 1~n
    ///
    /// - Parameters:
    ///   - storeId:
    ///   - drugId:
    ///   - num:
    func sub(storeId: String,drugId: String,num: Int = 1) {
        if let store = storeDrugList[storeId],let drug = store[drugId] {
            drug.selectedCount -= num
            if drug.selectedCount <= 0 {
                self.delete(storeId: storeId, drugId: drugId)
            }
        } else {
            self.delete(storeId: storeId, drugId: drugId)
        }
        ZXCartModel.postCartUpdateNotice()
    }
    
    /// 数量加 1~n
    /// - Parameters:
    ///   - storeId:
    ///   - drugId:
    ///   - num:
    func plus(storeId: String,drugId: String,num: Int = 1) {
        var count = num
        if count <= 0 {
            count = 1
        }
        var drugs:Dictionary<String,ZXDrugBuyModel> = [:]
        if let lastDrugs = self.storeDrugList[storeId] {
            drugs = lastDrugs
        }
        
        if let drug = drugs[drugId] {
            drug.selectedCount += count
        } else {
            let model = ZXDrugBuyModel()
            model.drugId = drugId
            model.selectedCount = count
            drugs[drugId] = model //追加
            storeDrugList[storeId] = drugs
        }
        ZXCartModel.postCartUpdateNotice()
    }
    
    
    /// 设置商品数量
    ///
    /// - Parameters:
    ///   - storeId:
    ///   - drugId:
    ///   - num: num > 0
    func setNum(storeId: String,drugId: String,num:Int) {
        if num > 0 {
            
            var drugs:Dictionary<String,ZXDrugBuyModel> = [:]
            if let lastDrugs = self.storeDrugList[storeId] {
                drugs = lastDrugs
            }
            
            if let drug = drugs[drugId] {
                drug.selectedCount = num
            } else {
                let model = ZXDrugBuyModel()
                model.drugId = drugId
                model.selectedCount = num
                drugs[drugId] = model //追加
                storeDrugList[storeId] = drugs
            }
        }
        ZXCartModel.postCartUpdateNotice()
    }
    
    /// 总商品数
    var totalCount: Int {
        get {
            var tCount = 0
            for drugs in storeDrugList.values {
                for model in drugs.values {
                    tCount += model.selectedCount
                }
            }
            return tCount
        }
    }

    //jsonstring
    var cartJsonString: String? {
        get {
            if storeDrugList.count > 0 {
                var arrID:Array<Dictionary<String,Any>> = []
                for storeId in storeDrugList.keys {
                    var storeDrug:Dictionary<String,Any> = [:]
                    storeDrug["drugstoreId"] = storeId
                    if let drugs = storeDrugList[storeId] {
                        var drugIds:Array<Dictionary<String,Any>> = []
                        for model in drugs.values {
                            drugIds.append(["drugId": model.drugId])
                        }
                        storeDrug["items"] = drugIds
                    }
                    arrID.append(storeDrug)
                }
                if (!JSONSerialization.isValidJSONObject(arrID)) {
                    return nil
                }
                if let data = try? JSONSerialization.data(withJSONObject: arrID, options: []) {
                    return String(data:data, encoding: String.Encoding.utf8)
                }
            }
            return nil
        }
    }
    
    /// 已选择的商品总数
    var selectedTotalCount: Int {
        get {
            var tCount = 0
            for drugs in storeDrugList.values {
                for model in drugs.values {
                    if model.checked {
                        tCount += model.selectedCount
                    }
                }
            }
            return tCount
        }
    }
    
    var hasOneChecked: Bool {
        get {
            var checked = false
            for drugs in storeDrugList.values {
                for model in drugs.values {
                    if model.checked {
                        checked = true
                        break
                    }
                }
                if checked {
                    break
                }
            }
            return checked
        }
    }
}

class ZXCart: NSObject {
    fileprivate static var zxcart:ZXCartModel?
    static var cart:ZXCartModel {
        get {
            if zxcart == nil {
                zxcart = ZXCartModel()
            }
            return zxcart!
        }
    }
    
    static func clear() {
        zxcart?.storeDrugList.removeAll()
        zxcart = nil
    }
}
