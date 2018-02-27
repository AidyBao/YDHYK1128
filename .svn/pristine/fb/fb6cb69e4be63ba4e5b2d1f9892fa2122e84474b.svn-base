//
//  ZXStoreRootViewController.swift
//  YDHYK
//
//  Created by screson on 2017/10/11.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit


/// Store BaseVC
class ZXSTUIViewController: UIViewController {
    var onceLoad = false
    var preferredCartButtonHidden: Bool { return false }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if preferredCartButtonHidden {
            ZXStoreRootViewController.cartButton.hide()
        } else {
            ZXStoreRootViewController.cartButton.show()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        ZXStoreRootViewController.cartButton.hide()
    }

    func zx_refresh() {
        
    }
    
    func zx_loadmore() {
        
    }
}

class ZXStoreParams: NSObject {
//    static var storeId = "" {
//        set {
//            
//        }
//        get {
//            return "2000002"
//        }
//    }
    static var storeId: String {
        set {
            
        }
        get {
            return "2000002"
        }
    }
    static var memberId = ""
//    static var token = ""
    static var token: String {
        set {
            
        }
        get {
            return "2cc786b91aeee087d54ad588e80dbc40"
        }
    }
    
    static var storeInfo: ZXStoreDetailModel?
    
//    static func clear() {
//        self.storeId = ""
//        self.memberId = ""
//        self.token = ""
//        self.storeInfo = nil
//    }
}

// 店铺首页
class ZXStoreRootViewController: ZXSTUIViewController,ZXCartButtonDelegate {
    fileprivate static var zxCartButton: ZXCartButton?
    static var cartButton: ZXCartButton {
        get {
            if self.zxCartButton == nil {
                zxCartButton = ZXCartButton()
            }
            return self.zxCartButton!
        }
    }
    
    static func configVC(with storeId: String, memberId:String, token:String) -> ZXStoreRootViewController {
        ZXStoreParams.storeInfo = nil
        ZXStoreParams.storeId = storeId
        ZXStoreParams.memberId = memberId
        ZXStoreParams.token = token
        return ZXStoreRootViewController()
    }
    
    var headerView: ZXStoreHeaderView!
    var storeModel: ZXStoreModel?
    var activeList: Array<ZXStoreActive> = []
    var recommendList: Array<ZXDrugModel> = []
    
    @IBOutlet weak var tblHomeList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fd_prefersNavigationBarHidden = false
        self.view.backgroundColor = UIColor.zx_assist()
        
        // Do any additional setup after loading the view.
        self.tblHomeList.backgroundColor = UIColor.zx_assist()
        self.tblHomeList.register(UINib.init(nibName: ZXStoreDrugCell.NibName, bundle: nil), forCellReuseIdentifier: ZXStoreDrugCell.reuseIdentifier)
        self.tblHomeList.register(UINib.init(nibName: ZXActive1Cell.NibName, bundle: nil), forCellReuseIdentifier: ZXActive1Cell.reuseIdentifier)
        self.tblHomeList.register(UINib.init(nibName: ZXActive2Cell.NibName, bundle: nil), forCellReuseIdentifier: ZXActive2Cell.reuseIdentifier)
        self.tblHomeList.register(UINib.init(nibName: ZXActive3.NibName, bundle: nil), forCellReuseIdentifier: ZXActive3.reuseIdentifier)
        self.tblHomeList.register(ZXSingleTextHeaderView.classForCoder(), forHeaderFooterViewReuseIdentifier: ZXSingleTextHeaderView.reuseIdentifier)
        self.tblHomeList.zx_addHeaderRefreshActionUseZXImage(true, target: self, action: #selector(zx_refresh))
        
        headerView = ZXStoreHeaderView.init(origin: CGPoint.zero)
        self.tblHomeList.tableHeaderView = headerView
        headerView.categoryView.delegate = self
        headerView.searchButton.addTarget(self, action: #selector(searchAction), for: .touchUpInside)
        
        ZXStoreRootViewController.cartButton.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(shoppingCartUpdated), name: NSNotification.Name.init("CartUpdateNotice"), object: nil)
    }
    
    func shoppingCartUpdated() {
        ZXStoreRootViewController.cartButton.setCartNum(num: ZXCart.cart.totalCount)
    }
    
    func zxCartButtonTapped() {
        let shoppingCart = ZXShoppingCartViewController()
        self.navigationController?.pushViewController(shoppingCart, animated: true)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !onceLoad {
            onceLoad = true
            self.loadStoreHomePage(showHUD: true)
            self.loadRecommendList()
        }
        self.tblHomeList.reloadData()//购买数量修改
    }
    
    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        ZXStoreRootViewController.cartButton.hide()
//        ZXStoreRootViewController.zxCartButton?.resignKey()
//    }
    
    //MARK: - ZXRefresh
    override func zx_refresh() {
        self.loadStoreHomePage(showHUD: false)
        self.loadRecommendList()
    }
    
    //MARK: - Search Action
    @objc func searchAction() {
        let searchVC = ZXDrugSearchViewController()
        self.navigationController?.pushViewController(searchVC, animated: true)
    }
    
    
    ///MARK: - 店铺首页
    fileprivate func loadStoreHomePage(showHUD: Bool) {
        if showHUD {
            ZXHUD.mbShowLoading(in: self.view, text: ZX_LOADING_TEXT, delay: 0)
        }
        ZXStoreHomeViewModel.getHomePage(storeId: ZXStoreParams.storeId, memberId: ZXStoreParams.memberId, token: ZXStoreParams.token) { (s, c, error, model) in
            ZXHUD.mbHide(for: self.view, animate: true)
            ZXEmptyView.dismiss(in: self.view)
            self.tblHomeList.mj_header.endRefreshing()
            if s {
                if let model = model {
                    self.storeModel = model
                    self.reloadUI()
                } else {
                    ZXEmptyView.showNoData(in: self.view, text1: "无相关数据", text2: "", heightFix: 0)
                }
            } else {
                ZXHUD.mbShowFailure(in: self.view, text: error, delay: ZX.DELAY_INTERVAL)
            }
        }
        
        //加载店铺信息
        ZXDrugStoreViewModel.storeDetail(storeId: ZXStoreParams.storeId, memberId: ZXStoreParams.memberId, token: ZXStoreParams.token) { (s, c, error, model) in
            if s {
                ZXStoreParams.storeInfo = model
            }
        }
    }
    
    //MARK: - 推荐商品
    fileprivate func loadRecommendList () {
        ZXStoreHomeViewModel.recommendList(storeId: ZXStoreParams.storeId, memberId: ZXStoreParams.memberId, token: ZXStoreParams.token) { (s, c, errorMsg, list) in
            if s {
                self.recommendList = list
                self.tblHomeList.reloadData()
            }//失败不作处理
        }
    }
    
    
    fileprivate func reloadUI () {
        if let model = self.storeModel {
            self.title = model.drugstoreName
            self.headerView.categoryView.reloadData(model)
            self.activeList = model.zx_ActiveList
        }
        self.tblHomeList.reloadData()
    }
}


// MARK: - 分类点击
extension ZXStoreRootViewController: ZXStoreCategoryViewDelegate {
    func zxStoreCategoryView(_ view: ZXStoreCategoryView, selectAt index: Int) {
        if let model = self.storeModel {
            if let sorts = model.zx_sorts {
                if sorts.count == index {//全部
                    let allCategory = ZXDrugCategoryViewController()
                    self.navigationController?.pushViewController(allCategory, animated: true)
                } else {
                    let categoryList = ZXDrugListViewController()
                    categoryList.category = sorts[index]
                    self.navigationController?.pushViewController(categoryList, animated: true)
                }
            } else {//全部
                let allCategory = ZXDrugCategoryViewController()
                self.navigationController?.pushViewController(allCategory, animated: true)
            }
        }
    }
}



extension ZXStoreRootViewController: UITableViewDelegate {
    // MARK: - 商品点击
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1,self.recommendList.count > 0 {
            let model = self.recommendList[indexPath.row]
            let detail = ZXDrugDetailInfoViewController()
            detail.goodsShortModel = model
            self.navigationController?.pushViewController(detail, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1,self.recommendList.count > 0 {
            return 40
        }
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
}

extension ZXStoreRootViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            switch self.activeList.count {
                case 1:
                    let cell = tableView.dequeueReusableCell(withIdentifier: ZXActive1Cell.reuseIdentifier, for: indexPath) as! ZXActive1Cell
                    cell.reloadData(model: self.storeModel)
                    cell.delegate = self
                    return cell
                case 2:
                    let cell = tableView.dequeueReusableCell(withIdentifier: ZXActive2Cell.reuseIdentifier, for: indexPath) as! ZXActive2Cell
                    cell.reloadData(model: self.storeModel)
                    cell.delegate = self
                    return cell
                case 3:
                    let cell = tableView.dequeueReusableCell(withIdentifier: ZXActive3.reuseIdentifier, for: indexPath) as! ZXActive3
                    cell.reloadData(model: self.storeModel)
                    cell.delegate = self
                    return cell
                default:
                    break
            }
        } else if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: ZXStoreDrugCell.reuseIdentifier, for: indexPath) as! ZXStoreDrugCell
            cell.delegate = self
            let model = self.recommendList[indexPath.row]
            cell.reloadData(model)
            cell.reloadDataForNotReuse(ZXCart.cart.modelFor(storeId: "\(model.drugstoreId)", drugId: "\(model.baseDrugId)"))
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ZXActive1Cell.reuseIdentifier, for: indexPath) as! ZXActive1Cell
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
            case 0:
                if activeList.count > 0 {
                    return 1
                }
            case 1:
                return recommendList.count
            default:
                break
        }
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1,self.recommendList.count > 0 {
            let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: ZXSingleTextHeaderView.reuseIdentifier) as! ZXSingleTextHeaderView
            view.setText("猜您需药", image: #imageLiteral(resourceName: "hot-drug"))
            return view
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 180
        }
        return 125
    }
}

extension ZXStoreRootViewController: ZXStoreDrugCellDelegate, ZXStoreActiveCellDelegate {
    
    //MARK: - 活动点击 -> 活动商品列表
    func zxStoreActiveCell(_ cell: UITableViewCell, selectedAt index: Int, model: ZXStoreActive) {
        let activeGoodsList = ZXActiveGoodsListViewController()
        activeGoodsList.active = model
        self.navigationController?.pushViewController(activeGoodsList, animated: true)
    }
    //MARK: - 单个活动下的商品->商品详情
    func zxStoreActiveCell(_ cell: UITableViewCell, goodsSelectAt model: ZXDrugModel) {
        //let model = self.drugList[indexPath.row]
        let detail = ZXDrugDetailInfoViewController()
        detail.goodsShortModel = model
        self.navigationController?.pushViewController(detail, animated: true)
    }
    
    func zxStoreDrugCell(_ cell: UITableViewCell, controlType type: ZXGrugNumControlType) {
        if let indexPath = self.tblHomeList.indexPath(for: cell) {
            let model = self.recommendList[indexPath.row]
            let sid = "\(model.baseDrugId)"
            if type == .plus {
                ZXCart.cart.plus(storeId: "\(model.drugstoreId)", drugId: sid)
            } else {
                ZXCart.cart.sub(storeId: "\(model.drugstoreId)", drugId: sid)
            }
        }
    }
}
