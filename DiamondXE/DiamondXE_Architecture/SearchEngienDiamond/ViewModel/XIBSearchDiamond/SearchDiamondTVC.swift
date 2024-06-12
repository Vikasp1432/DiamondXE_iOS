//
//  SearchDiamondTVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 31/05/24.
//

import UIKit

class SearchDiamondTVC: UITableViewCell {

    static let cellIdentifierSearchDiamondTVC = String(describing: SearchDiamondTVC.self)

    @IBOutlet var collectionShap:UICollectionView!
    @IBOutlet var btnBest:UIButton!
    @IBOutlet var btnMedium:UIButton!
    @IBOutlet var btnLow:UIButton!
    @IBOutlet var btnNaturalDia:UIButton!
    @IBOutlet var btnLabGrownDia:UIButton!
    @IBOutlet var btnAdvanceFilter:UIButton!
    @IBOutlet var viewBGFilter:UIView!
    
    @IBOutlet var btnClorWhite:UIButton!
    @IBOutlet var btnClorFancy:UIButton!
    
    @IBOutlet var btnYes:UIButton!
    @IBOutlet var btnNo:UIButton!

    
    @IBOutlet var collectionColors:UICollectionView!
    @IBOutlet var collectionClarity:UICollectionView!
    @IBOutlet var collectionCertificate:UICollectionView!
    @IBOutlet var collectionFluorescence:UICollectionView!
    @IBOutlet var collectionMake:UICollectionView!
    
    @IBOutlet var viewNatBG:UIView!
    @IBOutlet var viewLabBG:UIView!
    
    
    var imgArr = [ UIImage(named:"all"),
                    UIImage(named:"round") ,
                    UIImage(named:"princess_") ,
                    UIImage(named:"emrald") ,
                    UIImage(named:"heart_") ,
                    UIImage(named:"radiant"),
                   UIImage(named:"oval"),
                   UIImage(named:"pear"),
                   UIImage(named:"marquise"),
                   UIImage(named:"asscher")]
 
    var selectedIndicesShaps: Set<IndexPath> = []
    var selectedIndicesColor: Set<IndexPath> = []
    var selectedIndicesClarity: Set<IndexPath> = []
    var selectedIndicesCertificate: Set<IndexPath> = []
    var selectedIndicesFluorescence: Set<IndexPath> = []
    var selectedIndicesMake: Set<IndexPath> = []
    
    var dataArrColorWhite : [SearchAttribDetail]?
    var dataArrColorFancy : [SearchAttribDetail]?
    var dataArrClarity: [SearchAttribDetail]?
    var dataArrCertificate: [SearchAttribDetail]?
    var dataArrFluorescence: [SearchAttribDetail]?
    var dataArrMake: [SearchAttribDetail]?
    
    var btnActionAdvanceFilter : ((Int) -> Void) = {_ in }

    
   // var searchAttributeStruct = SearchOptionDataStruct()
    var colorDiaWhiteShow = true


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
     
        collectionShap.register(UINib(nibName: SearchDiamondCVC.cellIdentifierShapeDiamondCVC, bundle: nil), forCellWithReuseIdentifier: SearchDiamondCVC.cellIdentifierShapeDiamondCVC)
        
        collectionColors.register(UINib(nibName: SearchesOptionCVC.cellIdentifierSearchOptionCVC, bundle: nil), forCellWithReuseIdentifier: SearchesOptionCVC.cellIdentifierSearchOptionCVC)
        
        collectionClarity.register(UINib(nibName: SearchesOptionCVC.cellIdentifierSearchOptionCVC, bundle: nil), forCellWithReuseIdentifier: SearchesOptionCVC.cellIdentifierSearchOptionCVC)
        
        collectionCertificate.register(UINib(nibName: SearchesOptionCVC.cellIdentifierSearchOptionCVC, bundle: nil), forCellWithReuseIdentifier: SearchesOptionCVC.cellIdentifierSearchOptionCVC)
        
        collectionFluorescence.register(UINib(nibName: SearchesOptionCVC.cellIdentifierSearchOptionCVC, bundle: nil), forCellWithReuseIdentifier: SearchesOptionCVC.cellIdentifierSearchOptionCVC)
        
        collectionMake.register(UINib(nibName: SearchesOptionCVC.cellIdentifierSearchOptionCVC, bundle: nil), forCellWithReuseIdentifier: SearchesOptionCVC.cellIdentifierSearchOptionCVC)
      
        configureCollectionView(collectionShap)
        configureCollectionView(collectionColors)
        configureCollectionView(collectionClarity)
        configureCollectionView(collectionCertificate)
        configureCollectionView(collectionFluorescence)
        configureCollectionView(collectionMake)
        

        
        // filter datya
//        self.filterDataStruct()

    }
    
    
    func filterDataStruct(searchAttributeStruct:SearchOptionDataStruct){
        
        searchAttributeStruct.details?.forEach { attributeData in
            
            if attributeData.attribType == attributeTypeWhite{
                self.dataArrColorWhite = attributeData.attribDetails
                self.collectionColors.reloadData()
            }
            
            if attributeData.attribType == attributeTypeFancy{
                self.dataArrColorFancy = attributeData.attribDetails
                self.collectionColors.reloadData()
            }
            
            if attributeData.attribType == attributeTypeClarity{
                self.dataArrClarity = attributeData.attribDetails
                self.collectionClarity.reloadData()
            }
            
            if attributeData.attribType == attributeTypeCertificate{
                self.dataArrCertificate = attributeData.attribDetails
                self.collectionCertificate.reloadData()
            }
            
            if attributeData.attribType == attributeTypeFluorescence{
                self.dataArrFluorescence = attributeData.attribDetails
                self.collectionFluorescence.reloadData()
            }
            
            if attributeData.attribType == attributeTypeMake{
                self.dataArrMake = attributeData.attribDetails
                self.collectionMake.reloadData()
            }
            
        }
        
    }
    
    
    func configureCollectionView(_ collectionView: UICollectionView) {
           collectionView.showsHorizontalScrollIndicator = false
           collectionView.showsVerticalScrollIndicator = false
           collectionView.allowsMultipleSelection = true
           collectionView.delegate = self
           collectionView.dataSource = self

           
            self.btnBest.setGradientLayer(colorsInOrder:  [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
            self.btnBest.setTitleColor(.whitClr, for: .normal)
            self.viewBGFilter.setGradientLayerView(colorsInOrder:  [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
        
        
       }
    
    func setGradientBtn(string:String){
        if string == "Lab Grown Diamonds"{
            self.btnLabGrownDia.setGradientLayer(colorsInOrder:  [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
            self.btnLabGrownDia.setTitleColor(.whitClr, for: .normal)
            self.btnNaturalDia.clearGradient()
            self.btnNaturalDia.setTitleColor(.themeClr, for: .normal)
        }
        else{
            self.btnNaturalDia.setGradientLayer(colorsInOrder:  [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
            self.btnNaturalDia.setTitleColor(.whitClr, for: .normal)
            self.btnLabGrownDia.clearGradient()
            self.btnLabGrownDia.setTitleColor(.themeClr, for: .normal)
        }
        
    }
    
   
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnActionBestMediumLow(_ sender:UIButton){

        if sender.tag == 0{
          
            btnBest.setGradientLayer(colorsInOrder:  [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
            btnBest.setTitleColor(.whitClr, for: .normal)
            btnMedium.clearGradient()
            btnMedium.setTitleColor(.themeClr, for: .normal)
            btnLow.clearGradient()
            btnLow.setTitleColor(.themeClr, for: .normal)
            
        }
        else if sender.tag == 1{
            btnMedium.setGradientLayer(colorsInOrder:  [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
            btnMedium.setTitleColor(.whitClr, for: .normal)
            btnBest.clearGradient()
            btnBest.setTitleColor(.themeClr, for: .normal)
            btnLow.clearGradient()
            btnLow.setTitleColor(.themeClr, for: .normal)
        }
        else {
           
            btnLow.setGradientLayer(colorsInOrder:  [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
            btnLow.setTitleColor(.whitClr, for: .normal)
            btnMedium.clearGradient()
            btnMedium.setTitleColor(.themeClr, for: .normal)
            btnBest.clearGradient()
            btnBest.setTitleColor(.themeClr, for: .normal)
        }
        
    }
    
    @IBAction func btnActionNaturalLabD(_ sender:UIButton){

        if sender.tag == 0{
            btnNaturalDia.setGradientLayer(colorsInOrder:  [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
            btnNaturalDia.setTitleColor(.whitClr, for: .normal)
            btnLabGrownDia.clearGradient()
            btnLabGrownDia.setTitleColor(.themeClr, for: .normal)
        }
        else{
            btnLabGrownDia.setGradientLayer(colorsInOrder:  [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
//            viewLabBG.setGradientLayerView(colorsInOrder:  [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
            btnLabGrownDia.setTitleColor(.whitClr, for: .normal)
            btnNaturalDia.clearGradient()
            btnNaturalDia.setTitleColor(.themeClr, for: .normal)

        }
        
    }
    
    @IBAction func btnActionYES_No(_ sender:UIButton){

        if sender.tag == 0{
            btnYes.setGradientLayer(colorsInOrder:  [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
            btnYes.setTitleColor(.whitClr, for: .normal)
            btnNo.clearGradient()
            btnNo.setTitleColor(.themeClr, for: .normal)
        }
        else{
            btnNo.setGradientLayer(colorsInOrder:  [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
            btnNo.setTitleColor(.whitClr, for: .normal)
            btnYes.clearGradient()
            btnYes.setTitleColor(.themeClr, for: .normal)

        }
        
    }
    
    
    
    
    @IBAction func btnActioColor(_ sender:UIButton){
        if sender.tag == 0{
            colorDiaWhiteShow = true
            self.btnClorWhite.setImage(UIImage(named: "radioButtonSelected"), for: .normal)
            self.btnClorFancy.setImage(UIImage(named: "radioButtonDeselected"), for: .normal)

            
        }
        else{
            colorDiaWhiteShow = false
            self.btnClorWhite.setImage(UIImage(named: "radioButtonDeselected"), for: .normal)
            self.btnClorFancy.setImage(UIImage(named: "radioButtonSelected"), for: .normal)
        }
        self.collectionColors.reloadData()
    }
    
    @IBAction func btnActioAdvanceFilter(_ sender:UIButton){
        self.btnActionAdvanceFilter(sender.tag)
    }
    
}


extension SearchDiamondTVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        switch collectionView {
        case self.collectionShap:
            return imgArr.count
        case self.collectionColors:
            if self.colorDiaWhiteShow{
                return self.dataArrColorWhite?.count ?? 0
            }
            else{
                return self.dataArrColorFancy?.count ?? 0
            }
            
//            return 10
        case self.collectionClarity:
            return self.dataArrClarity?.count ?? 0
            
        case self.collectionCertificate:
            return self.dataArrCertificate?.count ?? 0
            
        case self.collectionFluorescence:
            return self.dataArrFluorescence?.count ?? 0
            
        case self.collectionMake:
            return self.dataArrMake?.count ?? 0
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        
        switch collectionView {
        case self.collectionShap:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchDiamondCVC.cellIdentifierShapeDiamondCVC, for: indexPath) as! SearchDiamondCVC
            cell.lblCateIMG.image = imgArr[indexPath.row]
            cell.delegate = self
            cell.isShadowApplied = selectedIndicesShaps.contains(indexPath)
            return cell
        case self.collectionColors:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchesOptionCVC.cellIdentifierSearchOptionCVC, for: indexPath) as! SearchesOptionCVC
            cell.delegate = self
            cell.isGradientApplied = selectedIndicesColor.contains(indexPath)
            
            if self.colorDiaWhiteShow{
                cell.btnTitle.setTitle(self.dataArrColorWhite?[indexPath.row].attribCode, for: .normal)
            }
            else{
                cell.btnTitle.setTitle(self.dataArrColorFancy?[indexPath.row].attribCode, for: .normal)
            }

            return cell
            
      
        case self.collectionClarity:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchesOptionCVC.cellIdentifierSearchOptionCVC, for: indexPath) as! SearchesOptionCVC
            cell.delegate = self
            cell.isGradientApplied = selectedIndicesClarity.contains(indexPath)

            cell.btnTitle.setTitle(self.dataArrClarity?[indexPath.row].attribCode, for: .normal)
            return cell
            
        case self.collectionCertificate:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchesOptionCVC.cellIdentifierSearchOptionCVC, for: indexPath) as! SearchesOptionCVC
            cell.delegate = self
            cell.isGradientApplied = selectedIndicesCertificate.contains(indexPath)
            cell.btnTitle.setTitle(self.dataArrCertificate?[indexPath.row].attribCode, for: .normal)
            return cell
            
        case self.collectionFluorescence:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchesOptionCVC.cellIdentifierSearchOptionCVC, for: indexPath) as! SearchesOptionCVC
            cell.delegate = self
            cell.isGradientApplied = selectedIndicesFluorescence.contains(indexPath)
            cell.btnTitle.setTitle(self.dataArrFluorescence?[indexPath.row].displayAttr, for: .normal)
            return cell
            
        case self.collectionMake:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchesOptionCVC.cellIdentifierSearchOptionCVC, for: indexPath) as! SearchesOptionCVC
            cell.delegate = self
            cell.isGradientApplied = selectedIndicesMake.contains(indexPath)
            cell.btnTitle.setTitle(self.dataArrMake?[indexPath.row].attribCode, for: .normal)
            return cell
            
        default:
           
            return UICollectionViewCell()
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch collectionView {
        case self.collectionShap:
            let noOfCellsInRow = 4  //number of column you want
            let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
            let totalSpace = flowLayout.sectionInset.left
                + flowLayout.sectionInset.right
                + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

            let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
            return CGSize(width: size + 24  , height: size + 35)
        case self.collectionColors:
            if self.colorDiaWhiteShow{
                let noOfCellsInRow = 6 //number of column you want
                let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
                let totalSpace = flowLayout.sectionInset.left
                + flowLayout.sectionInset.right
                + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
                
                let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
                return CGSize(width: size  , height: size - 18)
            }
            else{
                
                    let noOfCellsInRow = 6 //number of column you want
                    let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
                    let totalSpace = flowLayout.sectionInset.left
                    + flowLayout.sectionInset.right
                    + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
                    
                    let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
                    return CGSize(width: size + 28 , height: size - 18)
                
            }
            
        case self.collectionFluorescence:
            
            let noOfCellsInRow = 6 //number of column you want
            let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
            let totalSpace = flowLayout.sectionInset.left
                + flowLayout.sectionInset.right
                + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

            let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
            return CGSize(width: size + 25 , height: size - 18)
        default:
            let noOfCellsInRow = 6 //number of column you want
            let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
            let totalSpace = flowLayout.sectionInset.left
                + flowLayout.sectionInset.right
                + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

            let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
            return CGSize(width: size + 15 , height: size - 18)
        }

        
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        /*return 10*/ // Adjust the spacing between rows
//        
//        switch collectionView {
//        case self.collectionShap:
//            return 10
//            
//        default:
//            return 8
//        }
//    }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            switch collectionView {
            case self.collectionShap:
                return 13

            default:
                return 13
            }
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0) // Adjust the left padding
        }
    

   
}


extension SearchDiamondTVC: CustomCollectionViewCellDelegate, OptionsCollectionViewCellDelegate{
    func btnTappedCell(in cell: SearchesOptionCVC) {
        if let indexPath = collectionColors.indexPath(for: cell) {
            if selectedIndicesColor.contains(indexPath) {
                selectedIndicesColor.remove(indexPath)
                cell.isGradientApplied = false
            } else {
                selectedIndicesColor.insert(indexPath)
                cell.isGradientApplied = true
            }
        }
        
        if let indexPath = collectionClarity.indexPath(for: cell) {
            if selectedIndicesClarity.contains(indexPath) {
                selectedIndicesClarity.remove(indexPath)
                cell.isGradientApplied = false
            } else {
                selectedIndicesClarity.insert(indexPath)
                cell.isGradientApplied = true
            }
        }
        
        if let indexPath = collectionCertificate.indexPath(for: cell) {
            if selectedIndicesCertificate.contains(indexPath) {
                selectedIndicesCertificate.remove(indexPath)
                cell.isGradientApplied = false
            } else {
                selectedIndicesCertificate.insert(indexPath)
                cell.isGradientApplied = true
            }
        }
        
        if let indexPath = collectionFluorescence.indexPath(for: cell) {
            if selectedIndicesFluorescence.contains(indexPath) {
                selectedIndicesFluorescence.remove(indexPath)
                cell.isGradientApplied = false
            } else {
                selectedIndicesFluorescence.insert(indexPath)
                cell.isGradientApplied = true
            }
        }
        
        if let indexPath = collectionMake.indexPath(for: cell) {
            if selectedIndicesMake.contains(indexPath) {
                selectedIndicesMake.remove(indexPath)
                cell.isGradientApplied = false
            } else {
                selectedIndicesMake.insert(indexPath)
                cell.isGradientApplied = true
            }
        }
    }
    
    func imageViewTapped(in cell: SearchDiamondCVC) {
        if let indexPath = collectionShap.indexPath(for: cell) {
            if selectedIndicesShaps.contains(indexPath) {
                selectedIndicesShaps.remove(indexPath)
                cell.isShadowApplied = false
            } else {
                selectedIndicesShaps.insert(indexPath)
                cell.isShadowApplied = true
            }
        }
    }
}
