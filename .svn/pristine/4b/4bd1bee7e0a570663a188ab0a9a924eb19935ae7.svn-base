//
//  ZXActiveGoodsListViewController.swift
//  YDHYK
//
//  Created by screson on 2017/10/13.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

/// 活动商品列表
class ZXActiveGoodsListViewController: ZXSTUIViewController {

    @IBOutlet var zxGoodsListDD: ZXGoodsListDD!
    @IBOutlet weak var tblDrugList: UITableView!
    
    var active: ZXStoreActive?
    var currentPage = 1
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.title = ""
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var headerImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        headerImage = UIImageView.init(frame: CGRect(x: 0, y: 0, width: ZX.BOUNDS_WIDTH, height: 150))
        headerImage.contentMode = .scaleAspectFill
        headerImage.clipsToBounds = true

        self.tblDrugList.backgroundColor = UIColor.zx_assist()
        self.tblDrugList.register(UINib(nibName: ZXStoreDrugCell.NibName, bundle: nil), forCellReuseIdentifier: ZXStoreDrugCell.reuseIdentifier)
        zxGoodsListDD.source = self
        //Refresh
        self.tblDrugList.zx_addHeaderRefreshActionUseZXImage(true, target: self, action: #selector(self.zx_refresh))
        //LoadMore
        self.tblDrugList.zx_addFooterRefreshActionAutoRefresh(true, target: self, action: #selector(self.zx_loadmore))
        if let active = self.active {
            self.title = active.title
            if let url = URL.init(string: ZXIMG_Address(active.bigImage)) {
                headerImage.setImageWith(url, placeholderImage: UIImage.Default.empty)
            } else {
                headerImage.image = UIImage.Default.empty
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if self.active != nil {
            if !onceLoad {
                onceLoad = true
                self.fetchDrugList(true)
            }
        } else {
            ZXHUD.mbShowFailure(in: self.view, text: "活动信息为空", delay: ZX.DELAY_INTERVAL)
        }
        
        self.tblDrugList.reloadData() // 避免其他界面修改了数量

    }
    
    //MARK: - 下拉刷新
    override func zx_refresh() {
        currentPage = 1
        self.fetchDrugList(false)
    }
    //MARK: - 加载更多
    override func zx_loadmore() {
        currentPage += 1
        self.fetchDrugList(false)
    }
    
    func fetchDrugList(_ showHUD:Bool) {
        if let active = active {
            if showHUD {
                ZXHUD.mbShowLoading(in: self.view, text: ZX_LOADING_TEXT, delay: 0)
            } else {
                ZXCommonUtils.showNetworkActivity(true)
            }
            ZXStoreHomeViewModel.activeList(active.templateId, activeItem: active.activeItem, pageNum: currentPage, pageSize: Int(ZXPAGE_SIZE), memberId: ZXStoreParams.memberId, storeId: ZXStoreParams.storeId, token: ZXStoreParams.token, completion: { (code, success, listModel, errorMsg) in
                
                ZXHUD.mbHide(for: self.view , animate: true)
                ZXCommonUtils.showNetworkActivity(false)
                self.tblDrugList.mj_header.endRefreshing()
                self.tblDrugList.mj_footer.endRefreshing()
                self.tblDrugList.mj_footer.resetNoMoreData()
                if success {
                    var hasData:Bool = true
                    if self.currentPage == 1 {
                        self.zxGoodsListDD.drugList.removeAll()
                        if let listModel = listModel,listModel.count > 0 {
                            self.tblDrugList.tableHeaderView = self.headerImage
                            
                            self.zxGoodsListDD.drugList = listModel
                            if listModel.count < ZXPAGE_SIZE {
                                self.tblDrugList.mj_footer.endRefreshingWithNoMoreData()
                            }
                        } else {
                            ZXHUD.mbShowFailure(in: self.view, text: "暂无相关活动商品", delay: ZX.DELAY_INTERVAL)
                            self.tblDrugList.mj_footer.endRefreshingWithNoMoreData()
                            hasData = false
                        }
                    } else{
                        if let listModel = listModel,listModel.count > 0 {
                            self.zxGoodsListDD.drugList.append(contentsOf: listModel)
                            if listModel.count < ZXPAGE_SIZE {
                                self.tblDrugList.mj_footer.endRefreshingWithNoMoreData()
                            }
                        } else {
                            self.tblDrugList.mj_footer.endRefreshingWithNoMoreData()
                        }
                    }
                    self.tblDrugList.reloadData()
                    if self.currentPage == 1,hasData {
                        if let listModel = listModel,listModel.count > 0 {
                            self.tblDrugList.scrollToRow(at: IndexPath.init(row: 0, section: 0), at: .none, animated: true)
                        }
                    }
                } else if code != ZXAPI_LOGIN_INVALID {
                    if self.currentPage == 1 {
                        ZXHUD.mbShowFailure(in: self.view, text: errorMsg, delay: ZX.DELAY_INTERVAL)
                    } else {
                        ZXHUD.mbShowFailure(in: self.view, text: errorMsg, delay: ZX.DELAY_INTERVAL)
                    }
                }
            })
        }
    }
}

extension ZXActiveGoodsListViewController: ZXStoreDrugCellDelegate {
    //MARK: - 添加数量
    func zxStoreDrugCell(_ cell: UITableViewCell, controlType type: ZXGrugNumControlType) {
        if let indexPath = self.tblDrugList.indexPath(for: cell) {
            let model = self.zxGoodsListDD.drugList[indexPath.row]
            let sid = "\(model.baseDrugId)"
            if type == .plus {
                ZXCart.cart.plus(storeId: "\(model.drugstoreId)", drugId: sid)
            } else {
                ZXCart.cart.sub(storeId: "\(model.drugstoreId)", drugId: sid)
            }
        }
    }
}
