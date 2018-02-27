//
//  ZXDrugInfosViewController.swift
//  YDHYK
//
//  Created by screson on 2017/10/16.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit


/// 商品说明书
class ZXDrugInfosViewController: ZXSTUIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    var goodsDetailModel: ZXDrugDetailModel? {
        didSet {
            if let model = goodsDetailModel {
                self.webView.loadHTMLString(model.zx_infomation, baseURL: nil)
            } else {
                self.webView.loadHTMLString(self.zx_emptyHtml, baseURL: nil)
            }
            
        }
    }
    
    var zx_emptyHtml:String {
        get {
            var str = "<body style=\"margin : 0\"><table style=\"border-spacing: 0;width:100%\">"
            str += "<tr>"
            str += "<td style=\"font-size:13px; padding:10px; color: #777; \" >无相关信息</td>"
            str += "</tr>"
            str += "</table></body>"
            return str
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.webView.backgroundColor = UIColor.white
        self.webView.scrollView.showsVerticalScrollIndicator = false
        self.webView.scrollView.showsHorizontalScrollIndicator = false
    }
    
}
