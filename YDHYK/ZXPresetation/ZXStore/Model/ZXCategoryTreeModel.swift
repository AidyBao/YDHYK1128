//
//  ZXCategoryTreeModel.swift
//  YDY_GJ_3_5
//
//  Created by screson on 2017/5/25.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit


/// 药品分类 、 树
class ZXCategoryTreeModel: NSObject {
    var cid:String =  ""
    var name:String =  ""
    var parentId:Int64 =  2
    var parentIdStr:String =  "12"
    var status:Int =  1
    var remark:String =  ""
    var icon:String =  ""
    var operatorId:Int =  9
    var operatorName:String =  ""
    var operationDate:Int64 =  0
    var levels:Int =  2
    var childList:Array<ZXCategoryTreeModel>?
    var zx_iconStr:String? {
        get {
            if !icon.isEmpty {
                return ZXIMG_Address(icon)
            }
            return nil
        }
    }
    var operationDateStr:String =  ""

    override static func mj_replacedKeyFromPropertyName() -> [AnyHashable : Any]! {
        return ["cid":"id"]
    }
    
    override static func mj_objectClassInArray() -> [AnyHashable : Any]! {
        return ["childList":ZXCategoryTreeModel.classForCoder()]
    }
}
