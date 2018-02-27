//
//  ZXStoreHomeViewModel.swift
//  YDHYK
//
//  Created by screson on 2017/10/12.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

class ZXStoreHomeViewModel: NSObject {
    
    /// 药店首页配置内容
    ///
    /// - Parameters:
    ///   - storeId:
    ///   - memberId:
    ///   - token:
    ///   - completion:
    static func getHomePage(storeId: String,
                            memberId: String,
                            token: String,
                            completion:((_ status: Bool,_ code: Int,_ errorMsg: String,_ model: ZXStoreModel?) -> Void)?) {
        ZXNetworkEngine.asycnRequest(withURL: ZXStore_Address(ZXAPI_STORE_HOME), params: ["drugstoreId":storeId,"memberId":memberId], token: token, method: POST) { (obj, code, success, msg) in
            if code == ZXAPI_SUCCESS {
                if let obj = obj as? Dictionary<String,Any>,let data = obj["data"] as? Dictionary<String,Any>,let model = ZXStoreModel.mj_object(withKeyValues: data) {
                    completion?(true,code,"",model)
                } else {
                    completion?(true,code,msg ?? "",nil)
                }
            } else {
                completion?(false,code,msg ?? "",nil)
            }
        }
    }
    
    /// 猜您需药
    ///
    /// - Parameters:
    ///   - storeId:
    ///   - memberId:
    ///   - token:
    ///   - completion:
    static func recommendList(storeId: String,
                              memberId: String,
                              token: String,
                              completion:((_ status: Bool,_ code: Int,_ errorMsg: String,_ model: [ZXDrugModel]) -> Void)?) {
        ZXNetworkEngine.asycnRequest(withURL: ZXStore_Address(ZXAPI_STORE_RECOMMEND), params: ["drugstoreId":storeId,"memberId":memberId], token: token, method: POST) { (obj, code, success, msg) in
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
    
    /// 药品分类树
    ///
    /// - Parameters:
    ///   - storeId:
    ///   - memberId:
    ///   - token:
    ///   - completion:
    static func categoryTree(storeId: String,
                             memberId: String,
                             token: String,
                             completion:((_ status: Bool,_ code: Int,_ errorMsg: String,_ model: [ZXCategoryTreeModel]) -> Void)?) {
        ZXNetworkEngine.asycnRequest(withURL: ZXStore_Address(ZXAPI_STORE_CATEGORY_TREE), params: ["drugstoreId":storeId,"memberId":memberId], token: token, method: POST) { (obj, code, success, msg) in
            if code == ZXAPI_SUCCESS {
                if let obj = obj as? Dictionary<String,Any>,let data = obj["data"] as? Array<Any>,data.count > 0 {
                    var list: Array<ZXCategoryTreeModel> = []
                    for m in data {
                        list.append(ZXCategoryTreeModel.mj_object(withKeyValues: m))
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
    
    /// 药品列表检索、分类检索
    ///
    /// - Parameters:
    ///   - searchValue:
    ///   - categoryId:
    ///   - pageNum:
    ///   - pageSize:
    ///   - userId:
    ///   - storeId:
    ///   - token:
    ///   - completion:
    static func searchDrugList(_ searchValue:String?,
                               categoryId:String?,
                               pageNum:Int,
                               pageSize:Int,
                               memberId:String,
                               storeId:String,
                               token:String,
                               completion:((_ code:Int,_ success:Bool,_ list:Array<ZXDrugModel>?,_ msg:String) -> Void)?) {
        var dicp:Dictionary<String,Any> = [:]
        dicp["memberId"]  = memberId
        dicp["drugstoreId"]  = storeId
        if let searchValue = searchValue {//模糊搜索条件 当drugSortId为空时必填
            dicp["searchName"] = searchValue
        } else if let categoryId = categoryId{//药品类型ID
            dicp["drugSortId"] = categoryId
        }
        
        dicp["pageNum"] = (pageNum <= 0 ? 0 : pageNum)
        dicp["pageSize"] = (pageSize <= 0 ? 0 : pageSize)
        ZXNetworkEngine.asycnRequest(withURL: ZXStore_Address(ZXAPI_STORE_SEARCH), params: dicp, token: token, method: POST) { (obj, code, success, msg) in
            if success {
                if let obj = obj as? Dictionary<String,Any>,let data = obj["data"] as? Dictionary<String,Any> {
                    if let listData = data["listData"] as? Array<Any>,listData.count > 0 {
                        var list = [ZXDrugModel]()
                        for dic in listData {
                            list.append(ZXDrugModel.mj_object(withKeyValues: dic))
                        }
                        completion?(code,true,list,"")
                    }else{
                        completion?(code,true,nil,msg ?? "")
                    }
                }else{
                    completion?(code,true,nil,msg ?? "")
                }
            }else{
                completion?(code,false,nil,msg ?? "")
            }
        }
    }
    
    
    /// 活动商品列表
    ///
    /// - Parameters:
    ///   - drugstoreTemplateId:
    ///   - activeItem:
    ///   - pageNum:
    ///   - pageSize:
    ///   - memberId:
    ///   - storeId:
    ///   - token:
    ///   - completion: 
    static func activeList(_ drugstoreTemplateId: String?,
                           activeItem: String?,
                           pageNum: Int,
                           pageSize: Int,
                           memberId: String,
                           storeId: String,
                           token: String,
                           completion: ((_ code:Int,_ success:Bool,_ list:Array<ZXDrugModel>?,_ msg:String) -> Void)?) {
        var dicp:Dictionary<String,Any> = [:]
        dicp["drugstoreTemplateId"] = drugstoreTemplateId
        dicp["activeItem"] = activeItem
        dicp["memberId"]  = memberId
        dicp["drugstoreId"]  = storeId
        dicp["pageNum"] = (pageNum <= 0 ? 0 : pageNum)
        dicp["pageSize"] = (pageSize <= 0 ? 0 : pageSize)
        ZXNetworkEngine.asycnRequest(withURL: ZXStore_Address(ZXAPI_STORE_ACTIVELIST), params: dicp, token: token, method: POST) { (obj, code, success, msg) in
            if success {
                if let obj = obj as? Dictionary<String,Any>,let data = obj["data"] as? Dictionary<String,Any> {
                    if let listData = data["listData"] as? Array<Any>,listData.count > 0 {
                        var list = [ZXDrugModel]()
                        for dic in listData {
                            list.append(ZXDrugModel.mj_object(withKeyValues: dic))
                        }
                        completion?(code,true,list,"")
                    }else{
                        completion?(code,true,nil,msg ?? "")
                    }
                }else{
                    completion?(code,true,nil,msg ?? "")
                }
            }else{
                completion?(code,false,nil,msg ?? "")
            }
        }
    }
}
