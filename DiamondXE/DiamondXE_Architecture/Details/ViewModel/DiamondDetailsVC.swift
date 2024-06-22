//
//  DiamondDetailsVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 20/06/24.
//

import UIKit

class DiamondDetailsVC: UIViewController, ChildViewControllerProtocol{
    var delegate: (any BaseViewControllerDelegate)?
    
    func didSendString(str: String) {
        print("ASE")
    }
    var isCellExpandedDetails = false
    
    @IBOutlet var tbleViewDetails:UITableView!
    
    var  diamondInfo = DiamondListingDetail()
    var  diamondDetails = DiamondDetailsStruct()
    var cut = "EX"
    var polish = "EX"
    var symmetry = "EX"
    var flouro = "EX"
    var certificate = "EX"
    var discount = String()
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // define uitableview cell
        tbleViewDetails.register(UINib(nibName: DiamondImagesTVC.cellIdentifierDiaDetailsTVC, bundle: nil), forCellReuseIdentifier: DiamondImagesTVC.cellIdentifierDiaDetailsTVC)
        tbleViewDetails.register(UINib(nibName: ProductDetailsTVC.cellIdentifierProductDetailsTVC, bundle: nil), forCellReuseIdentifier: ProductDetailsTVC.cellIdentifierProductDetailsTVC)
        tbleViewDetails.register(UINib(nibName: AllDiamondDetailsTVC.cellIdentifierAllDimdDetailsTVC, bundle: nil), forCellReuseIdentifier: AllDiamondDetailsTVC.cellIdentifierAllDimdDetailsTVC)
        tbleViewDetails.register(UINib(nibName: SimillarProductTVC.cellIdentifierSimmilarDiaTVC, bundle: nil), forCellReuseIdentifier: SimillarProductTVC.cellIdentifierSimmilarDiaTVC)
        
        tbleViewDetails.showsHorizontalScrollIndicator = false
        tbleViewDetails.showsVerticalScrollIndicator = false
        fetchDamondDetails()
       
    }
    
    
    func fetchDamondDetails() {
        
        CustomActivityIndicator2.shared.show(in: self.view, gifName: "diamond_logo", topMargin: 300)
        
        let url = APIs().get_DiamondDetails_API
        let param :[String:Any] = ["certificateNo":self.diamondInfo.certificateNo ?? ""]
      
        DiamondDetailsModel().getDiamondsDetails(url: url, requestParam: param, completion: { data, msg in
            
            if data.status == 1{
                self.diamondDetails = data
                print(self.diamondDetails)
                
                
                self.cut = self.diamondDetails.details?.cutGrade ?? ""
                self.polish = self.diamondDetails.details?.polish ?? ""
                self.symmetry = self.diamondDetails.details?.symmetry ?? ""
                self.flouro = self.diamondDetails.details?.fluorescenceColor ?? ""
                self.certificate  = self.diamondDetails.details?.certificateName ?? ""
                self.discount = "\(self.diamondDetails.details?.discountAmout ?? "")%"
                print(self.cut, self.polish, self.symmetry, self.certificate, self.flouro, self.discount)
                self.tbleViewDetails.reloadData()
            }
            else{
                self.toastMessage(msg ?? "")
                
            }
            CustomActivityIndicator2.shared.hide()
            
        })
        
      }

   
}

extension DiamondDetailsVC : UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: DiamondImagesTVC.cellIdentifierDiaDetailsTVC, for: indexPath) as! DiamondImagesTVC
            cell.selectionStyle = .none
            cell.lblTypeDia.text = self.diamondDetails.details?.growthType
            cell.imgDiamndView.sd_setImage(with: URL(string:  self.diamondDetails.details?.diamondImage ?? ""), placeholderImage: UIImage(named: "place_Holder"))
            cell.alertAction = { tag in
                let overLayerView = OverLayerView()
                if tag == 1{
                    overLayerView.appear(sender: self, tag: tag, url: self.diamondDetails.details?.diamondVideo ?? "")
                }
                if tag == 0{
                    overLayerView.appear(sender: self, tag: tag, url: self.diamondDetails.details?.diamondImage ?? "")
                }
            }
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: ProductDetailsTVC.cellIdentifierProductDetailsTVC, for: indexPath) as! ProductDetailsTVC
            cell.selectionStyle = .none
            cell.lblDocNumber.text = self.diamondDetails.details?.certificateNo ?? ""
            cell.lblLotID.text = "ID:\(self.diamondDetails.details?.supplierID ?? 0)"
            cell.lblShape.text = self.diamondDetails.details?.shape ?? ""
            cell.lblCarat.text = self.diamondDetails.details?.carat ?? ""
            cell.lblClr.text = self.diamondDetails.details?.color ?? ""
            cell.lblClarity.text = self.diamondDetails.details?.clarity ?? ""
            
            cell.lblPrice.text = "₹\(self.diamondDetails.details?.totalPrice ?? 0)"
            print(self.cut, self.polish, self.symmetry, self.certificate, self.flouro, self.discount)
            if !self.cut.isEmpty  {
                cell.lblCut.text = self.cut
            }
            else{
                cell.viewCut.isHidden = true
            }
            if !self.polish.isEmpty  {
                cell.lblPolish.text = self.polish
            }
            else{
                cell.viewPolish.isHidden = true
            }
            
            if !self.symmetry.isEmpty  {
                cell.lblSymmetry.text = self.symmetry
            }
            else{
                cell.viewSymmetry.isHidden = true
            }
            
            if !self.flouro.isEmpty  {
                cell.lblFlouro.text = self.flouro
            }
            else{
                cell.viewFlouro.isHidden = true
            }
            if !self.certificate.isEmpty  {
                cell.lblCertificate.text = certificate
            }
            else{
                cell.viewCertificate.isHidden = true
            }
           
            cell.lblDiscount.text = self.discount
            
            cell.alertAction = {
                let overLayerView = LocationPinView()
                overLayerView.pincodeDelagate = self
                overLayerView.indexPath = indexPath
                overLayerView.appear(sender: self, pincode: 0)
            }
            
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: AllDiamondDetailsTVC.cellIdentifierAllDimdDetailsTVC, for: indexPath) as! AllDiamondDetailsTVC
            cell.selectionStyle = .none
            if  self.diamondDetails.details?.measurement?.count ?? 0 > 0{
                cell.lblMasurment.text = self.diamondDetails.details?.measurement ?? ""
            }
            else{
                cell.lblMasurment.text =  "-"
            }
            
            if self.diamondDetails.details?.depth?.count ?? 0 > 0{
                cell.lblDepth.text = self.diamondDetails.details?.depth ?? ""
            }
            else{
                cell.lblDepth.text =  "-"
            }
            if self.diamondDetails.details?.tablePerc?.count ?? 0 > 0{
                cell.lblTable.text = "\(self.diamondDetails.details?.tablePerc ?? "")%"
            }
            else{
                cell.lblTable.text =  "-"
            }
            
    
            if self.diamondDetails.details?.crownHeight?.count ?? 0 > 0{
                cell.lblCrownHeight.text = self.diamondDetails.details?.crownHeight ?? ""
            }
            else{
                cell.lblCrownHeight.text =  "-"
            }
            
            if self.diamondDetails.details?.crownAngle?.count ?? 0 > 0{
                cell.lblCrownAngle.text = self.diamondDetails.details?.crownAngle ?? ""
            }
            else{
                cell.lblCrownAngle.text =  "-"
            }
            
            if  self.diamondDetails.details?.pavillionDepth?.count ?? 0 > 0 {
                cell.lblPalivionDepth.text = self.diamondDetails.details?.pavillionDepth ?? ""
            }
            else{
                cell.lblPalivionDepth.text =  "-"
            }
            
            if self.diamondDetails.details?.pavillionAngle?.count ?? 0 > 0{
                cell.lblPalivionAngle.text = self.diamondDetails.details?.pavillionAngle ?? ""
            }
            else{
                cell.lblPalivionAngle.text =  "-"
            }
            
            if self.diamondDetails.details?.shade?.count ?? 0 > 0{
                cell.lblShade.text = self.diamondDetails.details?.shade ?? ""
            }
            else{
                cell.lblShade.text =  "-"
            }
           
            if self.diamondDetails.details?.cutGrade?.count ?? 0 > 0{
                cell.lblGridCulet.text = self.diamondDetails.details?.cutGrade ?? ""
            }
            else{
                cell.lblGridCulet.text =  "-"
            }

            if self.diamondDetails.details?.growthType?.count ?? 0 > 0{
                cell.lblGrowthType.text = self.diamondDetails.details?.growthType ?? ""
            }
            else{
                cell.lblGrowthType.text =  "-"
            }
            
            if self.diamondDetails.details?.inscription?.count ?? 0 > 0{
                cell.lblInclusion.text = self.diamondDetails.details?.inscription ?? ""
            }
            else{
                cell.lblInclusion.text =  "-"
            }
            
            if self.diamondDetails.details?.location?.count ?? 0 > 0{
                cell.lblLocation.text = self.diamondDetails.details?.location ?? ""
            }
            else{
                cell.lblLocation.text =  "-"
            }
           
            cell.lblStatus.text =  "-"
            
            if self.diamondDetails.details?.keyToSymbols?.count ?? 0 > 0{
                cell.lblKeytoSymbole.text = self.diamondDetails.details?.keyToSymbols ?? ""
            }
            else{
                cell.lblKeytoSymbole.text = "-"
            }
            
            if self.diamondDetails.details?.currencyMarkup?.count ?? 0 > 0{
                cell.lblRemark.text = self.diamondDetails.details?.currencyMarkup ?? ""
            }
            else{
                cell.lblRemark.text = "-"
            }
            
            if self.diamondDetails.details?.reportComments?.count ?? 0 > 0{
                cell.lblReportComment.text = self.diamondDetails.details?.reportComments ?? ""
            }
            else{
                cell.lblReportComment.text = "-"
            }
            
          
            cell.buttonPressed = { tag in
                self.isCellExpandedDetails.toggle()
                cell.setupData(isExpand: self.isCellExpandedDetails)
                self.tbleViewDetails.reloadRows(at: [indexPath], with: .automatic)
               }
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: SimillarProductTVC.cellIdentifierSimmilarDiaTVC, for: indexPath) as! SimillarProductTVC
            cell.selectionStyle = .none
            return cell
            
        default:
            return UITableViewCell()
        }
     
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 2{
            return isCellExpandedDetails ? 680 : 70
        }
        if indexPath.section == 3{
            return 350
        }
        else{
            return UITableView.automaticDimension
        }
        
    }
}

extension DiamondDetailsVC : PinCodeDelegate{
    func didEnterPincode(pincode: String, indexPath: IndexPath) {
        if let cell = self.tbleViewDetails.cellForRow(at: indexPath) as? ProductDetailsTVC {
            cell.lblPincode.text = "Delivering to \(pincode)"
           
        }
    }
    
    
}
