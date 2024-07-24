//
//  BaseViewController.swift
//  DiamondXE
//
//  Created by iOS Developer on 18/04/24.
//

import UIKit
import SDWebImage
import Alamofire
import DTTextField


enum SlideDirection {
       case left
       case right
   }


struct Sections {
    var mainCellTitle: String
    var expandableCellOptions: [String]
    var mainCellOptionsIcons: [UIImage]
    var expandableCellOptionsIcons: [UIImage]
    var isExpandableCellsHidden: Bool
    var isExpanded: Bool
}

struct ResultStruct: Codable {
    var status: Int?
    var msg: String?
}



struct SectionsAccount {
    var mainCellTitle: String
    var expandableCellOptions: [String]
    var mainCellOptionsIcons: [UIImage]
    var expandableCellOptionsIcons: [UIImage]
    var isExpandableCellsHidden: Bool
    var isExpanded: Bool
}






class BaseViewController: UIViewController, UITextFieldDelegate {
    
     let viewControllerIdentifiers = ["HomeVC", "CategoriesVC", "AddToWishListVC", "AddToCartVC", "DashboardLoginVC", "SearchDiamondVC", "B2BSearchResultVC", "DiamondDetailsVC"]
     let storyboardNames = ["HomeVC", "CategoriesVC", "AddTOWishlist", "AddTOCart", "Dashboard", "SearchDiamond", "B2BSearch", "DiamondDetails"]
    
    
    
    
    // uitableviewSections //, nv_fancyDiamond
    var sections: [Sections] = [
        
        Sections(mainCellTitle: nv_home, expandableCellOptions: [], mainCellOptionsIcons: nv_mainICN, expandableCellOptionsIcons: [], isExpandableCellsHidden: true, isExpanded: true),
        Sections(mainCellTitle: nv_searchDiamond, expandableCellOptions: [nv_naturalDiamond, nv_labGrownDiamond], mainCellOptionsIcons: nv_mainICN, expandableCellOptionsIcons: nv_searchDiamondICN, isExpandableCellsHidden: true,isExpanded: true),
        Sections(mainCellTitle: nv_createDemand, expandableCellOptions: [], mainCellOptionsIcons: nv_mainICN, expandableCellOptionsIcons: [], isExpandableCellsHidden: true,isExpanded: true),
        Sections(mainCellTitle: nv_jewellery, expandableCellOptions: [nv_rings, nv_earrings, nv_pendent, nv_bracelets, nv_bangles], mainCellOptionsIcons: nv_mainICN, expandableCellOptionsIcons: nv_jewelleryICN, isExpandableCellsHidden: true, isExpanded: true),
        Sections(mainCellTitle: nv_DXELUX, expandableCellOptions: [], mainCellOptionsIcons: nv_mainICN, expandableCellOptionsIcons: [], isExpandableCellsHidden: true, isExpanded: true),
        Sections(mainCellTitle: nv_diamondEducation, expandableCellOptions: [], mainCellOptionsIcons: nv_mainICN, expandableCellOptionsIcons: [], isExpandableCellsHidden: true, isExpanded: true),
        Sections(mainCellTitle: nv_explore, expandableCellOptions: [nv_jeweller, nv_supplier], mainCellOptionsIcons: nv_mainICN, expandableCellOptionsIcons: nv_exploreICN, isExpandableCellsHidden: true, isExpanded: true),
        Sections(mainCellTitle: nv_priceCalc, expandableCellOptions: [], mainCellOptionsIcons: nv_mainICN, expandableCellOptionsIcons: [], isExpandableCellsHidden: true, isExpanded: true),
        Sections(mainCellTitle: nv_more, expandableCellOptions: [nv_aboutUS, nv_whyUS, nv_blogs, nv_mediaGalley, nv_support, nv_termCondition, nv_privacyPolicy], mainCellOptionsIcons: nv_mainICN, expandableCellOptionsIcons: nv_moreICN, isExpandableCellsHidden: true,isExpanded: true),
        Sections(mainCellTitle: nv_contactUS, expandableCellOptions: [nv_emial, nv_whatsapp], mainCellOptionsIcons: nv_mainICN, expandableCellOptionsIcons: nv_contactICN, isExpandableCellsHidden: true,isExpanded: true),
        Sections(mainCellTitle: nv_rateUS, expandableCellOptions: [], mainCellOptionsIcons: nv_mainICN, expandableCellOptionsIcons: [], isExpandableCellsHidden: true,isExpanded: true),
        
        Sections(mainCellTitle: nv_logout, expandableCellOptions: [], mainCellOptionsIcons: nv_mainICN, expandableCellOptionsIcons: [], isExpandableCellsHidden: true,isExpanded: true),
    ]
    
    
    var sectionsAccountProfile: [SectionsAccount] = [
        SectionsAccount(mainCellTitle: account_, expandableCellOptions: [account_profile,account_address,account_kycV,account_password], mainCellOptionsIcons: account_icons, expandableCellOptionsIcons: account_Profileicons, isExpandableCellsHidden: true, isExpanded: true),
        SectionsAccount(mainCellTitle: account_order, expandableCellOptions: [], mainCellOptionsIcons: account_icons, expandableCellOptionsIcons: [], isExpandableCellsHidden: true, isExpanded: true),
        SectionsAccount(mainCellTitle: account_wallet, expandableCellOptions: [], mainCellOptionsIcons: account_icons, expandableCellOptionsIcons: [], isExpandableCellsHidden: true, isExpanded: true),
        SectionsAccount(mainCellTitle: account_auction, expandableCellOptions: [], mainCellOptionsIcons: account_icons, expandableCellOptionsIcons: [], isExpandableCellsHidden: true, isExpanded: true),
        SectionsAccount(mainCellTitle: account_markup, expandableCellOptions: [], mainCellOptionsIcons: account_icons, expandableCellOptionsIcons: [], isExpandableCellsHidden: true, isExpanded: true),
        SectionsAccount(mainCellTitle: account_refer, expandableCellOptions: [], mainCellOptionsIcons: account_icons, expandableCellOptionsIcons: [], isExpandableCellsHidden: true, isExpanded: true),
        SectionsAccount(mainCellTitle: account_program, expandableCellOptions: [], mainCellOptionsIcons: account_icons, expandableCellOptionsIcons: [], isExpandableCellsHidden: true, isExpanded: true),
        SectionsAccount(mainCellTitle: account_payment, expandableCellOptions: [], mainCellOptionsIcons: account_icons, expandableCellOptionsIcons: [], isExpandableCellsHidden: true, isExpanded: true),
        SectionsAccount(mainCellTitle: account_solution, expandableCellOptions: [], mainCellOptionsIcons: account_icons, expandableCellOptionsIcons: [], isExpandableCellsHidden: true, isExpanded: true),
        SectionsAccount(mainCellTitle: account_delete, expandableCellOptions: [], mainCellOptionsIcons: account_icons, expandableCellOptionsIcons: [], isExpandableCellsHidden: true, isExpanded: true)
    
    ]
    
    
    let businessNature = ["Retailer",
                          "Wholesaler",
                          "Trader",
                          "Jeweller",
                          "Others"]
    
    let compaanyTypes = ["Proprietorship",
                         "LLP",
                         "Partnership",
                         "Private Limited",
                         "Public Limited",
                         "Others"]
    
    let inventoryTypes = ["Natural Diamond",
                         "Lab-Grown Diamond",
                         "Gemstones"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true


        // Do any additional setup after loading the view.
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent // Or .darkContent depending on your needs
    }
    
    //get device uniq ID
    func getSessionUniqID() -> String{
       return UIDevice.current.identifierForVendor!.uuidString
    }
    
    
   static func setClrUItextField(textFields : [FloatingTextField]){
        for i in textFields{
            i.floatPlaceholderActiveColor = .themeClr
            i.floatPlaceholderColor = .themeClr
        }
    }
    
    static func setClrUItextField2(textFields : [DTTextField]){
         for i in textFields{
             i.floatPlaceholderActiveColor = .themeClr
             i.floatPlaceholderColor = .themeClr
         }
     }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextTextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    func addAccessoryView(to textField: UITextField) {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let nextButton = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextButtonTapped))
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonTapped))
        
        toolbar.setItems([nextButton, flexibleSpace, doneButton], animated: false)
        
        textField.inputAccessoryView = toolbar
    }

    @objc func nextButtonTapped() {
        // Find the next text field and make it first responder
        // Implement this based on your text field setup
    }

    @objc func doneButtonTapped() {
        view.endEditing(true)
    }
    
    func navigationManager(storybordName: String, storyboardID: String, controller: UIViewController){
        let storyBoard: UIStoryboard = UIStoryboard(name: storybordName, bundle: nil)
         let vc = storyBoard.instantiateViewController(withIdentifier: storyboardID)
         self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigationManagerWithTag(tagVC: Int,storybordName: String, storyboardID: String, controller: UIViewController){
        let storyBoard: UIStoryboard = UIStoryboard(name: storybordName, bundle: nil)
         let vc = storyBoard.instantiateViewController(withIdentifier: storyboardID)
         self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func navigationManager<T: UIViewController & DataReceiver>(_ viewControllerType: T.Type, storyboardName: String,storyboardID: String, data: T.DataType) {
           guard let destinationViewController = UIStoryboard(name: storyboardName, bundle: nil).instantiateViewController(withIdentifier: storyboardID) as? T else {
               fatalError("Unable to instantiate view controller with storyboard ID: \(storyboardID)")
           }
           
           destinationViewController.receiveData(data)
           
           navigationController?.pushViewController(destinationViewController, animated: true)
       }
    
    
    func navigationManager<T: UIViewController & DataReceiver2>(_ viewControllerType: T.Type, storyboardName: String,storyboardID: String, data1: T.DataType1, data2: T.DataType2) {
           guard let destinationViewController = UIStoryboard(name: storyboardName, bundle: nil).instantiateViewController(withIdentifier: storyboardID) as? T else {
               fatalError("Unable to instantiate view controller with storyboard ID: \(storyboardID)")
           }
           
           destinationViewController.receiveData(data1)
           destinationViewController.receiveData2(data2)
           
           navigationController?.pushViewController(destinationViewController, animated: true)
       }
    
    
    
    func poptoRoot(){
        if let navigationController = self.navigationController {
            navigationController.popToRootViewController(animated: true)
        } else {
            print("This view controller is not embedded in a navigation controller.")
        }
    }
    
    // comma saparated
    func formatNumber(_ number: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        formatter.groupingSeparator = ","
        formatter.usesGroupingSeparator = true
        
        return formatter.string(from: NSNumber(value: number)) ?? ""
    }
    
    func formatNumberWithoutDeciml(_ number: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        formatter.minimumFractionDigits = 0
        formatter.groupingSeparator = ","
        formatter.usesGroupingSeparator = true
        
        return formatter.string(from: NSNumber(value: number)) ?? ""
    }
    
    

}


extension UIViewController{
    
    func toastMessage(_ message: String){
        guard let window = UIApplication.shared.keyWindow else {return}
        let messageLbl = UILabel()
        messageLbl.text = message
        messageLbl.textAlignment = .center
        messageLbl.font = UIFont.systemFont(ofSize: 12)
        messageLbl.textColor = .white
        messageLbl.backgroundColor = UIColor(white: 0, alpha: 0.5)
        
        let textSize:CGSize = messageLbl.intrinsicContentSize
        let labelWidth = min(textSize.width, window.frame.width - 40)
        
        messageLbl.frame = CGRect(x: 20, y: window.frame.height - 90, width: labelWidth + 30, height: textSize.height + 20)
        messageLbl.center.x = window.center.x
        messageLbl.layer.cornerRadius = messageLbl.frame.height/2
        messageLbl.layer.masksToBounds = true
        window.addSubview(messageLbl)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            
            UIView.animate(withDuration: 1, animations: {
                messageLbl.alpha = 0
            }) { (_) in
                messageLbl.removeFromSuperview()
            }
        }
    }
}


func isValidEmail(_ email: String) -> Bool {
    let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
    return emailPredicate.evaluate(with: email)
}


extension UITextField {

   func addInputViewDatePicker(target: Any, selector: Selector) {

    let screenWidth = UIScreen.main.bounds.width

    //Add DatePicker as inputView
    let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))
    datePicker.datePickerMode = .date
     
       if #available(iOS 13.4, *) {
           datePicker.preferredDatePickerStyle = .wheels
       } else {
           // Fallback on earlier versions
       }
    self.inputView = datePicker

    //Add Tool Bar as input AccessoryView
    let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 44))
    let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    let cancelBarButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPressed))
    let doneBarButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector)
    toolBar.setItems([cancelBarButton, flexibleSpace, doneBarButton], animated: false)

    self.inputAccessoryView = toolBar
 }

   @objc func cancelPressed() {
     self.resignFirstResponder()
   }
}


extension UITableView {
    
//    func getAllCells() -> [UITableViewCell] {
//        var cells = [UITableViewCell]()
//        for i in 0..<self.numberOfSections
//        {
//            for j in 0..<self.numberOfRows(inSection: i)
//            {
//                if let cell = self.cellForRow(at: IndexPath(row: j, section: i)) {
//                    cells.append(cell)
//                }
//                
//            }
//        }
//        return cells
//    }
    
    
    func getTopHiddenCells() -> [UITableViewCell] {
      var hiddenCells = [UITableViewCell]()
      let visibleTopIndexPaths = self.indexPathsForVisibleRows?.sorted(by: { $0 < $1 }) ?? []
      
      // Check if there are hidden cells above visible ones
      if let firstVisibleIndexPath = visibleTopIndexPaths.first {
        for section in 0..<firstVisibleIndexPath.section {
          for row in 0..<self.numberOfRows(inSection: section) {
            let indexPath = IndexPath(row: row, section: section)
            if let cell = self.cellForRow(at: indexPath) {
              hiddenCells.append(cell)
            }
          }
        }
      }
      
      return hiddenCells
    }
    
}


extension UIImageView {
    func setImage(from url: URL?, placeholder: UIImage?, timeoutInterval: TimeInterval = 5.0) {
        guard let url = url else {
            self.image = placeholder
            return
        }
        
        // Set the placeholder image immediately
        self.image = placeholder
        
        // Create a request with a timeout interval
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "HEAD"
        urlRequest.timeoutInterval = timeoutInterval
        
        // Perform the Alamofire request
        AF.request(urlRequest).response { response in
            if let httpResponse = response.response, httpResponse.statusCode == 200 {
                DispatchQueue.main.async {
                    self.sd_setImage(with: url, placeholderImage: placeholder)
                }
            } else {
                // The placeholder is already set, no need to set it again here
            }
        }
    }
}


// button feature
class EnlargedButton: UIButton {
    var enlargedInsets: UIEdgeInsets = .zero

    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let rect = bounds.inset(by: enlargedInsets.inverted())
        return rect.contains(point)
    }
}

extension UIEdgeInsets {
    func inverted() -> UIEdgeInsets {
        return UIEdgeInsets(top: -top, left: -left, bottom: -bottom, right: -right)
    }
}


extension UIView {
    func addTopShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: -2)
        self.layer.shadowRadius = 1
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
        guard !self.isEmpty else { return self }
        return self.prefix(1).capitalized + self.dropFirst().lowercased()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
