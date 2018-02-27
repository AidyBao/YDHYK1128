//
//  ZXDrugSpecsSelectViewController.swift
//  YDY_GJ_3_5
//
//  Created by screson on 2017/6/1.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

enum ZXSpecSelectType {
    case none
    case buyNow
    case addToCart
}

protocol ZXDrugSpecsSelectDelegate: class {
    func zxDrugSpecSelctAt(index:Int,model:ZXDrugSpecModel)
    func zxDrugSpecAddToCart(index:Int,model:ZXDrugSpecModel)
    func zxDrugSpecBalanceDone(model: ZXBalanceModel?)
}

extension ZXDrugSpecsSelectDelegate {
    func zxDrugSpecSelctAt(index:Int,model:ZXDrugSpecModel){}
    func zxDrugSpecAddToCart(index:Int,model:ZXDrugSpecModel){}
    func zxDrugSpecBalanceDone(model: ZXBalanceModel?) {}
}

/// 规格选择
class ZXDrugSpecsSelectViewController: ZXSTUIViewController {

    override var preferredCartButtonHidden: Bool { return true }
    
    var type:ZXSpecSelectType = .none
    var buyCount = 1
    
    @IBOutlet weak var imgvIcon: UIImageView!
    @IBOutlet weak var lbDrugName: UILabel!
    @IBOutlet weak var lbPrice: UILabel!
    @IBOutlet weak var ccvSpecs: UICollectionView!
    @IBOutlet weak var ccvBottomOffset: NSLayoutConstraint!
    @IBOutlet weak var bottomControl: UIView!
    @IBOutlet weak var btnAddToCart: UIButton!
    @IBOutlet weak var btnBuyNow: ZXRButton!
    @IBOutlet weak var btnCommit: ZXRButton!
    
    var drugDetailInfo:ZXDrugDetailModel?
    weak var delegate:ZXDrugSpecsSelectDelegate?
    var selectedIndex = 0
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.modalPresentationStyle = .custom
        self.transitioningDelegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not init")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        ZXStoreRootViewController.cartButton.show()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.clear
        self.lbDrugName.font = UIFont.zx_titleFont(withSize: zx_title2FontSize())
        self.lbDrugName.textColor = UIColor.zx_text()
        self.lbPrice.font = UIFont.zx_titleFont(withSize: zx_title2FontSize())
        self.lbPrice.textColor = UIColor.zx_customB()
        
        self.imgvIcon.image = nil
        self.lbDrugName.text = ""
        self.lbPrice.text = ""
        
        self.bottomControl.isHidden = true
        
        let flowLayout = ZXMaxSpacingCCVLayout.init()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.footerReferenceSize = CGSize(width: ZX.BOUNDS_WIDTH - 28, height: 50)
        self.ccvSpecs.collectionViewLayout = flowLayout
        self.ccvSpecs.allowsMultipleSelection = false
        self.ccvSpecs.register(UINib(nibName: ZXSpecCollectionViewCell.NibName, bundle: nil), forCellWithReuseIdentifier: ZXSpecCollectionViewCell.reuseIdentifier)
        self.ccvSpecs.register(UINib(nibName: "ZXBuyCountCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "Footer")
        self.ccvSpecs.alwaysBounceVertical = true
        self.ccvSpecs.showsHorizontalScrollIndicator = false
        self.ccvSpecs.showsVerticalScrollIndicator = false
        
        
        if  let model = self.drugDetailInfo {
            if let path = model.attachFilesStrs.first,let url = URL.init(string: ZXIMG_Address(path) ) {
                self.imgvIcon.setImageWith(url, placeholderImage: UIImage.Default.drug)
            } else {
                self.imgvIcon.image = UIImage.Default.drug
            }
            
            if model.isPrescription == 1 {
                self.bottomControl.isHidden = true
                self.btnBuyNow.isEnabled = false
                self.btnCommit.isEnabled = false
                self.btnAddToCart.isEnabled = false
            } else {
                self.bottomControl.isHidden = false
                self.btnBuyNow.isEnabled = true
                self.btnCommit.isEnabled = true
                self.btnAddToCart.isEnabled = true
            }
            
            if self.type == .none {
                self.btnBuyNow.isHidden = false
                self.btnAddToCart.isHidden = false
                self.btnCommit.isHidden = true
            } else {
                self.btnBuyNow.isHidden = true
                self.btnAddToCart.isHidden = true
                self.btnCommit.isHidden = false
            }
            
            self.lbDrugName.text = model.drugName
            let spec = model.zx_specList[selectedIndex]
            self.lbPrice.text = "\(spec.price)".zx_priceString()
            if model.zx_specList.count > 0 {
                self.ccvSpecs.selectItem(at: IndexPath(row: selectedIndex, section: 0), animated: false, scrollPosition: UICollectionViewScrollPosition.centeredVertically)
            }
        }
    }
    //MARK: - 加入购物车
    @IBAction func addToCartAction(_ sender: Any) {
        if let info = self.drugDetailInfo,info.zx_specList.count > 0 {
            let model = info.zx_specList[selectedIndex]
            ZXCart.cart.plus(storeId: "\(info.drugstoreId)",drugId: model.baseDrugId,num: self.buyCount)
            ZXHUD.mbShowSuccess(in: self.view, text: "已加入购物车", delay: ZX.DELAY_INTERVAL)
            delegate?.zxDrugSpecAddToCart(index: selectedIndex, model: model)
        }
    }
    
    //MARK: - 立即购买
    @IBAction func buyNowAction(_ sender: Any) {
        self.buyConfirmAction()
    }
    
    //MARK: - 确定
    @IBAction func commitAction(_ sender: Any) {
        if let info = self.drugDetailInfo,info.zx_specList.count > 0 {
            if self.type == .buyNow {
                self.buyConfirmAction()
            } else if self.type == .addToCart {
                let model = info.zx_specList[selectedIndex]
                ZXCart.cart.plus(storeId: "\(info.drugstoreId)",drugId: model.baseDrugId,num: self.buyCount)
                ZXHUD.mbShowSuccess(in: self.view, text: "已加入购物车", delay: ZX.DELAY_INTERVAL)
                delegate?.zxDrugSpecAddToCart(index: selectedIndex, model: model)
            }
        }
    }
    
    fileprivate func buyConfirmAction() {
        if let info = self.drugDetailInfo, info.zx_specList.count > 0 {
            if selectedIndex != -1 {
                if self.buyCount < 1 {
                    ZXHUD.mbShowFailure(in: self.view, text: "请选择购买数量", delay: ZX.DELAY_INTERVAL)
                    return
                }
                let specModel = info.zx_specList[selectedIndex]
                var cartData: Array<Dictionary<String,Any>> = [["drugstoreId":info.drugstoreId,"items":[["drugId":specModel.baseDrugId,"num":self.buyCount]]]]
                //Format
                //[{"drugstoreId":"","items":[{"drugId":"","num":""},{"drugId":"","num":""}]},]
                if (!JSONSerialization.isValidJSONObject(cartData)) {
                    ZXHUD.mbShowFailure(in: self.view, text: "数据格式错误", delay: ZX.DELAY_INTERVAL)
                } else if let data = try? JSONSerialization.data(withJSONObject: cartData, options: []) {
                    let jsonString = String(data:data, encoding: String.Encoding.utf8)
                    ZXHUD.mbShowLoading(in: self.view, text: ZX_LOADING_TEXT, delay: 0)
                    ZXDrugStoreViewModel.balanceAction(cartData: jsonString ?? "", memberId: ZXStoreParams.memberId, token: ZXStoreParams.token, completion: { [unowned self] (sucess, code, balanceModel, errorMsg) in
                        ZXHUD.mbHide(for: self.view, animate: true)
                        if sucess {
                            self.dismiss(animated: true, completion: {
                                self.delegate?.zxDrugSpecBalanceDone(model: balanceModel)
                            })
                        } else {
                            if code != ZXAPI_LOGIN_INVALID {
                                ZXHUD.mbShowFailure(in: self.view, text: errorMsg, delay: ZX.DELAY_INTERVAL)
                            }
                        }
                    })
                }
            } else {
                ZXHUD.mbShowFailure(in: self.view, text: "请选择商品规格", delay: ZX.DELAY_INTERVAL)
            }
        } else {
            ZXHUD.mbShowFailure(in: self.view, text: "商品信息为空", delay: ZX.DELAY_INTERVAL)
        }
    }
    
    
    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let point:CGPoint = (touches.first?.location(in: self.view))!
        if point.y < ZX.BOUNDS_HEIGHT / 3 {
            self.dismiss(animated: true, completion: nil)
        }
    }
}

extension ZXDrugSpecsSelectViewController: ZXCartControlProtocol {
    func zxCartAddOne(for cell: UIView) {
        print("add one")
        self.buyCount += 1
        if self.buyCount > 99 {
            self.buyCount = 99
        }
        self.reloadBuyCountUI()
    }
    
    func zxCartSubOne(for cell: UIView) {
        print("sub one")
        self.buyCount -= 1
        if self.buyCount < 1 {
            self.buyCount = 1
        }
        self.reloadBuyCountUI()
    }
    
    fileprivate func reloadBuyCountUI() {
        if  let model = self.drugDetailInfo {
            self.ccvSpecs.reloadData()
            if model.zx_specList.count > 0 {
                self.ccvSpecs.selectItem(at: IndexPath(row: selectedIndex, section: 0), animated: false, scrollPosition: UICollectionViewScrollPosition.centeredVertically)
            }

        }
    }
}

extension ZXDrugSpecsSelectViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "Footer", for: indexPath) as! ZXBuyCountCollectionReusableView
        footer.lbNum.text = "\(self.buyCount)"
        footer.delegate = self
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ZXSpecCollectionViewCell.reuseIdentifier, for: indexPath) as! ZXSpecCollectionViewCell
        if let model = self.drugDetailInfo {
            cell.reloadData(model.zx_specList[indexPath.row])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let model = self.drugDetailInfo {
            return model.zx_specList.count
        }
        return 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

extension ZXDrugSpecsSelectViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            selectedIndex = indexPath.row
            if let model = self.drugDetailInfo,model.zx_specList.count > 0 {
                let spec = model.zx_specList[indexPath.row]
                self.lbPrice.text = "\(spec.price)".zx_priceString()
                delegate?.zxDrugSpecSelctAt(index: indexPath.row, model: spec)
            }
        }
    }
}

extension ZXDrugSpecsSelectViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let model = self.drugDetailInfo {
            return model.zx_specList[indexPath.row].size
        }
        
        return CGSize.zero
    }
}


extension ZXDrugSpecsSelectViewController:UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return ZXDimmingPresentationController.init(presentedViewController: presented, presenting: presenting)
    }
}
