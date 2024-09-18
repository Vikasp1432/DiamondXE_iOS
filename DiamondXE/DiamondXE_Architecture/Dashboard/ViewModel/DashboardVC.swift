//
//  DashboardVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 23/04/24.
//

import UIKit
import DropDown
import SDWebImage


protocol CountUpdateDelegate: AnyObject {
    func updateCount(crdCnt: Int, wishCnt : Int)
}


class DashboardVC: BaseViewController, BaseViewControllerDelegate, DashbordCountryPopupViewDelegate, PinCodeDelegate, CountUpdateDelegate {
    
    
    
    func updateCount(crdCnt: Int, wishCnt: Int) {
        if crdCnt > 0{
            self.lblCrdCnt.isHidden = false
            self.lblCrdCnt.text = "\(crdCnt)"
        }
        else{
            self.lblCrdCnt.isHidden = true
        }
        
        if wishCnt > 0{
            self.lblWishlstCnt.isHidden = false
            self.lblWishlstCnt.text = "\(wishCnt)"
        }
        else{
            self.lblWishlstCnt.isHidden = true
        }
        
    }
    
   
 
    @IBOutlet var containerViewSideMenu: UIView!
    @IBOutlet var viewBG: UIImageView!
    @IBOutlet var swipeGesture: UISwipeGestureRecognizer!
    @IBOutlet var menuTableView: UITableView!
    @IBOutlet var lblVersion: UILabel!
    
    @IBOutlet var lblCrdCnt: UILabel!
    @IBOutlet var lblWishlstCnt: UILabel!
    
    @IBOutlet var imgLOGO: UIImageView!
    @IBOutlet var stackIcons: UIStackView!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var headerView: UIView!
    
    @IBOutlet var btnLocatioen: UIButton!
    @IBOutlet var btnNotific: UIButton!
    @IBOutlet var btnSelectC0untry: UIButton!
    
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var counrtyDropDownView: UIView!
    private var isCountyView = false
    
    private var isPopupVisible = false
    private var popupViewHeightConstraint: NSLayoutConstraint!
    private var popupViewWidthConstraint: NSLayoutConstraint!
    var isViewExpand = false
    @IBOutlet weak var popupViewHeightsConstraint: NSLayoutConstraint!
    let selectCountryView = SelectCountryView()
    let diaDetailsView = DiaDetailsPopupView()

    @IBOutlet weak var overlayView: UIView!

    var countryView = SelectCountryView()
    
    var currencySelectObj = CurrencyRateDetail()
    
    
    let screen = UIScreen.main.bounds
    var menu = false
    var home = CGAffineTransform()
    var diamondDetails = DiamondListingDetail()
    var diamondDetailsDocID = String()
    var byTopDeals = false
    var isByCard = false
    var isBydWish = false
    
    
    @IBOutlet var viewTabBar:UIView!
    @IBOutlet var btnSearch:UIButton!
    
    @IBOutlet var btnHome: UIButton!
    @IBOutlet var btnCategory: UIButton!
    @IBOutlet var btnWish: UIButton!
    @IBOutlet var btnCart: UIButton!
    @IBOutlet var btnLogin: UIButton!
    @IBOutlet var btnTitleHome: UIButton!
    @IBOutlet var btnTitleCategory: UIButton!
    @IBOutlet var btnTitleWish: UIButton!
    @IBOutlet var btnTitleCart: UIButton!
    @IBOutlet var btnTitleLogin: UIButton!
    @IBOutlet var btnSideMenu : UIButton!
    @IBOutlet var viewSideMnu : UIView!
    @IBOutlet var lblWelcomeUser: UILabel!
    @IBOutlet var lblType: UILabel!

    @IBOutlet weak var containerView: UIView!
    var tagV = VCTags()
    
    var sections: [Sections] = []
    
    
    private var currentViewController: UIViewController?
    private var currentViewControllerIdentifier: String?
    var sideMenuBtnTag = 0
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
           let location = sender.location(in: view)
           print("Screen tapped at: \(location)")
       }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // get currency
        CurrencyRatesManager.shareInstence.delegate = self
        CurrencyRatesManager.shareInstence.getCurrencyRates()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        viewSideMnu.addGestureRecognizer(tapGesture)
//        btnSideMenu.isUserInteractionEnabled = true
//        btnSideMenu.superview?.isUserInteractionEnabled = true
     

        let navigationController = UINavigationController(rootViewController: self)
        UIApplication.shared.windows.first?.rootViewController = navigationController
        
        self.lblVersion.text = getAppVersion
        btnSearch.layer.shadowOffset = CGSize(width:0, height:0)
        btnSearch.layer.shadowRadius = 2.5
        btnSearch.layer.shadowColor = UIColor.black.cgColor
        btnSearch.layer.shadowOpacity = 0.5
        btnSearch.clipsToBounds = false
        btnSearch.superview?.clipsToBounds = false
        
      
        loadViewController(withIdentifier: viewControllerIdentifiers[0], fromStoryboard: storyboardNames[0])
        
        self.lblTitle.isHidden = true
        home = self.containerView.transform
        
        // define uitableview cell
        menuTableView.register(UINib(nibName: ExpandableCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: ExpandableCell.cellIdentifier)
        menuTableView.register(UINib(nibName: MainCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: MainCell.cellIdentifier)
        menuTableView.showsHorizontalScrollIndicator = false
        menuTableView.showsVerticalScrollIndicator = false
        
        
        //
        setupFloatingButton()
        setupPopupView()
        defineCountryPopupView()
        defineDIADetailsPopupView()
        
        getCurrentLocation()
        
    }
    
    
    func getCurrentLocation(){
        let locationCode = HeaderInfoLocation().timeZoneInfo.countryCode ?? "US"
        print(locationCode)
        var updateCode = String()
        
        switch locationCode {
        case "IN":
            updateCode = "INR"
            self.btnSelectC0untry.setImage(UIImage(named: "Flag"), for: .normal)
        case "US":
            updateCode = "USD"
            self.btnSelectC0untry.setImage(UIImage(named: "usd"), for: .normal)
        case "EU":
            updateCode = "EUR"
            self.btnSelectC0untry.setImage(UIImage(named: "eur"), for: .normal)
        case "GB":
            updateCode = "GBD"
            self.btnSelectC0untry.setImage(UIImage(named: "gbp"), for: .normal)
        case "AU":
            updateCode = "AUD"
            self.btnSelectC0untry.setImage(UIImage(named: "aud"), for: .normal)
        case "CA":
            updateCode = "CAD"
            self.btnSelectC0untry.setImage(UIImage(named: "cad"), for: .normal)
        case "NZ":
            updateCode = "NZD"
            self.btnSelectC0untry.setImage(UIImage(named: "nzd"), for: .normal)
        case "SG":
            updateCode = "SGD"
            self.btnSelectC0untry.setImage(UIImage(named: "sgd"), for: .normal)
        case "AE":
            updateCode = "AED"
            self.btnSelectC0untry.setImage(UIImage(named: "aed"), for: .normal)
        default:
            print("")
        }
       // self.counrtyDropDownView.isHidden.toggle()
       
        var getCurrnyRate = CurrencyRatesManager.shareInstence.currencyRateStruct
        for (index, value) in getCurrnyRate.enumerated() {
            if updateCode == value.currency {
                self.currencySelectObj = value
                print(value)
                break
            }
        }
        
//        switch self.currentViewController {
//        case is AddToCartVC:
//            if let addTocart = self.currentViewController as? AddToCartVC {
//                addTocart.updateCurreny(currncyOBJ: self.currencySelectObj)
//                break
//            }
//        case is AddToWishListVC:
//            if let addTocart = self.currentViewController as? AddToWishListVC {
//                addTocart.updateCurreny(currncyOBJ: self.currencySelectObj)
//                break
//            }
//        case is HomeVC:
//            if let homeVC = self.currentViewController as? HomeVC {
//                homeVC.currencySelectObj =  currencySelectObj
//                homeVC.homeTableView.reloadSections([4], with: .none)
//            }
//        default:
//            print("")
//        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.sections = loadSections()
        
        if let loginData = UserDefaultManager().retrieveLoginData(){
            let userType = loginData.details?.userRole ?? ""
            let username = "\(loginData.details?.firstName ?? "") \(loginData.details?.lastName ?? "")"
            self.btnTitleLogin.setTitle(userType.capitalizingFirstLetter(), for: .normal)
            self.lblWelcomeUser.text = username
            self.lblType.text = userType
            //refreshBearertoken()
            
            if menu == true {
                hideMenu()
                menu = false
            }
            
            self.menuTableView.reloadData()
        }
    }
    
    // setup for view
    private func setupFloatingButton() {
        btnSearch.addTarget(self, action: #selector(floatingButtonTapped), for: .touchUpInside)
    }
    
    private func setupPopupView() {
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.7)

        popupView.backgroundColor = .white
        popupView.layer.cornerRadius = 16
        popupView.layer.masksToBounds = true
        popupView.layer.borderWidth = 2
        popupView.layer.borderColor = UIColor.white.cgColor
        popupView.translatesAutoresizingMaskIntoConstraints = false
                
        NSLayoutConstraint.activate([
            popupView.bottomAnchor.constraint(equalTo: btnSearch.topAnchor, constant: 40)
        ])

        popupViewHeightsConstraint.isActive = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(overlayViewTapped))
        overlayView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    
    // search wirth keyword
    func searcItemhWithKeyWord(){
        updateHeaderBG(setUpTag: 0)
        gotoSearchResultB2BVC(title: "Search Result")
    }
    
    
 
    @objc private func floatingButtonTapped() {
        
        switch self.currentViewController {
        case is HomeVC :
            gotoSearchDiamondVC(title: "Search Diamond")
            
           // navigationManager(storybordName: "GlobleSearch", storyboardID: "GlobleSearchVC", controller: GlobleSearchVC())
        case is SearchDiamondVC:
           updateHeaderBG(setUpTag: 0)
           gotoSearchResultB2BVC(title: "Search Result")
        case is B2BSearchResultVC:
            print("B2BDetails")
            togglePopup()
        case is DiamondDetailsVC:
            print("Details")
            togglePopup()

        default:
            gotoSearchDiamondVC(title: "Search Diamond")
            print(self.currentViewController)
        }
        
//     navigationManager(storybordName: "GlobleSearch", storyboardID: "GlobleSearchVC", controller: GlobleSearchVC())
    }
    
    
    func defineCountryPopupView(){
        selectCountryView.delegate = self
        selectCountryView.frame = popupView.bounds
//        popupView.addSubview(selectCountryView)
        popupViewHeightsConstraint.constant = 145
    }
    
    func defineDIADetailsPopupView(){
        diaDetailsView.delegate = self
        diaDetailsView.frame = popupView.bounds
//        popupView.addSubview(diaDetailsView)
        popupViewHeightsConstraint.constant = 100
    }
    
    
    @objc private func overlayViewTapped() {
        if isPopupVisible {
            togglePopup()
        }
    }
    
    
    @IBAction func btnActionHeaderBTN(_ sender : UIButton){
        switch sender.tag {
        case 1:
            let overLayerView = LocationPinView()
            overLayerView.pincodeDelagate = self
            overLayerView.appear(sender: self, pincode: 0)
            
        case 2:
            print("")
        default:
            countryViewDropDn()
            
        }
    }
    
    func countryViewDropDn(){
        self.counrtyDropDownView.isHidden.toggle()
        counrtyDropDownView.translatesAutoresizingMaskIntoConstraints = false
        let customView = DashboardCountryView()
        customView.delegate = self
        customView.frame = self.counrtyDropDownView.bounds
        customView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.counrtyDropDownView.addSubview(customView)
//            UIView.animate(withDuration: 0.3, animations: {
//                self.view.layoutIfNeeded()
//
//
//            }){ _ in
//            }
       
        
    }
    
    
    func customViewButtonTapped(_ customView: DashboardCountryView, returnValue: String) {
        print(returnValue)
        switch returnValue {
        case "INR":
            self.btnSelectC0untry.setImage(UIImage(named: "Flag"), for: .normal)
        case "USD":
            self.btnSelectC0untry.setImage(UIImage(named: "usd"), for: .normal)
        case "EUR":
            self.btnSelectC0untry.setImage(UIImage(named: "eur"), for: .normal)
        case "GBD":
            self.btnSelectC0untry.setImage(UIImage(named: "gbp"), for: .normal)
        case "AUD":
            self.btnSelectC0untry.setImage(UIImage(named: "aud"), for: .normal)
        case "CAD":
            self.btnSelectC0untry.setImage(UIImage(named: "cad"), for: .normal)
        case "NZD":
            self.btnSelectC0untry.setImage(UIImage(named: "nzd"), for: .normal)
        case "SGD":
            self.btnSelectC0untry.setImage(UIImage(named: "sgd"), for: .normal)
        case "AED":
            self.btnSelectC0untry.setImage(UIImage(named: "aed"), for: .normal)
        default:
            print("")
        }
        self.counrtyDropDownView.isHidden.toggle()
       
        var getCurrnyRate = CurrencyRatesManager.shareInstence.currencyRateStruct
        for (index, value) in getCurrnyRate.enumerated() {
            if returnValue == value.currency {
                self.currencySelectObj = value
                print(value)
                break
            }
        }
        
        switch self.currentViewController {
        case is AddToCartVC:
            if let addTocart = self.currentViewController as? AddToCartVC {
                addTocart.updateCurreny(currncyOBJ: self.currencySelectObj)
                break
            }
        case is AddToWishListVC:
            if let addTocart = self.currentViewController as? AddToWishListVC {
                addTocart.updateCurreny(currncyOBJ: self.currencySelectObj)
                break
            }
        case is HomeVC:
            if let homeVC = self.currentViewController as? HomeVC {
                homeVC.currencySelectObj =  currencySelectObj
                homeVC.homeTableView.reloadSections([4], with: .none)
            }
        default:
            print("")
        }
    }
    
    
    func currncyValChange(currncyValObj:CurrencyRateDetail) {
        switch self.currentViewController {
        case is B2BSearchResultVC:
            if let b2bSearchResultVC = self.currentViewController as? B2BSearchResultVC {
                b2bSearchResultVC.updateCurreny(currncyOBJ: currncyValObj)
                break
            }
        default:
            print("")
        }
    }
    
    
    
    func refreshBearertoken(){
        var logindata = UserDefaultManager.shareInstence.retrieveLoginData()
        
        if let token = logindata?.details?.authToken {
                        
            HomeDataModel().refreshToken(completion: { data, msg in
                if data.status == 1{
                    logindata?.details?.authToken = data.details?.accessToken
                    if let dataL = logindata{
                        UserDefaultManager.shareInstence.saveLoginData(topDelsObj: dataL)
                    }
                    
                }
                else{
                    UserDefaultManager.shareInstence.clearLoginDataDefaults()
                    self.btnTitleLogin.setTitle("Login", for: .normal)
                    self.lblWelcomeUser.text = "Welcome User"
                    self.lblType.text = "--"
                }
            })
        }
        else{
            self.btnTitleLogin.setTitle("Login", for: .normal)
            self.lblWelcomeUser.text = "Welcome User"
            self.lblType.text = "--"
        }
        
    }
        
    func didEnterPincode(pincode: String, indexPath: IndexPath) {
        UserDefaultManager().saveLocation(location: pincode)
    }
    
  
    
    
//    private func togglePopup() {
//        isPopupVisible.toggle()
//        overlayView.isHidden = !isPopupVisible
//        btnSearch.layer.borderWidth = isPopupVisible ? 5 : 0
//        btnSearch.layer.borderColor = isPopupVisible ? UIColor.white.cgColor : nil
//        
//        if isPopupVisible{
//            btnSearch.layer.shadowRadius = 0
//            btnSearch.layer.shadowColor = .none
//            self.popupView.isHidden = false
//        }
//        else{
//            btnSearch.layer.shadowRadius = 4
//            self.popupView.isHidden = false
//
//        }
//        
//        switch self.currentViewController {
//        case is B2BSearchResultVC:
//            popupView.addSubview(selectCountryView)
//            selectCountryView.viewData.isHidden = true
//            selectCountryView.isViewExpand = false
//            popupViewHeightsConstraint.constant = isPopupVisible ? 140 : 0
//        case is DiamondDetailsVC:
//            popupView.addSubview(diaDetailsView)
//            popupViewHeightsConstraint.constant = isPopupVisible ? 250 : 0
//
//        default:
//            print(self.currentViewController)
//        }
//        
//        
//        UIView.animate(withDuration: 0.3, animations: {
//            self.view.layoutIfNeeded()
//            let rotationAngle: CGFloat = self.isPopupVisible ? .pi / 4 : 0
//            self.btnSearch.transform = CGAffineTransform(rotationAngle: rotationAngle)
//            self.overlayView.alpha = self.isPopupVisible ? 0.7 : 0.0
//           
//        }){ _ in
//            if !self.isPopupVisible {
//                self.overlayView.isHidden = true
//            }
//        }
//    }
    
    private func togglePopup() {
        isPopupVisible.toggle()
        overlayView.isHidden = false
        
      
        btnSearch.layer.masksToBounds = true
        btnSearch.layer.borderWidth = isPopupVisible ? 5 : 0
        btnSearch.layer.borderColor = isPopupVisible ? UIColor.white.cgColor : nil
        
        if isPopupVisible {
            btnSearch.layer.shadowRadius = 0
            btnSearch.layer.shadowColor = .none
            self.popupView.isHidden = false
        } else {
            btnSearch.layer.shadowRadius = 4
        }
        
        switch self.currentViewController {
        case is B2BSearchResultVC:
            selectCountryView.translatesAutoresizingMaskIntoConstraints = false
            
            
            popupView.addSubview(selectCountryView)
            
         
            NSLayoutConstraint.activate([
                        selectCountryView.leadingAnchor.constraint(equalTo: popupView.leadingAnchor),
                        selectCountryView.trailingAnchor.constraint(equalTo: popupView.trailingAnchor),
                        selectCountryView.topAnchor.constraint(equalTo: popupView.topAnchor),
                        selectCountryView.bottomAnchor.constraint(equalTo: popupView.bottomAnchor)
                    ])
            selectCountryView.viewData.isHidden = true
            selectCountryView.isViewExpand = false
            if let title = self.currencySelectObj.currency{
                selectCountryView.lblTitle.text = "\(title)"
                selectCountryView.lblSubTitle.text = "\(self.currencySelectObj.desc ?? "")"
                selectCountryView.btnFlag.sd_setImage(with: URL(string: self.currencySelectObj.img ?? ""), for: .normal,placeholderImage: UIImage(named: "place_Holder"))
                
               
            }
            popupViewHeightsConstraint.constant = isPopupVisible ? 140 : 0
        case is DiamondDetailsVC:
            diaDetailsView.translatesAutoresizingMaskIntoConstraints = false
            popupView.addSubview(diaDetailsView)
            NSLayoutConstraint.activate([
                diaDetailsView.leadingAnchor.constraint(equalTo: popupView.leadingAnchor),
                diaDetailsView.trailingAnchor.constraint(equalTo: popupView.trailingAnchor),
                diaDetailsView.topAnchor.constraint(equalTo: popupView.topAnchor),
                diaDetailsView.bottomAnchor.constraint(equalTo: popupView.bottomAnchor)
                    ])
            popupViewHeightsConstraint.constant = isPopupVisible ? 100 : 0
        default:
            print(self.currentViewController)
        }
        
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
            let rotationAngle: CGFloat = self.isPopupVisible ? .pi / 4 : 0
            self.btnSearch.transform = CGAffineTransform(rotationAngle: rotationAngle)
            self.overlayView.alpha = self.isPopupVisible ? 0.7 : 0.0
        }, completion: { _ in
            if self.isPopupVisible {
                UIView.animate(withDuration: 0.3, animations: {
                   
                })
            } else {
                UIView.animate(withDuration: 0.3, animations: {
//                    let rotationAngle: CGFloat = self.isPopupVisible ? .pi / 4 : 0
//                    self.btnSearch.transform = CGAffineTransform(rotationAngle: rotationAngle)
                }, completion: { _ in
                    self.popupView.isHidden = true
                    self.overlayView.isHidden = true
                })
            }
        })
    }
    
    func updateHeaderBG(setUpTag:Int) {
        if setUpTag == 0 {
            headerView.backgroundColor = .whitClr
            headerView.layer.shadowColor = UIColor.lightGray.cgColor
            headerView.layer.shadowOffset = CGSize(width: 0.0, height: 1.5)
            headerView.layer.shadowRadius = 1.0
            headerView.layer.shadowOpacity = 0.3
            headerView.layer.masksToBounds = false
        }
        else{
            headerView.backgroundColor = .videBGClr
            headerView.layer.shadowColor = UIColor.shadowViewclr.cgColor
            headerView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
            headerView.layer.shadowRadius = 0.0
            headerView.layer.shadowOpacity = 0.0
            headerView.layer.masksToBounds = false
        }
    }

    //goto search from dashboard
    func didPerformAction(tag: Int) {
        switch tag {
        case 0:
            updateHeaderBG(setUpTag: 1)
            self.gotoSearchDiamondVC(title: "Solitaires")
        default:
            self.navigationManager(storybordName: "CategoriesVC", storyboardID: "CommingSoonVC", controller: CommingSoonVC())
            
//            self.navigationManager(storybordName: "PaymentModule", storyboardID: "PaymentModuleVC", controller: PaymentModuleVC())
        }
       
       }
    
    func loadViewController(withIdentifier identifier: String, fromStoryboard storyboardName: String) {
        if identifier == currentViewControllerIdentifier {
            return
        }
        cartVCIsComeFromHome = true
//        self.byTopDeals = false
//        self.isByCard = false
//        self.isBydWish = false
       
        let direction: SlideDirection = {
            if let currentIdentifier = currentViewControllerIdentifier,
               let currentIndex = viewControllerIdentifiers.firstIndex(of: currentIdentifier),
               let newIndex = viewControllerIdentifiers.firstIndex(of: identifier) {
                return newIndex > currentIndex ? .right : .left
            }
            return .right
        }()
        
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        guard let newViewController = storyboard.instantiateViewController(withIdentifier: identifier) as? ChildViewControllerProtocol else { return }
        if let diamondDetailsVC = newViewController as? HomeVC {
            diamondDetailsVC.dashBoardVC = self
            byTopDeals = true
            self.btnSearch.setImage(UIImage(named: "SearchI"), for: .normal)
            
        }
        if let diamondDetailsVC = newViewController as? SearchDiamondVC {
            self.diamondDetailsDocID = String()
            self.byTopDeals = false
            self.isByCard = false
            self.isBydWish = false
            diamondDetailsVC.dashboardVC = self
            self.btnSearch.setImage(UIImage(named: "SearchI"), for: .normal)
        }
        
        
        if let addToCartVC = newViewController as? AddToCartVC{
            addToCartVC.dashboardVC = self
            self.isByCard = true
            self.byTopDeals = false
            self.isBydWish = false
            addToCartVC.delegateCount = self
            addToCartVC.currencyRateDetailObj = self.currencySelectObj
        }
        
        if let addToWishListVC = newViewController as? AddToWishListVC{
            addToWishListVC.dashboardVC = self
            self.isBydWish = true
            self.byTopDeals = false
            self.isByCard = false
            addToWishListVC.delegateCount = self
            addToWishListVC.currencyRateDetailObj = self.currencySelectObj
        }
        
        if let diamondDetailsVC = newViewController as? DiamondDetailsVC {
           if !self.diamondDetailsDocID.isEmpty{
               self.diamondDetails.certificateNo = self.diamondDetailsDocID
            }
            self.lblTitle.text = "Diamond Detail"
            diamondDetailsVC.currencyRateDetailObj = self.currencySelectObj
            diamondDetailsVC.diamondInfo = self.diamondDetails
            self.btnSearch.setImage(UIImage(named: "plus"), for: .normal)
            self.sideMenuBtnTag = 1
            self.btnSideMenu.setImage(UIImage(named: "backButton"), for: .normal)
            self.lblTitle.isHidden = false
            self.imgLOGO.isHidden = true
            self.stackIcons.isHidden = true
            
            diamondDetailsVC.delegateCount = self
        }
        
        if let b2bSearchDiamondVC = newViewController as? B2BSearchResultVC {
            b2bSearchDiamondVC.dashboardVC = self
            b2bSearchDiamondVC.updateCurreny(currncyOBJ: self.currencySelectObj)
            self.byTopDeals = false
            b2bSearchDiamondVC.delegateCount = self
            self.btnSearch.setImage(UIImage(named: "plus"), for: .normal)
        }
        self.currncyValChange(currncyValObj: self.currencySelectObj)
        newViewController.delegate = self
        newViewController.didSendString(str: self.lblTitle.text ?? "")
        let width = self.containerView.bounds.size.width
        let initialFrame = CGRect(x: direction == .right ? width : -width, y: 0, width: width, height: self.containerView.bounds.size.height)
        let finalFrame = self.containerView.bounds
        
        newViewController.view.frame = initialFrame
        containerView.addSubview(newViewController.view)
        addChild(newViewController)
        newViewController.didMove(toParent: self)
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
            newViewController.view.frame = finalFrame
            self.currentViewController?.view.frame = CGRect(x: direction == .right ? -width : width, y: 0, width: width, height: self.containerView.bounds.size.height)
        }) { _ in
            self.currentViewController?.willMove(toParent: nil)
            self.currentViewController?.view.removeFromSuperview()
            self.currentViewController?.removeFromParent()
            self.currentViewController = newViewController
            self.currentViewControllerIdentifier = identifier
        }
        
    }
    
    
    
    
//     func loadViewController(withIdentifier identifier: String, fromStoryboard storyboardName: String) {
//        
//        // Check if the new view controller is the same as the current one
//        if identifier == currentViewControllerIdentifier {
//            return
//        }
//
//        // Determine the direction
//        let direction: SlideDirection = {
//            if let currentIdentifier = currentViewControllerIdentifier,
//               let currentIndex = viewControllerIdentifiers.firstIndex(of: currentIdentifier),
//               let newIndex = viewControllerIdentifiers.firstIndex(of: identifier) {
//                return newIndex > currentIndex ? .right : .left
//            }
//            return .right
//        }()
//
//        // Instantiate the view controller
//        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
//         let newViewController = storyboard.instantiateViewController(withIdentifier: identifier)
//         newViewController.delegate = self
//
//       
//         let width = self.containerView.bounds.size.width
//         let initialFrame = CGRect(x: direction == .right ? width : -width, y: 0, width: width, height: self.containerView.bounds.size.height)
//         let finalFrame = self.containerView.bounds
//
//        newViewController.view.frame = initialFrame
//        containerView.addSubview(newViewController.view)
//        addChild(newViewController)
//        newViewController.didMove(toParent: self)
//        
//        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
//            newViewController.view.frame = finalFrame
//            self.currentViewController?.view.frame = CGRect(x: direction == .right ? -width : width, y: 0, width: width, height: self.containerView.bounds.size.height)
//        }) { _ in
//            self.currentViewController?.willMove(toParent: nil)
//            self.currentViewController?.view.removeFromSuperview()
//            self.currentViewController?.removeFromParent()
//            self.currentViewController = newViewController
//           
//            self.currentViewControllerIdentifier = identifier
//        }
//    }

    
    
    
    func showMenu() {
        containerViewSideMenu.layer.shadowOffset = CGSize(width:0, height:0)
        containerViewSideMenu.layer.shadowRadius = 4.5
        containerViewSideMenu.layer.shadowColor = UIColor.gray.cgColor
        containerViewSideMenu.layer.shadowOpacity = 0.6
        self.containerViewSideMenu.layer.cornerRadius = 2
        self.viewBG.layer.cornerRadius = self.containerViewSideMenu.layer.cornerRadius
        let x = screen.width * 0.8
        let originalTransform = self.containerViewSideMenu.transform
        let scaledTransform = originalTransform.scaledBy(x: 0.8, y: 0.8)
            let scaledAndTranslatedTransform = scaledTransform.translatedBy(x: x, y: 0)
            UIView.animate(withDuration: 0.3, animations: {
                self.containerViewSideMenu.transform = scaledAndTranslatedTransform
                
            })
        
    }
    
    func hideMenu() {
        
        UIView.animate(withDuration: 0.3, animations: {
            self.containerViewSideMenu.transform = self.home
            self.containerViewSideMenu.layer.cornerRadius = 0
            self.viewBG.layer.cornerRadius = 0
            
        })
        
    }
    

    
    @IBAction func showMenu(_ sender: UISwipeGestureRecognizer) {
        
       // print("menu interaction")
        if self.sideMenuBtnTag == 0{
            if menu == false && swipeGesture.direction == .right {
                
                //print("user is showing menu")
                
                showMenu()
                
                menu = true
                
            }
           
        }
        
    }
    
    
    
    @IBAction func hideMenu(_ sender: Any) {
        
        if menu == true {
            
          //  print("user is hiding menu")
            
            hideMenu()
            
            menu = false
            
        }
        
        
    }
    
    
    func homeVCManage(){
        let identifier = viewControllerIdentifiers[0]
        let storyboardName = storyboardNames[0]
        loadViewController(withIdentifier: identifier, fromStoryboard: storyboardName)
        self.sideMenuBtnTag = 0
        updateHeaderBG(setUpTag: 1)
        self.btnSideMenu.setImage(UIImage(named: "sideMenu"), for: .normal)
        self.lblTitle.isHidden = true
        self.imgLOGO.isHidden = false
        self.stackIcons.isHidden = false
        isComeFromHome = true
        cartVCIsComeFromHome = true
        
        self.btnHome.tintColor = .themeClr
        self.btnCategory.tintColor = .clrGray
        self.btnWish.tintColor = .clrGray
        self.btnCart.tintColor = .clrGray
        self.btnLogin.tintColor = .clrGray
        self.btnTitleHome.setTitleColor(UIColor.themeClr, for: .normal)
        self.btnTitleCategory.setTitleColor(UIColor.clrGray, for: .normal)
        self.btnTitleWish.setTitleColor(UIColor.clrGray, for: .normal)
        self.btnTitleCart.setTitleColor(UIColor.clrGray, for: .normal)
        self.btnTitleLogin.setTitleColor(UIColor.clrGray, for: .normal)
    }
    
    func WishListManage(){
        let identifier = viewControllerIdentifiers[2]
        let storyboardName = storyboardNames[2]
        loadViewController(withIdentifier: identifier, fromStoryboard: storyboardName)
        self.sideMenuBtnTag = 0
        updateHeaderBG(setUpTag: 1)
        self.btnSideMenu.setImage(UIImage(named: "sideMenu"), for: .normal)
        self.lblTitle.isHidden = true
        self.imgLOGO.isHidden = false
        self.stackIcons.isHidden = false
        isComeFromHome = true
        cartVCIsComeFromHome = true
        
        self.btnHome.tintColor = .clrGray
        self.btnCategory.tintColor = .clrGray
        self.btnWish.tintColor = .themeClr
        self.btnCart.tintColor = .clrGray
        self.btnLogin.tintColor = .clrGray
        self.btnTitleHome.setTitleColor(UIColor.clrGray, for: .normal)
        self.btnTitleCategory.setTitleColor(UIColor.clrGray, for: .normal)
        self.btnTitleWish.setTitleColor(UIColor.themeClr, for: .normal)
        self.btnTitleCart.setTitleColor(UIColor.clrGray, for: .normal)
        self.btnTitleLogin.setTitleColor(UIColor.clrGray, for: .normal)
    }
    
    func cardListManage(){
        let identifier = viewControllerIdentifiers[3]
        let storyboardName = storyboardNames[3]
        loadViewController(withIdentifier: identifier, fromStoryboard: storyboardName)
        self.sideMenuBtnTag = 0
        updateHeaderBG(setUpTag: 1)
        self.btnSideMenu.setImage(UIImage(named: "sideMenu"), for: .normal)
        self.lblTitle.isHidden = true
        self.imgLOGO.isHidden = false
        self.stackIcons.isHidden = false
        isComeFromHome = true
        cartVCIsComeFromHome = true
        
        self.btnHome.tintColor = .clrGray
        self.btnCategory.tintColor = .clrGray
        self.btnWish.tintColor = .clrGray
        self.btnCart.tintColor = .themeClr
        self.btnLogin.tintColor = .clrGray
        self.btnTitleHome.setTitleColor(UIColor.clrGray, for: .normal)
        self.btnTitleCategory.setTitleColor(UIColor.clrGray, for: .normal)
        self.btnTitleWish.setTitleColor(UIColor.clrGray, for: .normal)
        self.btnTitleCart.setTitleColor(UIColor.themeClr, for: .normal)
        self.btnTitleLogin.setTitleColor(UIColor.clrGray, for: .normal)
    }
    
    
    @IBAction func btnActionTapped(_ sender: UIButton) {
        let identifier = viewControllerIdentifiers[sender.tag]
        let storyboardName = storyboardNames[sender.tag]
        loadViewController(withIdentifier: identifier, fromStoryboard: storyboardName)
        self.sideMenuBtnTag = 0
        updateHeaderBG(setUpTag: 1)
        self.btnSideMenu.setImage(UIImage(named: "sideMenu"), for: .normal)
        self.lblTitle.isHidden = true
        self.imgLOGO.isHidden = false
        self.stackIcons.isHidden = false
        isComeFromHome = true
        cartVCIsComeFromHome = true
        switch sender.tag {
        case 0:
            CurrencyRatesManager.shareInstence.getCurrencyRates()
            self.btnHome.tintColor = .themeClr
            self.btnCategory.tintColor = .clrGray
            self.btnWish.tintColor = .clrGray
            self.btnCart.tintColor = .clrGray
            self.btnLogin.tintColor = .clrGray
            self.btnTitleHome.setTitleColor(UIColor.themeClr, for: .normal)
            self.btnTitleCategory.setTitleColor(UIColor.clrGray, for: .normal)
            self.btnTitleWish.setTitleColor(UIColor.clrGray, for: .normal)
            self.btnTitleCart.setTitleColor(UIColor.clrGray, for: .normal)
            self.btnTitleLogin.setTitleColor(UIColor.clrGray, for: .normal)
            
        case 1:
            self.btnHome.tintColor = .clrGray
            self.btnCategory.tintColor = .themeClr
            self.btnWish.tintColor = .clrGray
            self.btnCart.tintColor = .clrGray
            self.btnLogin.tintColor = .clrGray
            self.btnTitleHome.setTitleColor(UIColor.clrGray, for: .normal)
            self.btnTitleCategory.setTitleColor(UIColor.themeClr, for: .normal)
            self.btnTitleWish.setTitleColor(UIColor.clrGray, for: .normal)
            self.btnTitleCart.setTitleColor(UIColor.clrGray, for: .normal)
            self.btnTitleLogin.setTitleColor(UIColor.clrGray, for: .normal)
            
        case 2:
            self.btnHome.tintColor = .clrGray
            self.btnCategory.tintColor = .clrGray
            self.btnWish.tintColor = .themeClr
            self.btnCart.tintColor = .clrGray
            self.btnLogin.tintColor = .clrGray
            self.btnTitleHome.setTitleColor(UIColor.clrGray, for: .normal)
            self.btnTitleCategory.setTitleColor(UIColor.clrGray, for: .normal)
            self.btnTitleWish.setTitleColor(UIColor.themeClr, for: .normal)
            self.btnTitleCart.setTitleColor(UIColor.clrGray, for: .normal)
            self.btnTitleLogin.setTitleColor(UIColor.clrGray, for: .normal)
           
        case 3:
            self.btnHome.tintColor = .clrGray
            self.btnCategory.tintColor = .clrGray
            self.btnWish.tintColor = .clrGray
            self.btnCart.tintColor = .themeClr
            self.btnLogin.tintColor = .clrGray
            self.btnTitleHome.setTitleColor(UIColor.clrGray, for: .normal)
            self.btnTitleCategory.setTitleColor(UIColor.clrGray, for: .normal)
            self.btnTitleWish.setTitleColor(UIColor.clrGray, for: .normal)
            self.btnTitleCart.setTitleColor(UIColor.themeClr, for: .normal)
            self.btnTitleLogin.setTitleColor(UIColor.clrGray, for: .normal)
            
        default:
            
            self.btnHome.tintColor = .clrGray
            self.btnCategory.tintColor = .clrGray
            self.btnWish.tintColor = .clrGray
            self.btnCart.tintColor = .clrGray
            self.btnLogin.tintColor = .themeClr
            self.btnTitleHome.setTitleColor(UIColor.clrGray, for: .normal)
            self.btnTitleCategory.setTitleColor(UIColor.clrGray, for: .normal)
            self.btnTitleWish.setTitleColor(UIColor.clrGray, for: .normal)
            self.btnTitleCart.setTitleColor(UIColor.clrGray, for: .normal)
            self.btnTitleLogin.setTitleColor(UIColor.themeClr, for: .normal)
            let loginData = UserDefaultManager().retrieveLoginData()
            if let status = loginData?.details?.userRole {
               print("")
            }
            else{
                self.navigationManager(storybordName: "Login", storyboardID: "LoginVC", controller: LoginVC())
            }
           
            
        }
    }
   
    
    @IBAction func btnActionSideMenu(_ sender: UIButton) {
       // print("menu interaction")
        
        switch self.currentViewController {
        case is B2BSearchResultVC:
            updateHeaderBG(setUpTag: 1)
            gotoSearchDiamondVC(title: "Search Diamond")
            
        case is DiamondDetailsVC:
            
            if byTopDeals{
                homeVCManage()
            }
            else if isByCard{
                cardListManage()
            }
            else if isBydWish{
                WishListManage()
            }
            else{
               
                updateHeaderBG(setUpTag: 1)
                gotoSearchResultB2BVC(title: "Search Diamond")
            }
            
        default:
            updateHeaderBG(setUpTag: 1)
            if self.sideMenuBtnTag == 0{
                
                if menu == false && swipeGesture.direction == .right {
                    
                    //print("user is showing menu")
                    
                    showMenu()
                    
                    menu = true
                    
                }
                else{
                    hideMenu()
                    menu = false
                }
            }
            else{
                self.sideMenuBtnTag = 0
                self.homeMenuActive()
                self.btnSideMenu.setImage(UIImage(named: "sideMenu"), for: .normal)
                self.lblTitle.isHidden = true
                self.imgLOGO.isHidden = false
                self.stackIcons.isHidden = false
            }
        }
    }
    
    
    
  
    
//    @IBAction func btnActionSearch(_ sender: UIButton) {
//        
//        switch self.currentViewController {
//        case is SearchDiamondVC:
//            updateHeaderBG(setUpTag: 0)
//           gotoSearchResultB2BVC(title: "Search Result")
//        case is B2BSearchResultVC:
//            print("B2BDetails")
//            togglePopup()
//        case is DiamondDetailsVC:
//            print("Details")
//            togglePopup()
//
//        default:
//            print(self.currentViewController)
//        }
//        
////     navigationManager(storybordName: "GlobleSearch", storyboardID: "GlobleSearchVC", controller: GlobleSearchVC())
//    }
    
    @IBAction func btnActionSocialM(_ sender: UIButton) {
        self.tagV.tagVC = sender.tag
        gotoWKWebView()
        
    }

    
}

extension DashboardVC : SelectCountryViewDelegate, DiaDetailsPopupViewDelegate {
    func customViewButtonTapped(_ customView: SelectCountryView, returnValue: String) {
        if returnValue != "isExpand" && returnValue != "None"{
            var getCurrnyRate = CurrencyRatesManager.shareInstence.currencyRateStruct
            for (index, value) in getCurrnyRate.enumerated() {
                if returnValue == value.currency {
                    switch self.currentViewController {
                    case is B2BSearchResultVC:
                        if let b2bSearchResultVC = self.currentViewController as? B2BSearchResultVC {
                            b2bSearchResultVC.updateCurreny(currncyOBJ: value)
                            break
                        }
                    default:
                        print("")
                    }
                    break
                }
            }
            
        }
        
        isViewExpand.toggle()
        if returnValue == "isExpand"{
            selectCountryView.viewData.isHidden = false
            selectCountryView.setupData()
            popupViewHeightsConstraint.constant = 490
            UIView.animate(withDuration: 0.3,
                           delay: 0,
                           options: .curveEaseInOut,
                           animations: {
                self.view.layoutIfNeeded()
            },
                           completion: nil)
        }
        else if returnValue == "None" {
            selectCountryView.viewData.isHidden = true
            popupViewHeightsConstraint.constant = 140
            UIView.animate(withDuration: 0.3,
                           delay: 0,
                           options: .curveEaseInOut,
                           animations: {
                self.view.layoutIfNeeded()
            },
                           completion: nil)
        }
    }
    
    func customViewButtonTapped(_ customView: DiaDetailsPopupView, returnValue: String) {
        print(returnValue)
        if returnValue == "CallFEnqry"{
            let phoneNumber = nv_whatsapp
            if let phoneURL = URL(string: "tel://\(phoneNumber)") {
                if UIApplication.shared.canOpenURL(phoneURL) {
                    UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
                } else {
                    // Handle the error
                    print("Cannot open phone dialer")
                }
            }
        }
    }
    
    
}


extension DashboardVC : B2BSearchResultVCDelegate {
    func didSelectDiamond(_ diamond: DiamondListingDetail) {
        print(diamond)
        self.diamondDetails = diamond
//        let identifier = viewControllerIdentifiers[0]
//        let storyboardName = storyboardNames[0]
//        loadViewController(withIdentifier: identifier, fromStoryboard: storyboardName)
        self.loadViewController(withIdentifier: "DiamondDetailsVC", fromStoryboard: "DiamondDetails")

    }
    
}

extension DashboardVC:UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
            return sections.count
        }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            let section = sections[section]
            if section.isExpandableCellsHidden {
                return 1
            } else {
                return section.expandableCellOptions.count + 1
            }
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: MainCell.cellIdentifier, for: indexPath) as! MainCell
                
                cell.configure(with: sections[indexPath.section])
                cell.mainIconIMG.image = sections[indexPath.section].mainCellOptionsIcons[indexPath.section]
                
                cell.tapCell = {
                    if indexPath.row == 0 {
                        let section = indexPath.section
                        
                        self.sideMenuActions(sectionStr: self.sections[section].mainCellTitle)
                        
                        let isCurrentlyHidden = self.sections[section].isExpandableCellsHidden
                        self.sections[section].isExpandableCellsHidden = !isCurrentlyHidden
                        self.sections[section].isExpanded = !isCurrentlyHidden // Update the expanded state

                        if self.sections[section].expandableCellOptions.isEmpty {
                            // If there are no expandable options, do nothing
                            return
                        }

                        var indexPaths = [IndexPath]()
                        for row in 1...self.sections[section].expandableCellOptions.count {
                            indexPaths.append(IndexPath(row: row, section: section))
                        }
                        
                        tableView.beginUpdates()
                        if isCurrentlyHidden {
                            // Expand the section with animation
                            tableView.insertRows(at: indexPaths, with: .fade)
                        } else {
                            // Collapse the section with animation
                            tableView.deleteRows(at: indexPaths, with: .fade)
                        }
                        tableView.endUpdates()

                        // Reload the main cell to update the icon
                        let mainCellIndexPath = IndexPath(row: 0, section: section)
                        tableView.reloadRows(at: [mainCellIndexPath], with: .none)
                    }
                    
                    else{
                        self.sideMenuActions(sectionStr: self.sections[indexPath.section].expandableCellOptions[indexPath.row - 1])
                    }

                }
                
                
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: ExpandableCell.cellIdentifier, for: indexPath) as! ExpandableCell
                cell.label.text = sections[indexPath.section].expandableCellOptions[indexPath.row - 1]
                cell.iconIMG.image = sections[indexPath.section].expandableCellOptionsIcons[indexPath.row - 1]
                
                cell.tapCell = {
                    self.sideMenuActions(sectionStr: self.sections[indexPath.section].expandableCellOptions[indexPath.row - 1])
                }
                return cell
            }
        }
        
//        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//            if indexPath.row == 0 {
//                let section = indexPath.section
//                
//                self.sideMenuActions(sectionStr: sections[section].mainCellTitle)
//                
//                let isCurrentlyHidden = sections[section].isExpandableCellsHidden
//                sections[section].isExpandableCellsHidden = !isCurrentlyHidden
//                sections[section].isExpanded = !isCurrentlyHidden // Update the expanded state
//
//                if sections[section].expandableCellOptions.isEmpty {
//                    // If there are no expandable options, do nothing
//                    return
//                }
//
//                var indexPaths = [IndexPath]()
//                for row in 1...sections[section].expandableCellOptions.count {
//                    indexPaths.append(IndexPath(row: row, section: section))
//                }
//                
//                tableView.beginUpdates()
//                if isCurrentlyHidden {
//                    // Expand the section with animation
//                    tableView.insertRows(at: indexPaths, with: .fade)
//                } else {
//                    // Collapse the section with animation
//                    tableView.deleteRows(at: indexPaths, with: .fade)
//                }
//                tableView.endUpdates()
//
//                // Reload the main cell to update the icon
//                let mainCellIndexPath = IndexPath(row: 0, section: section)
//                tableView.reloadRows(at: [mainCellIndexPath], with: .none)
//            }
//            
//            else{
//                self.sideMenuActions(sectionStr: sections[indexPath.section].expandableCellOptions[indexPath.row - 1])
//            }
//        }
    
    
    func homeMenuActive(){
        let identifier = viewControllerIdentifiers[0]
        let storyboardName = storyboardNames[0]
        loadViewController(withIdentifier: identifier, fromStoryboard: storyboardName)
        self.btnHome.tintColor = .themeClr
        self.btnCategory.tintColor = .clrGray
        self.btnWish.tintColor = .clrGray
        self.btnCart.tintColor = .clrGray
        self.btnLogin.tintColor = .clrGray
        self.btnTitleHome.setTitleColor(UIColor.themeClr, for: .normal)
        self.btnTitleCategory.setTitleColor(UIColor.clrGray, for: .normal)
        self.btnTitleWish.setTitleColor(UIColor.clrGray, for: .normal)
        self.btnTitleCart.setTitleColor(UIColor.clrGray, for: .normal)
        self.btnTitleLogin.setTitleColor(UIColor.clrGray, for: .normal)
        hideMenu()
        menu = false
    }
    
    func sideMenuActions(sectionStr:String){
        
        if nv_home == sectionStr{
            if menu == true {
                homeMenuActive()
            }
        }
        
        else if nv_naturalDiamond == sectionStr{
            updateHeaderBG(setUpTag: 1)
            gotoSearchDiamondVC(title: "Natural Diamonds")
//            print(sectionStr)
//          //  self.navigationManager(storybordName: "SearchDiamond", storyboardID: "SearchDiamondVC", controller: SearchDiamondVC())
//            let identifier = viewControllerIdentifiers[5]
//            let storyboardName = storyboardNames[5]
//            loadViewController(withIdentifier: identifier, fromStoryboard: storyboardName)
//            hideMenu()
//            menu = false
//            self.sideMenuBtnTag = 1
//            self.btnSideMenu.setImage(UIImage(named: "backButton"), for: .normal)
//            
//            self.lblTitle.isHidden = false
//            self.imgLOGO.isHidden = true
//            self.stackIcons.isHidden = true
//            
//            self.btnHome.tintColor = .clrGray
//            self.btnCategory.tintColor = .clrGray
//            self.btnWish.tintColor = .clrGray
//            self.btnCart.tintColor = .clrGray
//            self.btnLogin.tintColor = .clrGray
//            self.btnTitleHome.setTitleColor(UIColor.clrGray, for: .normal)
//            self.btnTitleCategory.setTitleColor(UIColor.clrGray, for: .normal)
//            self.btnTitleWish.setTitleColor(UIColor.clrGray, for: .normal)
//            self.btnTitleCart.setTitleColor(UIColor.clrGray, for: .normal)
//            self.btnTitleLogin.setTitleColor(UIColor.clrGray, for: .normal)
            
        }
        
        else if nv_labGrownDiamond == sectionStr{
            updateHeaderBG(setUpTag: 1)
            gotoSearchDiamondVC(title: "Lab Grown Diamonds")
        }
        
        
        else if nv_diamondEducation == sectionStr{
            print(sectionStr)
            self.tagV.tagVC = 1
            gotoWKWebView()
           
        }
        
        else if nv_jeweller == sectionStr{
            print(sectionStr)
            self.tagV.tagVC = 2
            gotoWKWebView()
            
        }
        
        else if nv_supplier == sectionStr{
            print(sectionStr)
            self.tagV.tagVC = 3
            gotoWKWebView()
           
        }
        
        else if nv_aboutUS == sectionStr{
            print(sectionStr)
            self.tagV.tagVC = 4
            gotoWKWebView()
            
        }
        
        else if nv_whyUS == sectionStr{
            print(sectionStr)
            self.tagV.tagVC = 5
            gotoWKWebView()
            
        }
        
        else if nv_blogs == sectionStr{
            print(sectionStr)
            self.tagV.tagVC = 6
            gotoWKWebView()
         
        }
        
        else if nv_mediaGalley == sectionStr{
            print(sectionStr)
            self.tagV.tagVC = 7
            gotoWKWebView()
           
        }
        
        else if nv_support == sectionStr{
            print(sectionStr)
            self.tagV.tagVC = 8
            gotoWKWebView()
            
        }
        
        else if nv_termCondition == sectionStr{
            print(sectionStr)
            self.tagV.tagVC = 9
            gotoWKWebView()
            
        }
        
        else if nv_privacyPolicy == sectionStr{
            print(sectionStr)
            self.tagV.tagVC = 10
            gotoWKWebView()
            
        }
        
        else if nv_priceCalc == sectionStr{
            
            self.navigationManager(storybordName: "DXECalc", storyboardID: "CalcDashboardVC", controller: CalcDashboardVC())
            
        }
        
        else if nv_rateUS == sectionStr{
            print(sectionStr)
            self.tagV.tagVC = 11
            gotoWKWebView()
        }
        
        else if nv_emial == sectionStr{
            print(sectionStr)
            let email = sectionStr
                   if let emailURL = URL(string: "mailto:\(email)") {
                       if UIApplication.shared.canOpenURL(emailURL) {
                           UIApplication.shared.open(emailURL, options: [:], completionHandler: nil)
                       } else {
                           // Handle the error
                           print("Cannot open email client")
                       }
                   }
        }
        
        else if nv_whatsapp == sectionStr{
            print(sectionStr)
            let phoneNumber = sectionStr
                   if let phoneURL = URL(string: "tel://\(phoneNumber)") {
                       if UIApplication.shared.canOpenURL(phoneURL) {
                           UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
                       } else {
                           // Handle the error
                           print("Cannot open phone dialer")
                       }
                   }
        }
        
        else if nv_logout == sectionStr{
            print("logout:", sectionStr)
            
            let loginData = UserDefaultManager().retrieveLoginData()
            if let authToken = loginData?.details?.authToken{
                self.showLogoutConfirmationAlert()
            }
           
        }
        
        else if nv_logIN == sectionStr{
            self.navigationManager(storybordName: "Login", storyboardID: "LoginVC", controller: LoginVC())
        }
       
        
        
    }
    
    func gotoWKWebView(){
        self.navigationManager(WKWebViewVC.self, storyboardName: "Dashboard", storyboardID: "WKWebViewVC", data: self.tagV)
    }
    
    
    // goto outher vc manage bottom button color
    func manageBottomTag(){
        self.btnHome.tintColor = .clrGray
        self.btnCategory.tintColor = .clrGray
        self.btnWish.tintColor = .clrGray
        self.btnCart.tintColor = .clrGray
        self.btnLogin.tintColor = .clrGray
        self.btnTitleHome.setTitleColor(UIColor.clrGray, for: .normal)
        self.btnTitleCategory.setTitleColor(UIColor.clrGray, for: .normal)
        self.btnTitleWish.setTitleColor(UIColor.clrGray, for: .normal)
        self.btnTitleCart.setTitleColor(UIColor.clrGray, for: .normal)
        self.btnTitleLogin.setTitleColor(UIColor.clrGray, for: .normal)
    }
    
    
    func gotoSearchDiamondVC(title:String){
        self.lblTitle.text = title
        let identifier = viewControllerIdentifiers[5]
        let storyboardName = storyboardNames[5]
        loadViewController(withIdentifier: identifier, fromStoryboard: storyboardName)
        hideMenu()
        menu = false
        self.sideMenuBtnTag = 1
        self.btnSideMenu.setImage(UIImage(named: "backButton"), for: .normal)
        
        self.lblTitle.isHidden = false
        self.imgLOGO.isHidden = true
        self.stackIcons.isHidden = true
        
        manageBottomTag()
    }
    
    func gotoSearchResultB2BVC(title:String){
        self.lblTitle.text = title
        let identifier = viewControllerIdentifiers[6]
        let storyboardName = storyboardNames[6]
        loadViewController(withIdentifier: identifier, fromStoryboard: storyboardName)
        hideMenu()
        menu = false
        self.sideMenuBtnTag = 1
        self.btnSideMenu.setImage(UIImage(named: "backButton"), for: .normal)
        
        self.lblTitle.isHidden = false
        self.imgLOGO.isHidden = true
        self.stackIcons.isHidden = true
        
        manageBottomTag()
    }
    
//    func gotoSearchResultB2BVC(title:String){
//        self.lblTitle.text = title
//        let identifier = viewControllerIdentifiers[6]
//        let storyboardName = storyboardNames[6]
//        loadViewController(withIdentifier: identifier, fromStoryboard: storyboardName)
//        hideMenu()
//        menu = false
//        self.sideMenuBtnTag = 1
//        self.btnSideMenu.setImage(UIImage(named: "backButton"), for: .normal)
//        
//        self.lblTitle.isHidden = false
//        self.imgLOGO.isHidden = true
//        self.stackIcons.isHidden = true
//        
//        manageBottomTag()
//    }
    
     func showLogoutConfirmationAlert() {
           let alert = UIAlertController(title: "Confirmation", message: "Are you sure you want to logout?", preferredStyle: .alert)
           
           // Add the cancel action
           let cancelAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
           alert.addAction(cancelAction)
           
           // Add the logout action
           let logoutAction = UIAlertAction(title: "Yes", style: .destructive) { _ in
               // Perform logout logic here
               self.callAPILogout()
           }
           alert.addAction(logoutAction)
           
           present(alert, animated: true, completion: nil)
       }
       
     
    func callAPILogout(){
        CustomActivityIndicator2.shared.show(in: self.view, gifName: "diamond_logo", topMargin: 300)
        HomeDataModel().logoutUser(completion: { data, msg in
            if data.status == 1{
                self.toastMessage(data.msg ?? "")
                UserDefaultManager.shareInstence.clearLoginDataDefaults()
                self.btnTitleLogin.setTitle("Login", for: .normal)
                self.lblWelcomeUser.text = "Welcome User"
                self.lblType.text = "--"
                self.sections = self.loadSections()
                if self.menu == true {
                    self.hideMenu()
                    self.menu = false
                }
                self.menuTableView.reloadData()
            }
            else{
                self.toastMessage(data.msg ?? "")
            }
            CustomActivityIndicator2.shared.hide()
        })
    }
    
}
