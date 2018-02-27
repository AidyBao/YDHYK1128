//
//  ZXDrugModel.swift
//  YDY_GJ_3_5
//
//  Created by screson on 2017/5/25.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

/// 药品库 药品列表Model
class ZXDrugModel: NSObject {
    var drugstoreId:Int32 = 0
    //var drugId:Int32 = 0       //柜台药品id
    var baseDrugId:Int32 = 0 //基础药品id
    var drugName:String = ""
    var functionIndications:String = "" // 功能主治
    var indication:String = "" // 适应症
    var approvalNumber:String = "" //国药准字号
    var isPrescription:Int = 0  //是否处方药
    var packingSpec:String = ""
    var price:NSNumber = 0
    var activePrice:NSNumber = 0
    //结算数量
    var num: Int = 0
    
    var attachFilesStrs:Array<String> = []
    //Native Cart Data
    var zx_buyCount: Int = 0
    var zx_checked = false
    var zx_sectionIndex: Int = 0 //用于Cell删除

    var zx_imageUrl: URL? {
        if let path = attachFilesStrs.first, let url = URL.init(string: ZXIMG_Address(path)) {
            return url
        }
        return nil
    }
    
    var zx_truePrice:Double {
        get {
            if activePrice.doubleValue > 0 {
                return activePrice.doubleValue
            }
            return price.doubleValue
        }
    }
}

class ZXDrugSpecModel:NSObject {
    var name = ""
    var price = ""
    var baseDrugId = "" //baseDrugId 基础药品Id
    var isColl = false
    
    var size:CGSize {
        get{
            var rect = ZXStringUtils.caculateStringSize(with: name, font: UIFont.zx_titleFont(withSize: zx_bodyFontSize() - 1), limitSize: CGSize(width: ZX.BOUNDS_WIDTH - 28, height: CGFloat.greatestFiniteMagnitude))
            let dis = rect.width - 60
            if fabs(dis) >= 30 {
                if dis < 0 {
                    rect.width = 60
                } else {
                    rect.width += 30
                }
            } else {
                rect.width += 30
            }
            if rect.height < 24 {
                rect.height = 24
            }
            return CGSize(width: rect.width, height: rect.height)
        }
    }
}

/// 药品详情Model
class ZXDrugDetailModel: NSObject {
    //var drugId:Int32 = 0  //柜台药品id
    var baseDrugId:Int32 = 0 //基础药品id
    var groupId:Int32 = 0
    var groupName:String = ""
    var drugstoreId:Int32 = 0
    var drugstoreName:String = ""
    var groupDrugId:Int32 = 0
    var drugName:String = ""
    var approvalNumber:String = ""
    
    var packingSpec:String = ""
    var unitPrice:Double = 0
    var price:NSNumber = 0
    var activePrice:NSNumber = 0
    var isColl:Int = 0
    
    var inventory:Int = 0
    var status:Int = 0
    var hotStatus:Int = 0
    var discountStatus:Int = 0
    var sourceType:Int = 0
    var operatorId:Int32 = 0
    var operatorName:String = ""
    var operationDate:Int = 0
    var barCode:String = ""
    var generalName:String = ""
    var drugNamePhonetic:String = ""
    var drugSortId:Int32 = 0
    var drugSortName:String = ""
    var drugAdaptRangeId:Int32 = 0
    var functionIndications:String = "" //功能主治
    var ingredients:String = ""         //药品成分
    var indication:String = ""          //适应症
    var usageDosage:String = ""         //用法用量
    var untowardEffect:String = ""      //不良反应
    var notes:String = ""               //注意事项
    var medicationTaboo:String = ""     //用药禁忌
    var manufacturer:String = ""        //生产厂商
    var formulation:String = ""         //药品剂型
    var interaction:String = ""         //相互作用
    var agedTaboo:String = ""           //老年患者用药
    var childrenTaboo:String = ""       //儿童用药
    var pregnantTaboo:String = ""       //孕妇及哺乳期用药
    //var attachFiles:String = ""
    var isPrescription:Int = 0
    var isHealthInsurance:Int = 0
    var type:Int = 0
    var remark:String = ""
    
    var attachFilesStrs:Array<String> = []
    //多规格  ### 分隔
    var packingSpecs:String = ""
    var prices:String = ""
    var activePrices:String = ""
    //var drugIds:String = ""
    var baseDrugIds:String = ""
    var isColls:String = "" //收藏
    
    fileprivate var specList: Array<ZXDrugSpecModel>?
    var zx_specList: Array<ZXDrugSpecModel> {
        get {
            if let list = self.specList,list.count > 0 {
                return list
            } else {
                self.specList = []
                let slist = packingSpecs.components(separatedBy: "###")
                let priceList = prices.components(separatedBy: "###")
                let collList = isColls.components(separatedBy: "###")
                var activePriceList = priceList
                if activePrices.characters.count > 0 {
                    activePriceList = activePrices.components(separatedBy: "###")
                }

                let durgIdList = baseDrugIds.components(separatedBy: "###")
                for (idx,s) in slist.enumerated() {
                    let spec = ZXDrugSpecModel.init()
                    spec.name = s
                    spec.baseDrugId = durgIdList[idx]
                    if let aprice = Double(activePriceList[idx]),aprice > 0 {
                        spec.price = activePriceList[idx]
                    } else {
                        spec.price = priceList[idx]
                    }
                    if collList[idx] == "1" {
                        spec.isColl = true
                    }
                    self.specList?.append(spec)
                }
                return specList!
            }
        }
    }
    
    fileprivate var defaultSpec: ZXDrugSpecModel?
    var zx_defaultSpec: ZXDrugSpecModel {
        get {
            if defaultSpec == nil {
                defaultSpec = ZXDrugSpecModel.init()
                defaultSpec?.name = self.packingSpec
                defaultSpec?.baseDrugId = "\(self.baseDrugId)"
                defaultSpec?.price = "\(self.zx_truePrice)"
                if self.isColl == 1 {
                    defaultSpec?.isColl = true
                }
            }
            return defaultSpec!
        }
    }
    
    
    var zx_truePrice: Double {
        get {
            if activePrice.doubleValue > 0 {
                return activePrice.doubleValue
            }
            return price.doubleValue
        }
    }
    
    var zx_infomation: String {
        get {
            var htmlStr = "<html><head><title></title><meta charset='utf-8'></head>"
            htmlStr += "<body>"
            htmlStr += "<div style='height: 100%;width: 100%;'>"
            htmlStr += self.div("药品名称", content: drugName)
            htmlStr += self.div("功能主治", content: functionIndications)
            htmlStr += self.div("药品成分", content: ingredients)
            htmlStr += self.div("适应症", content: indication)
            htmlStr += self.div("用法用量", content: usageDosage)
            htmlStr += self.div("不良反应", content: untowardEffect)
            htmlStr += self.div("注意事项", content: notes)
            htmlStr += self.div("用药禁忌", content: medicationTaboo)
            htmlStr += self.div("生产厂商", content: manufacturer)
            htmlStr += self.div("药品剂型", content: formulation)
            htmlStr += self.div("相互作用", content: interaction)
            htmlStr += self.div("老年人用药", content: agedTaboo)
            htmlStr += self.div("儿童用药", content: childrenTaboo)
            htmlStr += self.div("孕妇及哺乳期用药", content: pregnantTaboo)
            htmlStr += "</div>"
            htmlStr += "</body>"
            htmlStr += "</html>"
            return htmlStr
        }
    }
    
    fileprivate func div(_ title:String,content:String) -> String {
        var div = "<div style='color:#3b3e43'>"
        div += "<h4>"
        div += title
        div += "</h4>"
        div += "<p style='font-size:12px;'>"
        if content.characters.count > 0 {
            div += content
        } else {
            div += "暂无"
        }
        div += "</p>"
        //div += "<div style='height: 1px;background-color: #dce0e5;></div>"
        div += "</div>"
        return div
    }
}


