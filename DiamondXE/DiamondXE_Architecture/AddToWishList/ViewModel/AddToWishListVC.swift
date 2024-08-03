//
//  AddToWishListVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 03/07/24.
//

import UIKit

var isComeFromHome = true

class AddToWishListVC: BaseViewController, ChildViewControllerProtocol {
    
    func didSendString(str: String) {
        print(str)
    }
    
    var delegate : BaseViewControllerDelegate?
    
    @IBOutlet var wishlistTableView:UITableView!
    @IBOutlet var headerViewHeight:NSLayoutConstraint!
    
    @IBOutlet var emipityView:UIView!
    
    var wishlistDataStruct = WishlistDataStruct()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isComeFromHome {
            headerViewHeight.constant = 0
        }else{
            headerViewHeight.constant = 70
        }
        emipityView.isHidden = true
        // Do any additional setup after loading the view.
        self.wishlistTableView.register(UINib(nibName: CartItemTVC.cellIdentifierCartItem, bundle: nil), forCellReuseIdentifier: CartItemTVC.cellIdentifierCartItem)
        
        // get wishlist data
        self.fetchCartData()
    }
    
    @IBAction func btnActionBack(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func fetchCartData() {
        CustomActivityIndicator2.shared.show(in: self.view, gifName: "diamond_logo", topMargin: 300)
        let url = APIs().get_Wishlist_API
        let sessnID = getSessionUniqID()
        let param :[String:Any] = ["sessionId":sessnID]
      
        WishlistDataModel().getWishlistData(url: url, requestParam: param, completion: { data, msg in
            
            if data.status == 1{
                self.wishlistDataStruct = data
                DataManager.shared.WishlistDataHolder = self.wishlistDataStruct
                self.wishlistTableView.reloadData()
            }
            else{
                if msg ?? "" ==  "Wishlist is empty"{
                    self.checkToDataCount()
                }
                else{
                    self.toastMessage(msg ?? "")
                }
//                self.isLoading = false
            }
            CustomActivityIndicator2.shared.hide()

        })
        
      }
    
    func checkToDataCount(){
        if  let count = self.wishlistDataStruct.details?.count {
            if count > 0{
                self.emipityView.isHidden = false
            }
            else{
                self.emipityView.isHidden = true
            }
        }
        else{
            self.emipityView.isHidden = false
        }
        
    }
    
    
    func removeFromCartItem(certificateNo:String) {
        CustomActivityIndicator2.shared.show(in: self.view, gifName: "diamond_logo", topMargin: 300)
        let url = APIs().removetoWishlist_API
        let sessnID = getSessionUniqID()
        let param :[String:Any] = ["sessionId":sessnID, "certificateNo":certificateNo]
      
        CartDataModel().removeItemFromCart(url: url, requestParam: param, completion: { data, msg in
            
            if data.status == 1{
                self.wishlistDataStruct.details = self.wishlistDataStruct.details?.filter { $0.certificateNo != certificateNo }
                
                if  let count = self.wishlistDataStruct.details?.count {
                    if count > 0{
                        self.emipityView.isHidden = true
                    }
                    else{
                        self.emipityView.isHidden = false
                    }
                }
                
                self.wishlistTableView.reloadData()
            }
            else{
                self.toastMessage(msg ?? "")
//                self.isLoading = false
            }
            
            
            
            CustomActivityIndicator2.shared.hide()

        })
        
      }
    
    func moveFromCartToWishlistItem(certificateNo:String) {
        CustomActivityIndicator2.shared.show(in: self.view, gifName: "diamond_logo", topMargin: 300)
        let url = APIs().addtoCart_API
        let sessnID = getSessionUniqID()
        let param :[String:Any] = ["sessionId":sessnID, "certificateNo":certificateNo, "source": "wishlist"]
      
        CartDataModel().removeItemFromCart(url: url, requestParam: param, completion: { data, msg in
            
            if data.status == 1{
                self.wishlistDataStruct.details = self.wishlistDataStruct.details?.filter { $0.certificateNo != certificateNo }
                if  let count = self.wishlistDataStruct.details?.count {
                    if count > 0{
                        self.emipityView.isHidden = true
                    }
                    else{
                        self.emipityView.isHidden = false
                    }
                }
               // self.toastMessage(msg ?? "")
                self.wishlistTableView.reloadData()
                
            }
            else{
                self.toastMessage(msg ?? "")
//                self.isLoading = false
            }
            CustomActivityIndicator2.shared.hide()

        })
        
      }
    

}

extension AddToWishListVC: UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = self.wishlistDataStruct.details?.count {
           
            return count
        }
        else{
            
            return 0
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CartItemTVC.cellIdentifierCartItem, for: indexPath) as! CartItemTVC
        cell.selectionStyle = .none
        cell.imgDiamond.sd_setImage(with: URL(string: self.wishlistDataStruct.details?[indexPath.row].diamondImage ?? ""), placeholderImage: UIImage(named: "place_Holder"))
        
        cell.btnSelectedItem.isHidden = true
        cell.btnWishList.setImage(UIImage(named: "cart_"), for: .normal)
        cell.lblCirtificateNum.text = self.wishlistDataStruct.details?[indexPath.row].certificateNo
        cell.lblLotID.text = "ID: \(self.wishlistDataStruct.details?[indexPath.row].supplierID ?? "")"
        cell.lblShape.text = self.wishlistDataStruct.details?[indexPath.row].shape
        cell.lblCarat.text = "Ct\(self.wishlistDataStruct.details?[indexPath.row].carat ?? "")"
        cell.lblClor.text = self.wishlistDataStruct.details?[indexPath.row].color
        cell.lblClarity.text = self.wishlistDataStruct.details?[indexPath.row].clarity
        cell.lblCarat.text = self.wishlistDataStruct.details?[indexPath.row].carat
        
        if let availibility = self.wishlistDataStruct.details?[indexPath.row].status{
            if availibility == "On Hold"{
                cell.btnAvailable.setImage(UIImage(named: "onHold"), for: .normal)
            }
            else if  availibility == "Available"{
                cell.btnAvailable.setImage(UIImage(named: "available"), for: .normal)
            }
            else{
                cell.btnAvailable.isHidden = true
            }
        }
        
        let formattedNumber = formatNumberWithoutDeciml(Double(self.wishlistDataStruct.details?[indexPath.row].totalPrice ?? 0))
        cell.lblPrice.text = "₹\(formattedNumber)"
        
        cell.alertAction = {
            
        }
        
        cell.actionWishNRemove = { tag in
            if tag == 1{
                self.removeFromCartItem(certificateNo: self.wishlistDataStruct.details?[indexPath.row].certificateNo ?? "")
            }
            else{
                self.moveFromCartToWishlistItem(certificateNo: self.wishlistDataStruct.details?[indexPath.row].certificateNo ?? "")
            }
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

            return 160
        
    }
    
}
