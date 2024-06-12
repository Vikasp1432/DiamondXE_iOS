//
//  HomeVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 16/05/24.
//

import UIKit

class HomeVC: BaseViewController, ChildViewControllerProtocol {
    func didSendString(str: String) {
        print(str)
    }

    @IBOutlet var homeTableView : UITableView!
    let refreshControl = UIRefreshControl()

    
    var homeDataStruct = HomeDataStruct()
    var topDealsStruct = TopDealsDataStruct()
    var topDealsTag = 0
    var dashBoardVC =  DashboardVC()
    var delegate : BaseViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = .red

        // define uitableview cell
        homeTableView.register(UINib(nibName: HomeVC_CateogiesTVC.cellIdentifierHomeTVC, bundle: nil), forCellReuseIdentifier: HomeVC_CateogiesTVC.cellIdentifierHomeTVC)
        homeTableView.register(UINib(nibName: BannerTVC.cellIdentifierBannerTVC, bundle: nil), forCellReuseIdentifier: BannerTVC.cellIdentifierBannerTVC)
        homeTableView.register(UINib(nibName: GiftOfChoiceTVC.cellIdentifierGiftChoiceTVC, bundle: nil), forCellReuseIdentifier: GiftOfChoiceTVC.cellIdentifierGiftChoiceTVC)
        homeTableView.register(UINib(nibName: NewArrivalsTVC.cellIdentifierNewArrTVC, bundle: nil), forCellReuseIdentifier: NewArrivalsTVC.cellIdentifierNewArrTVC)
        homeTableView.register(UINib(nibName: TopDealsTVC.cellIdentifierTopDealsTVC, bundle: nil), forCellReuseIdentifier: TopDealsTVC.cellIdentifierTopDealsTVC)
        homeTableView.register(UINib(nibName: DealerRegisterTVC.cellIdentifierDealerReg, bundle: nil), forCellReuseIdentifier: DealerRegisterTVC.cellIdentifierDealerReg)
        homeTableView.register(UINib(nibName: DXELUXeTVC.cellIdentifierDXELuxe, bundle: nil), forCellReuseIdentifier: DXELUXeTVC.cellIdentifierDXELuxe)
        homeTableView.register(UINib(nibName: PromisesDXETVC.cellIdentifierDXEPromises, bundle: nil), forCellReuseIdentifier: PromisesDXETVC.cellIdentifierDXEPromises)
        homeTableView.register(UINib(nibName: MediaSpotlightTVCl.cellIdentifierMediaSpotlight, bundle: nil), forCellReuseIdentifier: MediaSpotlightTVCl.cellIdentifierMediaSpotlight)
        
        homeTableView.register(UINib(nibName: CustomerReviewTVC.cellIdentifierCustomerView, bundle: nil), forCellReuseIdentifier: CustomerReviewTVC.cellIdentifierCustomerView)
        
        homeTableView.showsHorizontalScrollIndicator = false
        homeTableView.showsVerticalScrollIndicator = false
        
        // get homeDAta
        if let retrievedHomeData = UserDefaultManager.shareInstence.retrieveHomeData() {
            self.homeDataStruct = retrievedHomeData
            //self.uploadData()
            
            if let retrievedTopDeaLS = UserDefaultManager.shareInstence.retrieveTopDeals() {
                self.topDealsStruct = retrievedTopDeaLS
                self.homeTableView.reloadSections(IndexSet(integer: 4), with: .none)
            }
            else{
                CustomActivityIndicator2.shared.show(in: self.view, gifName: "diamond_logo", topMargin: 280)
                self.getTopDealsAPICalling()
            }
            
        }
        else{
            self.getHomeDataAPICalling()
        }
        
        
        
        //
        self.configureRefreshControl()
    }
    
    
    // pull to refresh
    func configureRefreshControl() {
            // Add the refresh control to your table view
            homeTableView.refreshControl = refreshControl
            
            //refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
            refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        }

    @objc private func refreshData(_ sender: Any) {
        // Refresh your data here
        self.getHomeDataPulltoRefresh()
    }

    // API Calling()
    func getHomeDataAPICalling(){
        CustomActivityIndicator2.shared.show(in: self.view, gifName: "diamond_logo", topMargin: 300)

        let url = APIs().get_HomeContent_API
        HomeDataModel().getHomeData(url: url, completion: { homeData , message in
           // print(homeData)
            if homeData.status == 1{
                self.homeDataStruct = homeData
                UserDefaultManager.shareInstence.saveHomeData(homeObj: self.homeDataStruct)
                self.uploadData()
     
            }
            
            else{
                self.toastMessage(message ?? "")
            }
            self.getTopDealsAPICalling()

        })
        
    }
    
    
    func getTopDealsAPICalling(){
  
        let url = APIs().get_topDeals_API
        HomeDataModel().getTopDealsData(url: url, completion: { topdeals , message in
           // print(homeData)
            if topdeals.status == 1{
                self.topDealsStruct = topdeals
                UserDefaultManager.shareInstence.saveTopDeals(topDelsObj: self.topDealsStruct)
                self.homeTableView.reloadSections(IndexSet(integer: 4), with: .none)
                
            }
            
            else{
                //print(message)
                self.toastMessage(message ?? "")
            }
         //   DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                CustomActivityIndicator2.shared.hide()
            //}
        })
        
    }
    
    
    
    func getHomeDataPulltoRefresh(){
        let url = APIs().get_HomeContent_API
        HomeDataModel().getHomeData(url: url, completion: { homeData , message in
            if homeData.status == 1{
                self.homeDataStruct = homeData
                UserDefaultManager.shareInstence.saveHomeData(homeObj: self.homeDataStruct)
                self.uploadData()
      
            }
            
            else{
                //print(message)
                self.toastMessage(message ?? "")
            }
            self.getTopDealsPulltoRefresh()

        })
        
    }
    
    func getTopDealsPulltoRefresh(){
        let url = APIs().get_topDeals_API
        HomeDataModel().getTopDealsData(url: url, completion: { topdeals , message in
           // print(homeData)
            if topdeals.status == 1{
                self.topDealsStruct = topdeals
                UserDefaultManager.shareInstence.saveTopDeals(topDelsObj: self.topDealsStruct)
                self.homeTableView.reloadSections(IndexSet(integer: 4), with: .none)
            }
            else{
                //print(message)
                self.toastMessage(message ?? "")
            }
            self.refreshControl.endRefreshing()

        })
        
    }
    
    
    func uploadData(){
        
        let indexPathToUpdate = IndexPath(row: 0, section: 9)
        if let cell9 = self.homeTableView.cellForRow(at: indexPathToUpdate) as? CustomerReviewTVC {
            if let customerStories = self.homeDataStruct.details?.customerStories{
                cell9.customerStories = customerStories
            }
        }
        
        
        
        let indexPathToMediaSpot = IndexPath(row: 0, section: 8)
        if let cell8 = self.homeTableView.cellForRow(at: indexPathToMediaSpot) as? MediaSpotlightTVCl{
            let placeholderImage = UIImage(named: "placeholder")
            
            let imageUrlString1 = self.homeDataStruct.details?.media?.content?[0].image ?? ""
            cell8.lblDesc1.text = self.homeDataStruct.details?.media?.content?[0].description ?? ""
            if let imageUrl = URL(string: imageUrlString1) {
                cell8.imgMedia1.setImage(from: imageUrl, placeholder: placeholderImage, timeoutInterval: 5.0)
            } else {
                cell8.imgMedia1.image = placeholderImage
            }
            
            let imageUrlString2 = self.homeDataStruct.details?.media?.content?[1].image ?? ""
            cell8.lblDesc2.text = self.homeDataStruct.details?.media?.content?[1].description ?? ""
            if let imageUrl = URL(string: imageUrlString2) {
                cell8.imgMedia2.setImage(from: imageUrl, placeholder: placeholderImage, timeoutInterval: 5.0)
            } else {
                cell8.imgMedia2.image = placeholderImage
            }
            
            let imageUrlString3 = self.homeDataStruct.details?.media?.content?[2].image ?? ""
            cell8.lblDesc3.text = self.homeDataStruct.details?.media?.content?[2].description ?? ""
            if let imageUrl = URL(string: imageUrlString3) {
                cell8.imgMedia3.setImage(from: imageUrl, placeholder: placeholderImage, timeoutInterval: 5.0)
            } else {
                cell8.imgMedia3.image = placeholderImage
            }
        }
        self.homeTableView.reloadData()
    }
    
    
    
}
extension HomeVC : CategorySelecteDelegate {
    func categoryViewTapped(in cellCategoryTag: Int) {
        print(cellCategoryTag)
//        dashBoardVC.gotoSearchDiamondVC()
        delegate?.didPerformAction(tag: cellCategoryTag)

    }
    
    
}


extension HomeVC : UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: HomeVC_CateogiesTVC.cellIdentifierHomeTVC, for: indexPath) as! HomeVC_CateogiesTVC
            cell.selectionStyle = .none
            cell.delegate = self
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: BannerTVC.cellIdentifierBannerTVC, for: indexPath) as! BannerTVC
            if let baner =  homeDataStruct.details?.banners{
                cell.banners = baner
                cell.sliderCollectionView.reloadData()

            }
            cell.selectionStyle = .none
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: GiftOfChoiceTVC.cellIdentifierGiftChoiceTVC, for: indexPath) as! GiftOfChoiceTVC
            cell.selectionStyle = .none
            cell.lblTitle.text = self.homeDataStruct.details?.middleBanners?.title
            if let middleBanr = self.homeDataStruct.details?.middleBanners?.content{
                cell.giftImg1.sd_setImage(with: URL(string: middleBanr[0].image ?? ""), completed: nil)
                cell.giftImg2.sd_setImage(with: URL(string: middleBanr[1].image ?? ""), completed: nil)
                cell.giftImg3.sd_setImage(with: URL(string: middleBanr[2].image ?? ""), completed: nil)
                cell.giftImg4.sd_setImage(with: URL(string: middleBanr[3].image ?? ""), completed: nil)
            }
            return cell
            
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: NewArrivalsTVC.cellIdentifierNewArrTVC, for: indexPath) as! NewArrivalsTVC
            cell.selectionStyle = .none
            cell.lblTitle.text = self.homeDataStruct.details?.features?.title
            if let middleBanr = self.homeDataStruct.details?.features?.content{
                cell.newArrImg1.sd_setImage(with: URL(string: middleBanr[0].image ?? ""), completed: nil)
                cell.newArrImg2.sd_setImage(with: URL(string: middleBanr[1].image ?? ""), completed: nil)
               
            }
            return cell
            
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: TopDealsTVC.cellIdentifierTopDealsTVC, for: indexPath) as! TopDealsTVC
            cell.selectionStyle = .none
            if self.topDealsTag == 0{
                if let topDeals = self.topDealsStruct.details?.natural{
                    cell.naturalDia = topDeals
                    cell.labGlDia = [LabGDiamond]()
                    cell.collectionViewTopDeL.reloadData()
                }
            }
            else{
                if let topDeals = self.topDealsStruct.details?.labGrown{
                    cell.naturalDia = [NaturalDiamond]()
                    cell.labGlDia = topDeals
                    cell.collectionViewTopDeL.reloadData()
                }
            }
            
            cell.buttonPressed = { tag in
                self.topDealsTag = tag
                if tag == 1 {
                    if let topDeals = self.topDealsStruct.details?.labGrown{
                        cell.labGlDia = topDeals
                        cell.naturalDia = [NaturalDiamond]()
                        cell.collectionViewTopDeL.reloadData()
                    }
                }
                else{
                    if let topDeals = self.topDealsStruct.details?.natural{
                        cell.naturalDia = topDeals
                        cell.labGlDia = [LabGDiamond]()
                        cell.collectionViewTopDeL.reloadData()
                    }
                }
            }
            return cell
            
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: DealerRegisterTVC.cellIdentifierDealerReg, for: indexPath) as! DealerRegisterTVC
            
            let imageUrlString = self.homeDataStruct.details?.registerNow?.content?.image ?? ""
            let placeholderImage = UIImage(named: "Middle Banner1")
            
            if let imageUrl = URL(string: imageUrlString) {
                cell.imgRegisterNow.setImage(from: imageUrl, placeholder: placeholderImage, timeoutInterval: 5.0)
            } else {
                cell.imgRegisterNow.image = placeholderImage
            }
            
           
            cell.selectionStyle = .none
            return cell
            
        case 6:
            let cell = tableView.dequeueReusableCell(withIdentifier: DXELUXeTVC.cellIdentifierDXELuxe, for: indexPath) as! DXELUXeTVC
            
            let imageUrlString = self.homeDataStruct.details?.dxeLuxe?.content?.image ?? ""
            let placeholderImage = UIImage(named: "Middle Banner2")
            
            if let imageUrl = URL(string: imageUrlString) {
                cell.imgDXELuxe.setImage(from: imageUrl, placeholder: placeholderImage, timeoutInterval: 5.0)
            } else {
                cell.imgDXELuxe.image = placeholderImage
            }
            
            
            cell.selectionStyle = .none
            return cell
            
        case 7:
            let cell = tableView.dequeueReusableCell(withIdentifier: PromisesDXETVC.cellIdentifierDXEPromises, for: indexPath) as! PromisesDXETVC
            cell.selectionStyle = .none
            return cell
            
        case 8:
            let cell = tableView.dequeueReusableCell(withIdentifier: MediaSpotlightTVCl.cellIdentifierMediaSpotlight, for: indexPath) as! MediaSpotlightTVCl
            cell.selectionStyle = .none
            let placeholderImage = UIImage(named: "placeholder")
            
            let imageUrlString1 = self.homeDataStruct.details?.media?.content?[0].image ?? ""
            cell.lblDesc1.text = self.homeDataStruct.details?.media?.content?[0].description ?? ""
            if let imageUrl = URL(string: imageUrlString1) {
                cell.imgMedia1.setImage(from: imageUrl, placeholder: placeholderImage, timeoutInterval: 5.0)
            } else {
                cell.imgMedia1.image = placeholderImage
            }
            
            let imageUrlString2 = self.homeDataStruct.details?.media?.content?[1].image ?? ""
            cell.lblDesc2.text = self.homeDataStruct.details?.media?.content?[1].description ?? ""
            if let imageUrl = URL(string: imageUrlString2) {
                cell.imgMedia2.setImage(from: imageUrl, placeholder: placeholderImage, timeoutInterval: 5.0)
            } else {
                cell.imgMedia2.image = placeholderImage
            }
            
            let imageUrlString3 = self.homeDataStruct.details?.media?.content?[2].image ?? ""
            cell.lblDesc3.text = self.homeDataStruct.details?.media?.content?[2].description ?? ""
            if let imageUrl = URL(string: imageUrlString3) {
                cell.imgMedia3.setImage(from: imageUrl, placeholder: placeholderImage, timeoutInterval: 5.0)
            } else {
                cell.imgMedia3.image = placeholderImage
            }
            
            return cell
            
        case 9:
            let cell = tableView.dequeueReusableCell(withIdentifier: CustomerReviewTVC.cellIdentifierCustomerView, for: indexPath) as! CustomerReviewTVC
            cell.selectionStyle = .none
            if let customerView = self.homeDataStruct.details?.customerStories{
                cell.customerStories = customerView
                //cell.collectionCustomerView.reloadData()
            }
            
            return cell
            
        default:
            return UITableViewCell()
        }
        
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 175
            
        case 1:
            return 320
            
        case 2:
            return 480
            
        case 3:
            return 270
        case 4:
            return 310
            
        case 5:
            return 170
            
        case 6:
            return 200
            
        case 7:
            return 620
        case 8:
            return 870
        case 9:
            return 400
            
        default:
            return 0
        }
    }
  
    
    
}
