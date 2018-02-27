//
//  ZXDrugViewModel.swift
//  YDHYK
//
//  Created by screson on 2017/10/17.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

class ZXDrugViewModel: NSObject {
    static func markDrug(_ mark:Bool,
                         drugId:String,
                         storeId:String,
                         collectPrice:String,
                         userId:String,
                         token:String,
                       completion:((_ code:Int,_ success:Bool,_ errorMsg:String) -> Void)?) {
        var dicp:Dictionary<String,Any> = [:]
        dicp["memberId"]  = userId
        dicp["drugstoreId"] = storeId
        dicp["drugId"] = drugId
        dicp["collectPrice"] = collectPrice
        ZXNetworkEngine.asycnRequest(withURL: ZXStore_Address(ZXAPI_DRUG_MARK), params: dicp, token: token, method: POST) { (obj, code, success, error) in
            if success {
                completion?(code,true,(error) ?? "")
            }else{
                completion?(code,false,(error) ?? "")
            }
        }
    }

    
    static func durgDetailInfo(_ drugId:String,
                               storeId:String,
                               approvalNum:String,
                               userId:String,
                               token:String,
                               completion:((_ code:Int,_ success:Bool,_ drugInfo:ZXDrugDetailModel?,_ storeInfo:ZXStoreDetailModel?,_ errorMsg:String) -> Void)?) {
        var dicp:Dictionary<String,Any> = [:]
        dicp["memberId"]  = userId
        dicp["drugstoreId"] = storeId
        dicp["drugId"] = drugId
        if approvalNum.characters.count > 0 {
            dicp["approvalNumber"] = approvalNum
        }
        ZXNetworkEngine.asycnRequest(withURL: ZXStore_Address(ZXAPI_DRUG_INFO), params: dicp, token: token, method: POST) { (obj, code, success, error) in
            if success {
                if let obj = obj as? Dictionary<String,Any>,let data = obj["data"] as? Dictionary<String,Any>,let drug = data["drug"] as? Dictionary<String,Any>,let store = data["drugstore"] as? Dictionary<String,Any> {
                    
                    completion?(code,true,ZXDrugDetailModel.mj_object(withKeyValues: drug),ZXStoreDetailModel.mj_object(withKeyValues: store),(error) ?? "")
                } else {
                    completion?(code,true,nil,nil,(error) ?? "获取数据失败或无相关信息")
                }
            }else{
                completion?(code,false,nil,nil,(error) ?? "")
            }
        }
        self.record(drugId: drugId, storeId: storeId, userId: userId, approvalNumber: approvalNum, token: token)
    }
    
    /// 添加商品浏览记录
    ///
    /// - Parameters:
    ///   - drugId:
    ///   - storeId:
    ///   - userId:
    ///   - approvalNumber:
    ///   - token:
    static func record(drugId:String,
                       storeId:String,
                       userId:String,
                       approvalNumber:String,
                       token:String){
        var dicp:Dictionary<String,Any> = [:]
        dicp["memberId"]  = userId
        dicp["drugstoreId"] = storeId
        dicp["drugId"] = drugId
        dicp["approvalNumber"] = approvalNumber
        ZXNetworkEngine.asycnRequest(withURL: ZXStore_Address(ZXAPI_DRUG_RECORD), params: dicp, token: token, method: POST) { _ in
            
        }
    }
    
    /// randomList
    ///
    /// - Parameters:
    ///   - storeId:
    ///   - memberId:
    ///   - token:
    ///   - completion:
    static func randomList(storeId: String,
                           memberId: String,
                           token: String,
                           completion:((_ status: Bool,_ code: Int,_ errorMsg: String,_ model: [ZXDrugModel]) -> Void)?) {
        ZXNetworkEngine.asycnRequest(withURL: ZXStore_Address(ZXAPI_DRUG_RELATE), params: ["drugstoreId":storeId,"memberId":memberId], token: token, method: POST) { (obj, code, success, msg) in
            if code == ZXAPI_SUCCESS {
                if let obj = obj as? Dictionary<String,Any>,let data = obj["data"] as? Array<Any>,data.count > 0 {
                    var list: Array<ZXDrugModel> = []
                    for m in data {
                        list.append(ZXDrugModel.mj_object(withKeyValues: m))
                    }
                    completion?(true,code,"",list)
                } else {
                    completion?(true,code,msg ?? "",[])
                }
            } else {
                completion?(false,code,msg ?? "",[])
            }
        }
    }
}
