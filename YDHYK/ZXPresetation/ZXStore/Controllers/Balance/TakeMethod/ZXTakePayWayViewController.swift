//
//  ZXTakePayWayViewController.swift
//  YDHYK
//
//  Created by screson on 2017/10/26.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit
/// 提货、支付方式

protocol ZXTakePayWayDelegate: class {
    func zxTakePayWayViewController(vc: ZXTakePayWayViewController,at index:Int,payType:Int,receiveType:Int)
}

class ZXTakePayWayViewController: ZXSTUIViewController {
    let buttonColor = UIColor.init(red: 245 / 255.0, green: 92 / 255.0, blue: 30 / 255.0, alpha: 1.0)
    
    weak var delegate: ZXTakePayWayDelegate?
    var tagIndex: Int = 0
    var isSupportDistribution = false
    var payType: Int = 2  //1 在线支付 2 现金支付
    var receiveType: Int = 2 //1 送货上门 2 到店自提
    
    override var preferredCartButtonHidden: Bool { return true }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.modalPresentationStyle = .custom
        self.transitioningDelegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not init")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.clear
        
        self.initButtonType(button: self.btnSelfTake)
        self.initButtonType(button: self.btnExpress)
        self.initButtonType(button: self.btnCashPay)
        self.initButtonType(button: self.btnOnlinePay)
        
        
        self.btnOnlinePay.isHidden = true
        if self.isSupportDistribution  {
            self.btnExpress.isHidden = false
        } else {
            self.btnExpress.isHidden = true
        }
        
        if receiveType == 2 {
            self.setButton(button: self.btnSelfTake, selected: true)
        } else {
            self.setButton(button: self.btnExpress, selected: true)
        }
        if payType == 2 {
            self.setButton(button: self.btnCashPay, selected: true)
        } else {
            self.setButton(button: self.btnOnlinePay, selected: true)
        }
    }
    
    fileprivate func initButtonType(button: UIButton) {
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = self.buttonColor.cgColor
        button.setTitleColor(self.buttonColor, for: .normal)
        button.setTitleColor(.white, for: .selected)
        button.backgroundColor = .white
    }
    
    @IBOutlet weak var btnSelfTake: UIButton!
    
    @IBOutlet weak var btnExpress: UIButton!
    
    @IBOutlet weak var btnCashPay: UIButton!
    @IBOutlet weak var btnOnlinePay: UIButton!
    
    //支付方式暂时只支持线下现金支付
    @IBAction func payWayAction(_ sender: UIButton) {
        if sender.isSelected {
            return
        }
        if sender == self.btnOnlinePay { //在线支付
            self.payType = 1
            self.setButton(button: self.btnOnlinePay, selected: true)
            self.setButton(button: self.btnCashPay, selected: false)
        } else if sender == self.btnCashPay { //现金支付
            self.payType = 2
            self.setButton(button: self.btnOnlinePay, selected: false)
            self.setButton(button: self.btnCashPay, selected: true)
        }
    }
    //MARK: - 收货方式
    @IBAction func takeGoodsAction(_ sender: UIButton) {
        if sender.isSelected {
            return
        }
        if sender == self.btnSelfTake { //到店自提
            self.receiveType = 2
            self.setButton(button: self.btnSelfTake, selected: true)
            self.setButton(button: self.btnExpress, selected: false)
        } else if sender == self.btnExpress { //送货上门
            self.receiveType = 1
            self.setButton(button: self.btnSelfTake, selected: false)
            self.setButton(button: self.btnExpress, selected: true)
        }
    }
    
    
    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func commitAction(_ sender: Any) {
        delegate?.zxTakePayWayViewController(vc: self, at: self.tagIndex, payType: self.payType, receiveType: self.receiveType)
        self.dismiss(animated: true, completion: nil)
    }
    
    func setButton(button: UIButton,selected: Bool) {
        if selected {
            button.isSelected = true
            button.backgroundColor = self.buttonColor
            button.layer.borderColor = UIColor.clear.cgColor
        } else {
            button.isSelected = false
            button.backgroundColor = .white
            button.layer.borderColor = self.buttonColor.cgColor
        }
    }
}

extension ZXTakePayWayViewController:UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return ZXDimmingPresentationController.init(presentedViewController: presented, presenting: presenting)
    }
}
