//
//  CouponListVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 17/10/24.
//

import UIKit


protocol CouponCodeDelegate: AnyObject {
    func applyCouponObj(dataObj: CouponListDetail, text: String)
}

class CouponListVC: BaseViewController {
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet var tableViewCoupons:UITableView!
    
    var allCouponsObj = AllCouponObjStruct()
    var delegate : CouponCodeDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewCoupons.delegate = self
        tableViewCoupons.dataSource = self
        configView()
        tableViewCoupons.register(UINib(nibName: CouponListTVC.cellIdentifierCouponListTVC, bundle: nil), forCellReuseIdentifier: CouponListTVC.cellIdentifierCouponListTVC)

        // Do any additional setup after loading the view.
        
    }
    
    private func configView() {
        self.view.backgroundColor = .clear
        self.backView.backgroundColor = .black.withAlphaComponent(0.6)
        self.backView.alpha = 0
        self.contentView.alpha = 0
        
        // Set contentView's corner radius
        self.contentView.layer.cornerRadius = 20
        self.contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner] // Round top corners only
        
        // Initially, move contentView off the screen (bottom)
        self.contentView.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.height)
    }
    
 
    func appear(sender: UIViewController) {
        sender.present(self, animated: false) {
            self.show()
            self.getCouponListAPICalling()
        }
    }
    

    private func show() {
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseInOut) {
            self.backView.alpha = 1
            // Slide up the contentView from the bottom
            self.contentView.transform = .identity
            self.contentView.alpha = 1
        }
    }
    
    func hide() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut) {
            self.backView.alpha = 0
            // Slide down the contentView back to the bottom
            self.contentView.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.height)
            self.contentView.alpha = 0
        } completion: { _ in
            self.dismiss(animated: false)
        }
    }
    
    
 

    func getCouponListAPICalling(){
        CustomActivityIndicator2.shared.show(in: self.view, gifName: "diamond_logo", topMargin: 300)
            let url = APIs().getCouponList_API
           ShippingModuleModel.shareInstence.getCouponList(url: url, requestParam: [:], completion: { data, msg in
                if data.status == 1{
                    self.allCouponsObj = data
                    self.tableViewCoupons.reloadData()
                }
                else{
                    
                    self.toastMessage(msg ?? "")
                    //                self.isLoading = false
                }
               
               CustomActivityIndicator2.shared.hide()
            })
        
            
          
    }
    

}

extension CouponListVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let dataCount = self.allCouponsObj.details{
            return dataCount.count
        }
        else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CouponListTVC.cellIdentifierCouponListTVC, for: indexPath) as! CouponListTVC
        cell.selectionStyle = .none
        let data = self.allCouponsObj.details?[indexPath.row]
        cell.lblCpnCode.text = data?.code
        cell.lblDes.text = data?.description
        cell.lblValid.text = data?.endDate
        cell.lblType2.isHidden = true
        cell.viewType2.isHidden = true
        
        if  data?.category == "Natural/Lab Grown"{
            cell.lblType2.isHidden = false
            cell.viewType2.isHidden = false
            let separatedStrings = data?.category?.split(separator: "/")
            
            separatedStrings?.enumerated().forEach{ ind, val in
                if val == "Natural"{
                    cell.lblType.text = "\(val)"
                    cell.viewType.backgroundColor = .themeGoldenClr
                }
                else if val == "Lab Grown"{
                    cell.lblType2.text = "\(val)"
                    cell.viewType2.backgroundColor = .green2
                }
            }
          
        }
        else{
            cell.lblType.text = data?.category
            if data?.category == "Lab Grown"{
                cell.viewType.backgroundColor = .green2
            }
            else{
                cell.viewType.backgroundColor = .themeGoldenClr
            }
        }
        
        
        
        cell.btnActionApply = {
            if let data = self.allCouponsObj.details{
                self.delegate?.applyCouponObj(dataObj: data[indexPath.row], text: "ApplyCopn")
                self.hide()
            }
        }
        
        return cell
    }
    
    
}
