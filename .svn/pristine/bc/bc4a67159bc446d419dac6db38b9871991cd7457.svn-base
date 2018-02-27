//
//  ZXDurgCommonInfoViewController.swift
//  YDHYK
//
//  Created by screson on 2017/10/16.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit
import ZXAutoScrollView

/// 商品基础详情
class ZXDurgCommonInfoViewController: ZXSTUIViewController {

    @IBOutlet weak var bottomMenuView: UIView!
    
    @IBOutlet weak var btnMark: UIButton!
    @IBOutlet weak var btnContact: UIButton!
    @IBOutlet weak var btnBuyNow: ZXRButton!
    @IBOutlet weak var btnAddtoCart: ZXRButton!
    
    var zxScrollView: ZXAutoScrollView!
    var shortModel: ZXDrugModel?
    var goodsDetailModel: ZXDrugDetailModel?
    
    var relateGoodsList: Array<ZXDrugModel>? {
        didSet {
            self.tblGoodsInfo.reloadData()
        }
    }
    fileprivate var sSpec: ZXDrugSpecModel?
    var selectedSpec:ZXDrugSpecModel? {
        set {
            self.sSpec = newValue
        }
        get {
            if let sSpec = sSpec {
                return sSpec
            } else if let model = self.goodsDetailModel {
                return model.zx_defaultSpec
            }
            return nil
        }
    }
    var specIndex:Int {
        get {
            if let selectedSpec = selectedSpec,let specs = self.goodsDetailModel?.zx_specList {
                var index = 0
                for s in specs {
                    if s.baseDrugId == selectedSpec.baseDrugId {
                        return index
                    }
                    index += 1
                }
            }
            return 0
        }
    }
    
    @IBOutlet weak var tblGoodsInfo: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.zx_assist()
        
        self.bottomMenuView.isHidden = true
        self.btnContact.setTitleColor(UIColor.zx_text(), for: .normal)
        self.btnMark.setTitleColor(UIColor.zx_text(), for: .normal)
        self.btnMark.setTitleColor(UIColor.init(red: 248 / 255.0, green: 171 / 255.0, blue: 3 / 255.0, alpha: 1.0), for: .selected)
        self.btnMark.setTitle("收藏", for: .normal)
        self.btnMark.setTitle("已收藏", for: .selected)
        self.btnMark.setImage(UIImage.init(named: "store-unmark"), for: .normal)
        self.btnMark.setImage(UIImage.init(named: "store-mark"), for: .highlighted)
        self.btnMark.setImage(UIImage.init(named: "store-mark"), for: .selected)

        
        zxScrollView = ZXAutoScrollView.init(frame: CGRect(x: 0, y: 0, width: ZX.BOUNDS_WIDTH, height: 280))
        zxScrollView.backgroundColor = UIColor.white
        zxScrollView.autoFlip = false
        zxScrollView.pageControl.currentPageIndicatorTintColor = UIColor.zx_text()
        zxScrollView.pageControl.pageIndicatorTintColor = UIColor.zx_sub2Text()
        zxScrollView.dataSource = self
        
        self.tblGoodsInfo.backgroundColor = UIColor.clear
        self.tblGoodsInfo.tableHeaderView = zxScrollView
        self.tblGoodsInfo.register(UINib.init(nibName: ZXSingleTitleCell.NibName, bundle: nil), forCellReuseIdentifier: ZXSingleTitleCell.reuseIdentifier)
        self.tblGoodsInfo.register(UINib.init(nibName: ZXDrugInfoTableViewCell.NibName, bundle: nil), forCellReuseIdentifier: ZXDrugInfoTableViewCell.reuseIdentifier)
        self.tblGoodsInfo.register(UINib.init(nibName: ZXSpecSelectCell.NibName, bundle: nil), forCellReuseIdentifier: ZXSpecSelectCell.reuseIdentifier)
        self.tblGoodsInfo.register(UINib.init(nibName: ZXRelateGoodsListCell.NibName, bundle: nil), forCellReuseIdentifier: ZXRelateGoodsListCell.reuseIdentifier)
        self.tblGoodsInfo.estimatedRowHeight = 80
        
        self.tblGoodsInfo.zx_addHeaderRefreshActionUseZXImage(true, target: self, action: #selector(zx_refresh))
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadAction), name: NSNotification.Name.init("DrugUIUpdate"), object: nil)
        
    }
    
    override func zx_refresh() {
        self.fetchDrugDetail(showHUD: false, finished: nil)
    }
    
    func reloadAction() {
        if let model = self.goodsDetailModel {
            self.bottomMenuView.isHidden = false
            if model.isPrescription == 1 {//处方药
                self.btnAddtoCart.isEnabled = false
                self.btnBuyNow.isEnabled = false
            } else {
                self.btnAddtoCart.isEnabled = true
                self.btnBuyNow.isEnabled = true
            }
            
            if let spec = self.selectedSpec,spec.isColl {
                self.btnMark.isSelected = true
            } else {
                self.btnMark.isSelected = false
            }
            
            self.tblGoodsInfo.reloadData()
            self.zxScrollView.reloadData()
            
        }
    }
    
    /// 联系客服
    ///
    /// - Parameter sender:
    @IBAction func contactAction(_ sender: Any) {
        if let model = ZXStoreParams.storeInfo,model.tel.characters.count > 0 {
            ZXCommonUtils.openCall(withTelNum: model.tel, fail: {
                ZXHUD.mbShowFailure(in: self.view, text: "该设备不支持拨打电话", delay: ZX.DELAY_INTERVAL)
            })
        } else {
            ZXHUD.mbShowFailure(in: self.view, text: "暂无相关联系电话", delay: ZX.DELAY_INTERVAL)
        }
    }
    
    
    //MARK: - 收藏
    @IBAction func markAction(_ sender: Any) {
        if let spec = self.selectedSpec,let model = self.goodsDetailModel {
            ZXHUD.mbShowLoading(in: self.view, text: ZX_LOADING_TEXT, delay: 0)
            ZXDrugViewModel.markDrug(self.btnMark.isSelected ? false : true, drugId: "\(spec.baseDrugId)", storeId:"\(model.drugstoreId)" , collectPrice: "\(spec.price)", userId: ZXStoreParams.memberId, token: ZXStoreParams.token, completion: { (c, s, errorMsg) in
                ZXHUD.mbHide(for: self.view, animate: true)
                if s {
                    if self.btnMark.isSelected {
                        ZXHUD.mbShowSuccess(in: self.view, text: "取消收藏", delay: ZX.DELAY_INTERVAL)
                        self.btnMark.isSelected = false
                    } else {
                        ZXHUD.mbShowSuccess(in: self.view, text: "已收藏", delay: ZX.DELAY_INTERVAL)
                        self.btnMark.isSelected = true
                    }
                } else {
                    if c != ZXAPI_LOGIN_INVALID {
                        ZXHUD.mbShowFailure(in: self.view, text: errorMsg, delay: ZX.DELAY_INTERVAL)
                    }
                }
            })
        } else {
            ZXHUD.mbShowFailure(in: self.view, text: "药品信息不存在", delay: ZX.DELAY_INTERVAL)
        }
    }
    
    func fetchDrugDetail(showHUD:Bool,finished:((_ drugInfo:ZXDrugDetailModel?,_ storeInfo:ZXStoreDetailModel?) -> Void)?) {
        if let sModel = self.shortModel {
            if showHUD {
                ZXHUD.mbShowLoading(in: self.view, text: ZX_LOADING_TEXT, delay: 0)
            }
            ZXDrugViewModel.durgDetailInfo("\(sModel.baseDrugId)", storeId: ZXStoreParams.storeId, approvalNum: sModel.approvalNumber, userId: ZXStoreParams.memberId, token: ZXStoreParams.token, completion: {  [unowned self] (c, s, drug,store, errorMsg) in
                ZXHUD.mbHide(for: self.view, animate: true)
                self.tblGoodsInfo.mj_header.endRefreshing()
                if s {
                    if let store = store {
                        self.goodsDetailModel = drug
                        ZXStoreParams.storeInfo = store
                        self.reloadAction()
                        finished?(drug,store)
                    } else {
                        ZXHUD.mbShowFailure(in: self.view, text: "药品信息为空", delay: ZX.DELAY_INTERVAL)
                    }
                } else {
                    if c != ZXAPI_LOGIN_INVALID {
                        ZXHUD.mbShowFailure(in: self.view, text: errorMsg, delay: ZX.DELAY_INTERVAL)
                    }
                }
                ZXDrugDetailInfoViewController.postStoreUIUpdateNotice()
            })
            
            //相关推荐
            ZXDrugViewModel.randomList(storeId: ZXStoreParams.storeId, memberId: ZXStoreParams.memberId, token: ZXStoreParams.token, completion: { (s, c, errorMsg, list) in
                if s {
                    self.relateGoodsList = list
                }
            })
        } else {
            ZXHUD.mbShowFailure(in: self.view, text: "药品信息为空", delay: ZX.DELAY_INTERVAL)
        }
    }
    
    
    /// 加入购物车
    ///
    /// - Parameter sender:
    @IBAction func addtoCartAction(_ sender: Any) {
        let specsVC = ZXDrugSpecsSelectViewController()
        specsVC.type = .addToCart
        specsVC.delegate = self
        specsVC.drugDetailInfo = self.goodsDetailModel
        specsVC.selectedIndex = self.specIndex
        self.present(specsVC, animated: true, completion: nil)
    }
    
    
    /// 立即购买
    ///
    /// - Parameter sender:
    @IBAction func buyNowAction(_ sender: Any) {
        let specsVC = ZXDrugSpecsSelectViewController()
        specsVC.type = .buyNow
        specsVC.delegate = self
        specsVC.drugDetailInfo = self.goodsDetailModel
        specsVC.selectedIndex = self.specIndex
        self.present(specsVC, animated: true, completion: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.init("DrugUIUpdate"), object: nil)
    }
}

extension ZXDurgCommonInfoViewController: ZXDrugSpecsSelectDelegate {
    func zxDrugSpecSelctAt(index: Int, model: ZXDrugSpecModel) {
        self.selectedSpec = model
        self.tblGoodsInfo.reloadData()
        
        self.tblGoodsInfo.reloadRows(at: [IndexPath.init(row: 0, section: 0)], with: .none)
        if model.isColl {
            self.btnMark.isSelected = true
        } else {
            self.btnMark.isSelected = false
        }
    }
    
    func zxDrugSpecBalanceDone(model: ZXBalanceModel?) {
        let balanceVC = ZXBalanceViewController()
        balanceVC.balanceModel = model
        self.navigationController?.pushViewController(balanceVC, animated: true)
    }

    
}

extension ZXDurgCommonInfoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 { //服务承诺
            DispatchQueue.main.async {
                let promiseList = ZXPromiseLIstViewController()
                self.present(promiseList, animated: true, completion: nil)
            }
        } else if indexPath.section == 2 { //规格选择
            DispatchQueue.main.async {
                let specsVC = ZXDrugSpecsSelectViewController()
                specsVC.type = .none
                specsVC.delegate = self
                specsVC.drugDetailInfo = self.goodsDetailModel
                specsVC.selectedIndex = self.specIndex
                self.present(specsVC, animated: true, completion: nil)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0://名称 规格 药效 价格
            let cell = tableView.dequeueReusableCell(withIdentifier: ZXDrugInfoTableViewCell.reuseIdentifier, for: indexPath) as! ZXDrugInfoTableViewCell
            cell.reloadData(self.goodsDetailModel, selectedSpec: self.selectedSpec)
            return cell
        case 1:// 正品保障 货到付款 小标签
            let cell = tableView.dequeueReusableCell(withIdentifier: ZXSpecSelectCell.reuseIdentifier, for: indexPath) as! ZXSpecSelectCell
            cell.lbRightText.text = ""
            cell.lbLeftText.textColor = UIColor.zx_text()
            cell.lbLeftText.font = UIFont.zx_iconfont(withSize: zx_bodyFontSize())
            cell.lbLeftText.attributedText = ZXStoreParams.storeInfo?.zx_promiseAttributeString
            return cell
        case 2:// 规格选择
            let cell = tableView.dequeueReusableCell(withIdentifier: ZXSpecSelectCell.reuseIdentifier, for: indexPath) as! ZXSpecSelectCell
            cell.lbLeftText.text = "已选"
            if let spec = self.selectedSpec {
                cell.lbRightText.text = spec.name
            } else {
                cell.lbRightText.text = ""
            }
            
            return cell
        case 3:// 相关药品推荐
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: ZXSingleTitleCell.reuseIdentifier, for: indexPath) as! ZXSingleTitleCell
                cell.lbText.text = "买过该药的人还买了"
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: ZXRelateGoodsListCell.reuseIdentifier, for: indexPath) as! ZXRelateGoodsListCell
                cell.delegate = self
                if let list = self.relateGoodsList {
                    cell.drugList = list
                } else {
                    cell.drugList = []
                }
                return cell
            }
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: ZXSingleTitleCell.reuseIdentifier, for: indexPath) as! ZXSingleTitleCell
            cell.lbText.text = ""
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
            case 0:
                return UITableViewAutomaticDimension
            case 3:
                if indexPath.row == 1 {
                    return ZXRelateGoodsListCell.cellHeight
                }
            default:
                break
        }
        return 44
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.goodsDetailModel != nil {
            switch section {
                case 0://名称 规格 药效 价格
                    return 1
                case 1:
                    if ZXStoreParams.storeInfo != nil {
                        return 1
                    }
                case 2:
                    return 1
                case 3:
                    if self.relateGoodsList != nil {
                        return 2
                    }
                default:
                    return 0
            }
        }
        return 0
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if self.goodsDetailModel != nil {
            switch section {
                case 1:
                    return 10
                case 2:
                    return 10
                case 3:
                    if self.relateGoodsList != nil {
                        return 5
                    }
            default:
                break
            }
        }
        
        return CGFloat.leastNormalMagnitude
    }
}

extension ZXDurgCommonInfoViewController: ZXStoreActiveCellDelegate {
    func zxStoreActiveCell(_ cell: UITableViewCell, goodsSelectAt model: ZXDrugModel) {
        let detail = ZXDrugDetailInfoViewController()
        detail.goodsShortModel = model
        self.navigationController?.pushViewController(detail, animated: true)
    }
}

extension ZXDurgCommonInfoViewController: ZXAutoScrollViewDataSource {
    
    func zxAutoScrollView(_ scrollView: ZXAutoScrollView, pageAt index: Int) -> UIView {
        let imageView = UIImageView.init()
        imageView.contentMode = .scaleAspectFit
        if let model = self.goodsDetailModel,let url = URL.init(string: ZXIMG_Address(model.attachFilesStrs[index])) {
            imageView.setImageWith(url, placeholderImage: UIImage.Default.empty)
        }
        return imageView
    }
    
    func numberofPages(_ inScrollView: ZXAutoScrollView) -> Int {
        if let model = self.goodsDetailModel {
            return model.attachFilesStrs.count
        }
        return 0
    }
}
