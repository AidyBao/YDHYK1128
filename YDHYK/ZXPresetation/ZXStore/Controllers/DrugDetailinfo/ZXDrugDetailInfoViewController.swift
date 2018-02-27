//
//  ZXDrugDetailInfoViewController.swift
//  YDHYK
//
//  Created by screson on 2017/10/16.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit


/// 商品详情 、 店铺详情
class ZXDrugDetailInfoViewController: ZXSTUIViewController,UIScrollViewDelegate {
    static func postStoreUIUpdateNotice() {
        NotificationCenter.default.post(name: NSNotification.Name.init("StoreUIUpdate"), object: nil)
    }
    static func postDrugUIUpdateNotice() {
        NotificationCenter.default.post(name: NSNotification.Name.init("DrugUIUpdate"), object: nil)
    }
    
    var topMenu: ZXSegment!
    var goodsShortModel: ZXDrugModel?
    
    @IBOutlet weak var mainScrollView: UIScrollView!
    
    var drugCommonInfo: ZXDurgCommonInfoViewController!
    var webInfomation: ZXDrugInfosViewController!
    var storeInfo: ZXDrugStoreInfoViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.automaticallyAdjustsScrollViewInsets = false
        self.edgesForExtendedLayout = []
        topMenu = ZXSegment.init(origin: CGPoint.zero
            , mWidth: ZX.BOUNDS_WIDTH - 100)
        topMenu.dataSource = self
        topMenu.delegate = self
        
        self.mainScrollView.contentSize = CGSize(width: ZX.BOUNDS_WIDTH * 3, height: self.view.frame.size.height)
        
        self.navigationItem.titleView = topMenu
        
        self.drugCommonInfo = ZXDurgCommonInfoViewController()
        self.mainScrollView.addSubview(self.drugCommonInfo.view)
        self.addChildViewController(self.drugCommonInfo)
        
        self.webInfomation = ZXDrugInfosViewController()
        self.mainScrollView.addSubview(self.webInfomation.view)
        self.addChildViewController(self.webInfomation)
        
        self.storeInfo = ZXDrugStoreInfoViewController()
        self.mainScrollView.addSubview(self.storeInfo.view)
        self.addChildViewController(self.storeInfo)
        
        self.mainScrollView.delegate = self
        self.drugCommonInfo.shortModel = self.goodsShortModel
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let oFrame = self.view.frame
        webInfomation.view.frame = CGRect(x: ZX.BOUNDS_WIDTH, y: 0, width: oFrame.size.width, height: oFrame.size.height)
        storeInfo.view.frame = CGRect(x: ZX.BOUNDS_WIDTH * 2, y: 0, width: oFrame.size.width, height: oFrame.size.height)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.zx_setNavBarSubViewsColor(UIColor.zx_text())
        self.zx_setNavBarBackgroundColor(UIColor.init(red: 248 / 255.0, green: 246 / 255.0, blue: 248 / 255.0, alpha: 1.0))
        ZXRootViewControllers.setStatusBarForegroundColor(UIColor.zx_text())
        
        if !onceLoad {
            onceLoad = true
            self.drugCommonInfo.fetchDrugDetail(showHUD: true, finished: { (drug,store) in
                self.webInfomation.goodsDetailModel = drug
                self.storeInfo.detailInfo = store
            })
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.zx_setNavBarSubViewsColor(UIColor.white)
        self.zx_setNavBarBackgroundColor(UIColor.zx_navbar())
        ZXRootViewControllers.setStatusBarForegroundColor(UIColor.white)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .default }
        
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(floor(scrollView.contentOffset.x / ZX.BOUNDS_WIDTH))
        self.topMenu.slider(to: index)
    }
}

extension ZXDrugDetailInfoViewController: ZXSegmentDelegate, ZXSegmentDataSource {
    
    func zxsegment(_ segment: ZXSegment, didSelectAt index: Int) {
        let offset:CFloat = CFloat(index) * CFloat(ZX.BOUNDS_WIDTH)
        self.mainScrollView.setContentOffset(CGPoint.init(x: CGFloat(offset), y: 0), animated: true)
    }
    
    func numberOfTitles(in segment: ZXSegment) -> Int {
        return 3
    }
    
    func zxsegment(_ segment: ZXSegment, titleOf index: Int) -> String {
        switch index {
        case 0:
            return "药品"
        case 1:
            return "说明书"
        case 2:
            return "药店详情"
        default:
            return ""
        }
    }
}
