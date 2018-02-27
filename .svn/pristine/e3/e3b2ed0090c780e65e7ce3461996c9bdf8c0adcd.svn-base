//
//  ZXDrugCategoryViewController.swift
//  YDY_GJ_3_5
//
//  Created by screson on 2017/5/16.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit


/// 药品分类
class ZXDrugCategoryViewController: ZXSTUIViewController {
    
    @IBOutlet weak var tblCategory1: UITableView!
    @IBOutlet weak var ccvSubCategory: UICollectionView!
    var categories:Array<ZXCategoryTreeModel>?
    var topIndex = 0
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.title = "全部类目"
        self.hidesBottomBarWhenPushed = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !onceLoad {
            onceLoad = true
            self.fetchAllCategory()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tblCategory1.backgroundColor = UIColor.zx_assist()
        self.tblCategory1.separatorStyle = .none
        self.tblCategory1.register(UINib(nibName: ZXSingleTextCell.NibName, bundle: nil), forCellReuseIdentifier: ZXSingleTextCell.reuseIdentifier)
        self.ccvSubCategory.register(UINib(nibName: ZXCategoryCCVCell.NibName, bundle: nil), forCellWithReuseIdentifier: ZXCategoryCCVCell.reuseIdentifier)
        self.ccvSubCategory.contentInset = UIEdgeInsetsMake(0, 20, 0, 20)
    }

    fileprivate func fetchAllCategory() {
        ZXHUD.mbShowLoading(in: self.view, text: "获取分类列表...", delay: 0)
        ZXStoreHomeViewModel.categoryTree(storeId: ZXStoreParams.storeId, memberId: ZXStoreParams.memberId, token: ZXStoreParams.token) { (s, c, errorMsg, list) in
            ZXHUD.mbHide(for: self.view, animate: true)
            if s {
                self.topIndex = 0
                self.categories = list
                self.tblCategory1.reloadData()
                self.ccvSubCategory.reloadData()
                if list.count == 0 {
                    ZXEmptyView.showNetworkError(in: self.view, heightFix: 0, refreshAction: { [unowned self] in
                        self.fetchAllCategory()
                    })
                }else{
                    self.tblCategory1.selectRow(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .none)
                }
            } else {
                if c != ZXAPI_LOGIN_INVALID {
                    ZXHUD.mbShowFailure(in: self.view, text: errorMsg, delay: ZX.DELAY_INTERVAL)
                }
            }
        }
    }
}
