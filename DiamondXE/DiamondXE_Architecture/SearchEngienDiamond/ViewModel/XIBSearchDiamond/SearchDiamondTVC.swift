//
//  SearchDiamondTVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 31/05/24.
//

import UIKit

class SearchDiamondTVC: UITableViewCell, UITextFieldDelegate {

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
    
    @IBOutlet var txtPriceFrom:UITextField!
    @IBOutlet var txtCaratFrom:UITextField!
    @IBOutlet var txtPriceTo:UITextField!
    @IBOutlet var txtCaratTo:UITextField!
    
    var delegate : SearchOptionSelecteDelegate?
    
    var searchAttributeStruct = SearchOptionDataStruct()
    
    
    var imgArr = [  UIImage(named:"all"),
                    UIImage(named:"round") ,
                    UIImage(named:"princess_") ,
                    UIImage(named:"emrald") ,
                    UIImage(named:"heart_") ,
                    UIImage(named:"radiant"),
                    UIImage(named:"oval"),
                    UIImage(named:"pear"),
                    UIImage(named:"marquise"),
                    UIImage(named:"asscher"),
                    UIImage(named:"CushionDiamond"),
                    UIImage(named:"OtherDiamond")]
    var shapeDataArr = ["All",
                    "Round" ,
                    "Princess" ,
                    "Emerald" ,
                    "Heart",
                    "Radiant",
                    "Oval",
                    "Pear",
                    "Marquise",
                    "Asscher",
                        "Cushion",
                        "Other"]
    
   
    var selectedIndicesShaps: Set<IndexPath> = []
    var selectedIndicesColor: Set<IndexPath> = []
    var selectedIndicesClarity: Set<IndexPath> = []
    var selectedIndicesCertificate: Set<IndexPath> = []
    var selectedIndicesFluorescence: Set<IndexPath> = []
    var selectedIndicesMake: IndexPath?
    
    var dataArrColorWhite : [SearchAttribDetail]?
    var dataArrColorFancy : [SearchAttribDetail]?
    var dataArrClarity: [SearchAttribDetail]?
    var dataArrCertificate: [SearchAttribDetail]?
    var dataArrFluorescence: [SearchAttribDetail]?
    var dataArrMake: [SearchAttribDetail]?
    
    
    var selectedDataArrColorWhite = [SearchAttribDetail]()
    var selectedDataArrColorFancy = [SearchAttribDetail]()
    var selectedDataArrClarity = [SearchAttribDetail]()
    var selectedDataArrCertificate = [SearchAttribDetail]()
    var selectedDataArrFluorescence = [SearchAttribDetail]()
    var selectedDataArrMake = [SearchAttribDetail]()
    var shapeArr = [String]()
    
    var textData = [SearchAttribDetail]()
    var diaQualityTap: [String]?
    
    var isBestQuality = false
    var isMediumQuality = false
    var isLowQuality = false
    
    
    // advanceFilterLogic
    var dataArrCut : [SearchAttribDetail]?
    var dataArrPolish : [SearchAttribDetail]?
    var dataArrSymmetry: [SearchAttribDetail]?
   
    
    var selectedIndicesCut: Set<IndexPath> = []
    var selectedIndicesPolish: Set<IndexPath> = []
    var selectedIndicesSymmetry: Set<IndexPath> = []
 
    
    
    var searchAttriStruct =  SearchOptionDataStruct()
    
    var selectedDataArrCut = [SearchAttribDetail]()
    var selectedDataArrPolish = [SearchAttribDetail]()
    var selectedDataArrSymmetry = [SearchAttribDetail]()
    var selectedDataArrIntencity = [SearchAttribDetail]()
    
    var btnActionAdvanceFilter : (([SearchAttribDetail]) -> Void) = {_ in }

    
   // var searchAttributeStruct = SearchOptionDataStruct()
    var colorDiaWhiteShow = true
    
    var clearAll : (() -> Void) = {}
    


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        txtPriceFrom.delegate = self
        txtCaratFrom.delegate = self
        txtPriceTo.delegate = self
        txtCaratTo.delegate = self
        
        if let searchOptionData = UserDefaultManager().retrieveSearchFieldsData(){
            self.searchAttributeStruct = searchOptionData
        }
        
        self.setupButtonIMG()
        
     
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
        

        
        selectedIndicesShaps =   DataManager.shared.defaultSelectedIndicesShaps
        selectedIndicesColor  =    DataManager.shared.defaultSelectedIndicesColor
        selectedIndicesClarity =  DataManager.shared.defaultSelectedIndicesClarity
         selectedIndicesCertificate = DataManager.shared.defaultSelectedIndicesCertificate
         selectedIndicesFluorescence = DataManager.shared.defaultSelectedIndicesFluorescence
        selectedIndicesMake =  DataManager.shared.defaultSelectedIndicesMake
        
        self.txtCaratTo.text = DataManager.shared.cartTo
        self.txtCaratFrom.text = DataManager.shared.cartFrom
        self.txtPriceTo.text = DataManager.shared.txttPriceTo
        self.txtPriceFrom.text = DataManager.shared.txtPriceFrom
        
       // setUpMediumBestBTN()
        //setupTopBTN()
        setupIsreturnable()
       // DataManager.shared.color = "white"
        
        // filter datya
//        self.filterDataStruct()

    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
//           if let text = textField.tag {
        self.textData.removeAll()
        switch textField.tag {
        case 1:
            var dataArr = SearchAttribDetail()
            dataArr.displayAttr = textField.text ?? ""
            self.textData.append(dataArr)
            DataManager.shared.txtPriceFrom = textField.text ?? ""
            self.delegate?.didselectOption(searchTitle: "PriceFrom", details: self.textData, shapeArr: [])
        case 2:
            var dataArr = SearchAttribDetail()
            dataArr.displayAttr = textField.text ?? ""
            self.textData.append(dataArr)
            DataManager.shared.txttPriceTo = textField.text ?? ""
            self.delegate?.didselectOption(searchTitle: "PriceTo", details: self.textData, shapeArr: [])
        case 3:
            var dataArr = SearchAttribDetail()
            dataArr.displayAttr = textField.text ?? ""
            self.textData.append(dataArr)
            DataManager.shared.cartFrom = textField.text ?? ""
            self.delegate?.didselectOption(searchTitle: "CaratFrom", details: self.textData, shapeArr: [])
        case 4:
            var dataArr = SearchAttribDetail()
            dataArr.displayAttr = textField.text ?? ""
            self.textData.append(dataArr)
            DataManager.shared.cartTo = textField.text ?? ""
            self.delegate?.didselectOption(searchTitle: "CaratTo", details: self.textData, shapeArr: [])
       
        default:
            print(textField.text)
        }
//           }
       }
    
    @IBAction func btnActionClearAll(_ sender:UIButton){
        
        self.clearAll()
        DataManager.shared.isReturnabl = -1
        DataManager.shared.advanceFilterDictionaryOfSets.removeAll()
        DataManager.shared.manualFilterDictionaryOfSets.removeAll()
        DataManager.shared.dictionaryOfSets.removeAll()
        DataManager.shared.shapeArr.removeAll()
        DataManager.shared.keyWordSearch = String()
        DataManager.shared.defaultSelectedShowColor = Bool()
        
        DataManager.shared.defaultSelectedIndicesShaps.removeAll()
        DataManager.shared.defaultSelectedIndicesColor.removeAll()
        DataManager.shared.defaultSelectedIndicesClarity.removeAll()
        DataManager.shared.defaultSelectedIndicesCertificate.removeAll()
        DataManager.shared.defaultSelectedIndicesFluorescence.removeAll()
        DataManager.shared.defaultSelectedIndicesMake =  nil
        DataManager.shared.defaultSelectedDataArrColorWhite.removeAll()
        DataManager.shared.defaultSelectedDataArrColorFancy .removeAll()
        DataManager.shared.defaultSelectedDataArrClarity.removeAll()
        DataManager.shared.defaultSelectedDataArrCertificate.removeAll()
        DataManager.shared.defaultSelectedDataArrFluorescence.removeAll()
        DataManager.shared.defaultSelectedDataArrMake.removeAll()
        DataManager.shared.defaultShapeArr.removeAll()
        DataManager.shared.txttPriceTo = String()
        DataManager.shared.txtPriceFrom = String()
        DataManager.shared.cartTo = String()
        DataManager.shared.cartFrom = String()
        DataManager.shared.btnTagSelect = Int()
        
        self.selectedIndicesShaps.removeAll()
        self.selectedIndicesColor.removeAll()
        self.selectedIndicesClarity.removeAll()
        self.selectedIndicesCertificate.removeAll()
        self.selectedIndicesFluorescence.removeAll()
        self.selectedIndicesMake = nil
        self.selectedDataArrColorWhite.removeAll()
        self.selectedDataArrColorFancy.removeAll()
        self.selectedDataArrClarity.removeAll()
        self.selectedDataArrCertificate.removeAll()
        self.selectedDataArrFluorescence.removeAll()
        self.selectedDataArrMake.removeAll()
        self.shapeArr.removeAll()
        
        self.txtCaratTo.text = ""
        self.txtCaratFrom.text = ""
        self.txtPriceTo.text = ""
        self.txtPriceFrom.text = ""
       // setupIsreturnable()
        
        self.collectionShap.reloadData()
        self.collectionColors.reloadData()
        self.collectionClarity.reloadData()
        self.collectionCertificate.reloadData()
        self.collectionFluorescence.reloadData()
        self.collectionMake.reloadData()
        
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
            
            if attributeData.attribType == attributeTypeCut{
                self.dataArrCut = attributeData.attribDetails
            }
            
            if attributeData.attribType == attributeTypePolish{
                self.dataArrPolish = attributeData.attribDetails
            }
            
            if attributeData.attribType == attributeTypSymmetry{
                self.dataArrSymmetry = attributeData.attribDetails
            }
            
           
            
        }
        
    }
    
    
    
    
    
    func configureCollectionView(_ collectionView: UICollectionView) {
           collectionView.showsHorizontalScrollIndicator = false
           collectionView.showsVerticalScrollIndicator = false
           collectionView.allowsMultipleSelection = true
           collectionView.delegate = self
           collectionView.dataSource = self

           
//            self.btnBest.setGradientLayer(colorsInOrder:  [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
//            self.btnBest.setTitleColor(.whitClr, for: .normal)
            self.viewBGFilter.setGradientLayerView(colorsInOrder:  [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
        
        
       }
    
    func setGradientBtn(string:String){
//        if string == "Lab Grown Diamonds"{
//            self.btnLabGrownDia.setGradientLayer(colorsInOrder:  [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
//            self.btnLabGrownDia.setTitleColor(.whitClr, for: .normal)
//            self.btnNaturalDia.clearGradient()
//            self.btnNaturalDia.setTitleColor(.themeClr, for: .normal)
//            DataManager.shared.diaType = "labgrown"
//            
//        }
//        else{
//            self.btnNaturalDia.setGradientLayer(colorsInOrder:  [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
//            self.btnNaturalDia.setTitleColor(.whitClr, for: .normal)
//            self.btnLabGrownDia.clearGradient()
//            self.btnLabGrownDia.setTitleColor(.themeClr, for: .normal)
//            DataManager.shared.diaType = "natural"
//        }
//        
        setupTopBTN()
        DataManager.shared.color = "white"
        
    }
    
    func btnClerBG(){
        DataManager.shared.btnTagSelect = Int()
        btnBest.clearGradient()
        btnBest.setTitleColor(.themeClr, for: .normal)
        btnMedium.clearGradient()
        btnMedium.setTitleColor(.themeClr, for: .normal)
        btnLow.clearGradient()
        btnLow.setTitleColor(.themeClr, for: .normal)
    }
    
   
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpMediumBestBTN(){
        switch DataManager.shared.btnTagSelect {
        case 0:
            self.removedefaultFilter()
            self.isBestQuality.toggle()
            if self.isBestQuality{
                self.isMediumQuality = false
                self.isLowQuality = false
                btnBest.setGradientLayer(colorsInOrder:  [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
                btnBest.setTitleColor(.whitClr, for: .normal)
                self.setupBtnLogicForDia( buttonTag: 0)
            }
            else{
                btnBest.clearGradient()
                btnBest.setTitleColor(.themeClr, for: .normal)
                
            }
          
            btnMedium.clearGradient()
            btnMedium.setTitleColor(.themeClr, for: .normal)
            btnLow.clearGradient()
            btnLow.setTitleColor(.themeClr, for: .normal)
        case 1:
            self.removedefaultFilter()
            self.isMediumQuality.toggle()
            if self.isMediumQuality{
                self.isBestQuality = false
                self.isLowQuality = false
                btnMedium.setGradientLayer(colorsInOrder:  [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
                btnMedium.setTitleColor(.whitClr, for: .normal)
                self.setupBtnLogicForDia( buttonTag: 1)
            }
            else{
                
                btnMedium.clearGradient()
                btnMedium.setTitleColor(.themeClr, for: .normal)
               
            }
           
            btnBest.clearGradient()
            btnBest.setTitleColor(.themeClr, for: .normal)
            btnLow.clearGradient()
            btnLow.setTitleColor(.themeClr, for: .normal)
        case 2:
            self.removedefaultFilter()
            self.isLowQuality.toggle()
            if self.isLowQuality{
                self.isMediumQuality = false
                self.isBestQuality = false
                btnLow.setGradientLayer(colorsInOrder:  [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
                btnLow.setTitleColor(.whitClr, for: .normal)
                self.setupBtnLogicForDia( buttonTag: 2)
            }
            else{
                btnLow.clearGradient()
                btnLow.setTitleColor(.themeClr, for: .normal)
                
            }
           
           
            btnMedium.clearGradient()
            btnMedium.setTitleColor(.themeClr, for: .normal)
            btnBest.clearGradient()
            btnBest.setTitleColor(.themeClr, for: .normal)
        default:
           print("////")
        }
    }
    
    
    
    @IBAction func btnActionBestMediumLow(_ sender:UIButton){
        DataManager.shared.btnTagSelect = sender.tag
        
        setupGetDataDIA(attributID: sender.tag + 1)
        
        if sender.tag == 0{
            self.removedefaultFilter()
            self.isBestQuality.toggle()
            if self.isBestQuality{
                self.isMediumQuality = false
                self.isLowQuality = false
                btnBest.setGradientLayer(colorsInOrder:  [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
                btnBest.setTitleColor(.whitClr, for: .normal)
                self.setupBtnLogicForDia( buttonTag: 0)
            }
            else{
                btnBest.clearGradient()
                btnBest.setTitleColor(.themeClr, for: .normal)
                
            }
          
            btnMedium.clearGradient()
            btnMedium.setTitleColor(.themeClr, for: .normal)
            btnLow.clearGradient()
            btnLow.setTitleColor(.themeClr, for: .normal)
            
         
            
        }
        else if sender.tag == 1{
            self.removedefaultFilter()
            self.isMediumQuality.toggle()
            if self.isMediumQuality{
                self.isBestQuality = false
                self.isLowQuality = false
                btnMedium.setGradientLayer(colorsInOrder:  [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
                btnMedium.setTitleColor(.whitClr, for: .normal)
                self.setupBtnLogicForDia( buttonTag: 1)
            }
            else{
                
                btnMedium.clearGradient()
                btnMedium.setTitleColor(.themeClr, for: .normal)
               
            }
           
            btnBest.clearGradient()
            btnBest.setTitleColor(.themeClr, for: .normal)
            btnLow.clearGradient()
            btnLow.setTitleColor(.themeClr, for: .normal)
        }
        else {
            self.removedefaultFilter()
            self.isLowQuality.toggle()
            if self.isLowQuality{
                self.isMediumQuality = false
                self.isBestQuality = false
                btnLow.setGradientLayer(colorsInOrder:  [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
                btnLow.setTitleColor(.whitClr, for: .normal)
                self.setupBtnLogicForDia( buttonTag: 2)
            }
            else{
                btnLow.clearGradient()
                btnLow.setTitleColor(.themeClr, for: .normal)
                
            }
           
           
            btnMedium.clearGradient()
            btnMedium.setTitleColor(.themeClr, for: .normal)
            btnBest.clearGradient()
            btnBest.setTitleColor(.themeClr, for: .normal)
        }
        
    }
    
    
    //btnActionTag
    func setupGetDataDIA(attributID:Int){
       
        selectedDataArrCut.removeAll()
        selectedDataArrPolish.removeAll()
        selectedDataArrSymmetry.removeAll()
        
            switch attributID {
            case 1:
                
                self.dataArrCut?.enumerated().forEach { (index, detail) in
                    if index == 0 || index == 1  {
                        self.selectedDataArrCut.append(detail)
                        let itemIndex = index
                        let indexPath = IndexPath(item: itemIndex, section: 0)
                        selectedIndicesCut.insert(indexPath)
                        
                        DataManager.shared.defaultSelectedIndicesCut.insert(indexPath)
                        
                    }
                    self.setupDefaultTabs(searchTitle: "Cut", dataArr: selectedDataArrCut)
                    
                }
                self.dataArrPolish?.enumerated().forEach { (index, detail) in
                    if index == 0  {
                        self.selectedDataArrPolish.append(detail)
                        let itemIndex = index
                        let indexPath = IndexPath(item: itemIndex, section: 0)
                        selectedIndicesPolish.insert(indexPath)
                        DataManager.shared.defaultSelectedIndicesPolish.insert(indexPath)
                        
                    }
                    
                    self.setupDefaultTabs(searchTitle: "Polish", dataArr: selectedDataArrPolish)
                  //  delegate?.didselectOption(searchTitle: "Polish", details: selectedDataArrCut, shapeArr: [])
                }
                
                self.dataArrSymmetry?.enumerated().forEach { (index, detail) in
                    if index == 0 {
                        self.selectedDataArrSymmetry.append(detail)
                        let itemIndex = index
                        let indexPath = IndexPath(item: itemIndex, section: 0)
                        selectedIndicesSymmetry.insert(indexPath)
                        DataManager.shared.defaultSelectedIndicesSymmetry.insert(indexPath)
                        
                    }
                    
                    self.setupDefaultTabs(searchTitle: "Symmetry", dataArr: selectedDataArrSymmetry)
                   // delegate?.didselectOption(searchTitle: "Symmetry", details: selectedDataArrCut, shapeArr: [])
                }
                
            case 2:
                self.dataArrCut?.enumerated().forEach { (index, detail) in
                    if index == 1  {
                        self.selectedDataArrCut.append(detail)
                        let itemIndex = index
                        let indexPath = IndexPath(item: itemIndex, section: 0)
                        selectedIndicesCut.insert(indexPath)
                        DataManager.shared.defaultSelectedIndicesCut.insert(indexPath)
                        
                    }
                    self.setupDefaultTabs(searchTitle: "Cut", dataArr: selectedDataArrCut)
                  //  delegate?.didselectOption(searchTitle: "Symmetry", details: selectedDataArrCut, shapeArr: [])
                }
                self.dataArrPolish?.enumerated().forEach { (index, detail) in
                    if index == 0 || index == 1  {
                        self.selectedDataArrPolish.append(detail)
                        let itemIndex = index
                        let indexPath = IndexPath(item: itemIndex, section: 0)
                        selectedIndicesPolish.insert(indexPath)
                        DataManager.shared.defaultSelectedIndicesPolish.insert(indexPath)
                    }
                    
                    self.setupDefaultTabs(searchTitle: "Polish", dataArr: selectedDataArrPolish)
                    
                    //delegate?.didselectOption(searchTitle: "Polish", details: selectedDataArrCut, shapeArr: [])
                }
                
                self.dataArrSymmetry?.enumerated().forEach { (index, detail) in
                    if index == 0 || index == 1 {
                        self.selectedDataArrSymmetry.append(detail)
                        let itemIndex = index
                        let indexPath = IndexPath(item: itemIndex, section: 0)
                        selectedIndicesSymmetry.insert(indexPath)
                        DataManager.shared.defaultSelectedIndicesSymmetry.insert(indexPath)
                        
                    }
                    self.setupDefaultTabs(searchTitle: "Symmetry", dataArr: selectedDataArrSymmetry)
                  //  delegate?.didselectOption(searchTitle: "Symmetry", details: selectedDataArrCut, shapeArr: [])
                }
                
            case 3:
                self.dataArrCut?.enumerated().forEach { (index, detail) in
                    if index == 2 || index == 1  {
                        self.selectedDataArrCut.append(detail)
                        let itemIndex = index
                        let indexPath = IndexPath(item: itemIndex, section: 0)
                        selectedIndicesCut.insert(indexPath)
                        DataManager.shared.defaultSelectedIndicesCut.insert(indexPath)
                        
                    }
                    
                    self.setupDefaultTabs(searchTitle: "Cut", dataArr: selectedDataArrCut)
                    
                    //delegate?.didselectOption(searchTitle: "Cut", details: selectedDataArrCut, shapeArr: [])
                }
                self.dataArrPolish?.enumerated().forEach { (index, detail) in
                    if index == 0 || index == 1  {
                        self.selectedDataArrPolish.append(detail)
                        let itemIndex = index
                        let indexPath = IndexPath(item: itemIndex, section: 0)
                        selectedIndicesPolish.insert(indexPath)
                        DataManager.shared.defaultSelectedIndicesPolish.insert(indexPath)
                        
                    }
                    
                    self.setupDefaultTabs(searchTitle: "Polish", dataArr: selectedDataArrPolish)
                    
                   // delegate?.didselectOption(searchTitle: "Polish", details: selectedDataArrCut, shapeArr: [])
                }
                
                self.dataArrSymmetry?.enumerated().forEach { (index, detail) in
                    if index == 0 || index == 1 {
                        self.selectedDataArrSymmetry.append(detail)
                        let itemIndex = index
                        let indexPath = IndexPath(item: itemIndex, section: 0)
                        selectedIndicesSymmetry.insert(indexPath)
                        DataManager.shared.defaultSelectedIndicesSymmetry.insert(indexPath)
                        
                    }
                    
                    self.setupDefaultTabs(searchTitle: "Symmetry", dataArr: selectedDataArrSymmetry)
                    
                    //delegate?.didselectOption(searchTitle: "Symmetry", details: selectedDataArrCut, shapeArr: [])
                }
            default:
                print("")
                
            }
    }
    
    
    func setupDefaultTabs(searchTitle: String,dataArr : [SearchAttribDetail]){
        var filterAtribut = [FilterAttribDetail]()
        dataArr.enumerated().forEach { inxe , item in
            var filterArr = FilterAttribDetail()
            filterArr.attribCode = item.attribCode
            filterArr.attribType = item.attribType
            filterArr.attribID = item.attribID
            filterArr.attribTypeID = item.attribTypeID
            filterArr.displayAttr = item.displayAttr
            filterArr.sortOrder = item.sortOrder
            filterAtribut.append(filterArr)
        }
        
        switch searchTitle {
        case "Cut":
            DataManager.shared.advanceFilterDictionaryOfSets.removeValue(forKey: "Cut")
            DataManager.shared.addAdvanceFIlterAttribute(toKey: searchTitle, element: filterAtribut)
        case "Polish":
            DataManager.shared.advanceFilterDictionaryOfSets.removeValue(forKey: "Polish")
            DataManager.shared.addAdvanceFIlterAttribute(toKey: searchTitle, element: filterAtribut)
            
        case "Symmetry":
            DataManager.shared.advanceFilterDictionaryOfSets.removeValue(forKey: "Symmetry")
            DataManager.shared.addAdvanceFIlterAttribute(toKey: searchTitle, element: filterAtribut)
        default:
           print(shapeArr)
        }
    }
    
    
    
    func setupBtnLogicForDia(buttonTag:Int){

            self.dataArrColorWhite?.enumerated().forEach { (index, detail) in
               
                switch buttonTag {
                case 0:
                    if index == 0 || index == 1 || index == 2 {
                        self.selectedDataArrColorWhite.append(detail)
                        let itemIndex = index
                        let indexPath = IndexPath(item: itemIndex, section: 0)
                        selectedIndicesColor.insert(indexPath)
                        
                    }
                    
                case 1:
                    if index == 3 || index == 4 || index == 5 {
                        self.selectedDataArrColorWhite.append(detail)
                        let itemIndex = index
                        let indexPath = IndexPath(item: itemIndex, section: 0)
                        selectedIndicesColor.insert(indexPath)
                    }
                    
                default:
                    if index == 6 || index == 7 || index == 8 {
                        self.selectedDataArrColorWhite.append(detail)
                        let itemIndex = index
                        let indexPath = IndexPath(item: itemIndex, section: 0)
                        selectedIndicesColor.insert(indexPath)
                        
                    }
                }
                
                DataManager.shared.defaultSelectedIndicesColor =  selectedIndicesColor
                delegate?.didselectOption(searchTitle: "Color", details: selectedDataArrColorWhite, shapeArr: [])
                self.collectionColors.reloadData()
            }
                
           
            self.dataArrClarity?.enumerated().forEach { (index, detail) in
                switch buttonTag {
                case 0:
                    if index == 0 || index == 1 || index == 2 || index == 3{
                        self.selectedDataArrClarity.append(detail)
                        let itemIndex = index
                        let indexPath = IndexPath(item: itemIndex, section: 0)
                        selectedIndicesClarity.insert(indexPath)
                    }
                case 1:
                    if index == 4 || index == 5{
                        self.selectedDataArrClarity.append(detail)
                        let itemIndex = index
                        let indexPath = IndexPath(item: itemIndex, section: 0)
                        selectedIndicesClarity.insert(indexPath)
                    }
                default:
                    if index == 6 || index == 7 || index == 8 || index == 9{
                        self.selectedDataArrClarity.append(detail)
                        let itemIndex = index
                        let indexPath = IndexPath(item: itemIndex, section: 0)
                        selectedIndicesClarity.insert(indexPath)
                    }
                }
              
                DataManager.shared.defaultSelectedIndicesClarity =  selectedIndicesClarity
                delegate?.didselectOption(searchTitle: "Clarity", details: selectedDataArrClarity, shapeArr: [])
                self.collectionClarity.reloadData()
            }
           
            self.dataArrCertificate?.enumerated().forEach { (index, detail) in
                switch buttonTag {
                case 0 ,1, 2:
                    if index == 0 || index == 1 {
                        self.selectedDataArrCertificate.append(detail)
                        let itemIndex = index
                        let indexPath = IndexPath(item: itemIndex, section: 0)
                        selectedIndicesCertificate.insert(indexPath)
                    }
               
                default:
                    print("Setificate")
                }
                
                
                DataManager.shared.defaultSelectedIndicesCertificate =  selectedIndicesCertificate
                delegate?.didselectOption(searchTitle: "Certificate", details: selectedDataArrCertificate, shapeArr: [])
                self.collectionCertificate.reloadData()
            }
            
            self.dataArrFluorescence?.enumerated().forEach { (index, detail) in
                
                switch buttonTag {
                case 0 :
                if index == 0{
                    self.selectedDataArrFluorescence.append(detail)
                    let itemIndex = index
                    let indexPath = IndexPath(item: itemIndex, section: 0)
                    selectedIndicesFluorescence.insert(indexPath)
                }
                case 1 :
                if index == 0 || index == 1 || index == 2{
                    self.selectedDataArrFluorescence.append(detail)
                    let itemIndex = index
                    let indexPath = IndexPath(item: itemIndex, section: 0)
                    selectedIndicesFluorescence.insert(indexPath)
                }
                default:

                        self.selectedDataArrFluorescence.append(detail)
                        let itemIndex = index
                        let indexPath = IndexPath(item: itemIndex, section: 0)
                        selectedIndicesFluorescence.insert(indexPath)
                }
                
                
                DataManager.shared.defaultSelectedIndicesFluorescence =  selectedIndicesFluorescence
                
                delegate?.didselectOption(searchTitle: "Fluorescence", details: selectedDataArrFluorescence, shapeArr: [])
                self.collectionFluorescence.reloadData()
            }
            
            self.dataArrMake?.enumerated().forEach { (index, detail) in
                switch buttonTag {
                case 0 :
                    if index == 0{
                        self.selectedDataArrMake.append(detail)
                        let itemIndex = index
                        let indexPath = IndexPath(item: itemIndex, section: 0)
                        selectedIndicesMake = indexPath
                    }
                case 1, 2 :
                    if index == 2{
                        self.selectedDataArrMake.append(detail)
                        let itemIndex = index
                        let indexPath = IndexPath(item: itemIndex, section: 0)
                        selectedIndicesMake = indexPath
                    }
                default:
                   print("Make")
                }
                
                //DataManager.shared.defaultSelectedIndicesMake =
               
                DataManager.shared.defaultSelectedIndicesMake =  selectedIndicesMake
                
                
                delegate?.didselectOption(searchTitle: "Make", details: selectedDataArrMake, shapeArr: [])
                self.collectionMake.reloadData()
            }

    }
    
    func removedefaultFilter(){
        selectedIndicesShaps.removeAll()
        selectedIndicesColor.removeAll()
        selectedIndicesClarity.removeAll()
        selectedIndicesCertificate.removeAll()
        selectedIndicesFluorescence.removeAll()
        selectedDataArrColorWhite.removeAll()
        selectedDataArrColorFancy.removeAll()
        selectedDataArrClarity.removeAll()
        selectedDataArrCertificate.removeAll()
        selectedDataArrFluorescence.removeAll()
        selectedDataArrMake.removeAll()
        
        collectionColors.reloadData()
        collectionClarity.reloadData()
        collectionCertificate.reloadData()
        collectionFluorescence.reloadData()
        collectionMake.reloadData()
        
    }
    
    
    
    func setupTopBTN(){
        if DataManager.shared.diaType == "natural"{
            btnNaturalDia.setGradientLayer(colorsInOrder:  [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
            btnNaturalDia.setTitleColor(.whitClr, for: .normal)
            btnLabGrownDia.clearGradient()
            btnLabGrownDia.setTitleColor(.themeClr, for: .normal)
        }
        else if DataManager.shared.diaType == "labgrown" {
            btnLabGrownDia.setGradientLayer(colorsInOrder:  [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
//            viewLabBG.setGradientLayerView(colorsInOrder:  [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
            btnLabGrownDia.setTitleColor(.whitClr, for: .normal)
            btnNaturalDia.clearGradient()
            btnNaturalDia.setTitleColor(.themeClr, for: .normal)
        }
        else{
            self.btnNaturalDia.setGradientLayer(colorsInOrder:  [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
            self.btnNaturalDia.setTitleColor(.whitClr, for: .normal)
            self.btnLabGrownDia.clearGradient()
            self.btnLabGrownDia.setTitleColor(.themeClr, for: .normal)
            DataManager.shared.diaType = "natural"
        }
    }
    
    @IBAction func btnActionNaturalLabD(_ sender:UIButton){

        if sender.tag == 0{
            btnNaturalDia.setGradientLayer(colorsInOrder:  [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
            btnNaturalDia.setTitleColor(.whitClr, for: .normal)
            btnLabGrownDia.clearGradient()
            btnLabGrownDia.setTitleColor(.themeClr, for: .normal)
            DataManager.shared.diaType = "natural"
            
        }
        else{
            btnLabGrownDia.setGradientLayer(colorsInOrder:  [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
//            viewLabBG.setGradientLayerView(colorsInOrder:  [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
            btnLabGrownDia.setTitleColor(.whitClr, for: .normal)
            btnNaturalDia.clearGradient()
            btnNaturalDia.setTitleColor(.themeClr, for: .normal)
            DataManager.shared.diaType = "labgrown"
        }
        
    }
    
    
    func setupIsreturnable(){
        if DataManager.shared.isReturnabl == 1{
            btnYes.setGradientLayer(colorsInOrder:  [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
            btnYes.setTitleColor(.whitClr, for: .normal)
            btnNo.clearGradient()
            btnNo.setTitleColor(.themeClr, for: .normal)
            
        }
        else if DataManager.shared.isReturnabl == 0{
            btnNo.setGradientLayer(colorsInOrder:  [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
            btnNo.setTitleColor(.whitClr, for: .normal)
            btnYes.clearGradient()
            btnYes.setTitleColor(.themeClr, for: .normal)
          
        }
    }
    
    
    @IBAction func btnActionYES_No(_ sender:UIButton){

//        if sender.tag == 0{
//            btnYes.setGradientLayer(colorsInOrder:  [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
//            btnYes.setTitleColor(.whitClr, for: .normal)
//            btnNo.clearGradient()
//            btnNo.setTitleColor(.themeClr, for: .normal)
//            DataManager.shared.isReturnabl = 1
//        }
//        else{
//            btnNo.setGradientLayer(colorsInOrder:  [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
//            btnNo.setTitleColor(.whitClr, for: .normal)
//            btnYes.clearGradient()
//            btnYes.setTitleColor(.themeClr, for: .normal)
//            DataManager.shared.isReturnabl = 0
//        }
        
        if sender.tag == 0 {
               if DataManager.shared.isReturnabl == 1 {
                   // Unselect the Yes button
                   btnYes.clearGradient()
                   btnYes.setTitleColor(.themeClr, for: .normal)
                   DataManager.shared.isReturnabl = -1 // Reset or use any default value
               } else {
                   // Select the Yes button
                   btnYes.setGradientLayer(colorsInOrder: [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
                   btnYes.setTitleColor(.whitClr, for: .normal)
                   btnNo.clearGradient()
                   btnNo.setTitleColor(.themeClr, for: .normal)
                   DataManager.shared.isReturnabl = 1
               }
           } else {
               if DataManager.shared.isReturnabl == 0 {
                   // Unselect the No button
                   btnNo.clearGradient()
                   btnNo.setTitleColor(.themeClr, for: .normal)
                   DataManager.shared.isReturnabl = -1 // Reset or use any default value
               } else {
                   // Select the No button
                   btnNo.setGradientLayer(colorsInOrder: [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
                   btnNo.setTitleColor(.whitClr, for: .normal)
                   btnYes.clearGradient()
                   btnYes.setTitleColor(.themeClr, for: .normal)
                   DataManager.shared.isReturnabl = 0
               }
           }
    }
    
    
    func setupButtonIMG(){
        
        colorDiaWhiteShow =  DataManager.shared.defaultSelectedShowColor ?? Bool()
        
        if colorDiaWhiteShow {
            DataManager.shared.defaultSelectedShowColor = true
            self.btnClorWhite.setImage(UIImage(named: "radioButtonSelected"), for: .normal)
            self.btnClorFancy.setImage(UIImage(named: "radioButtonDeselected"), for: .normal)

            DataManager.shared.color = "white"
        }
        else{
            self.selectedDataArrColorWhite.removeAll()
            self.selectedIndicesColor.removeAll()
            colorDiaWhiteShow = false
            DataManager.shared.defaultSelectedShowColor = false
            self.btnClorWhite.setImage(UIImage(named: "radioButtonDeselected"), for: .normal)
            self.btnClorFancy.setImage(UIImage(named: "radioButtonSelected"), for: .normal)
            DataManager.shared.color = "fancy"
        }
        self.collectionColors.reloadData()
    }
    
    
    
    
    @IBAction func btnActioColor(_ sender:UIButton){
        if sender.tag == 0{
            colorDiaWhiteShow = true
            DataManager.shared.defaultSelectedShowColor = true
            self.btnClorWhite.setImage(UIImage(named: "radioButtonSelected"), for: .normal)
            self.btnClorFancy.setImage(UIImage(named: "radioButtonDeselected"), for: .normal)

            DataManager.shared.color = "white"
        }
        else{
            self.selectedDataArrColorWhite.removeAll()
            self.selectedIndicesColor.removeAll()
            colorDiaWhiteShow = false
            DataManager.shared.defaultSelectedShowColor = false
            self.btnClorWhite.setImage(UIImage(named: "radioButtonDeselected"), for: .normal)
            self.btnClorFancy.setImage(UIImage(named: "radioButtonSelected"), for: .normal)
            DataManager.shared.color = "fancy"
        }
        self.collectionColors.reloadData()
    }
    
    @IBAction func btnActioAdvanceFilter(_ sender:UIButton){
        self.btnActionAdvanceFilter(selectedDataArrMake)
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
            cell.isGradientApplied = selectedIndicesMake == indexPath
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
            
            
            if self.colorDiaWhiteShow {
                
                if selectedIndicesColor.contains(indexPath) {
                    selectedIndicesColor.remove(indexPath)
                    if let selectData = dataArrColorWhite?[indexPath.row]{
                        self.selectedDataArrColorWhite.enumerated().forEach { index, item in
                            if selectData.attribID == item.attribID{
                                self.selectedDataArrColorWhite.remove(at: index)
                            }
                        }
                    }
                    cell.isGradientApplied = false
                } else {
                    selectedIndicesColor.insert(indexPath)
                    if let selectData = dataArrColorWhite?[indexPath.row]{
                        self.selectedDataArrColorWhite.append(selectData)
                    }
                    cell.isGradientApplied = true
                }
                
                
                
                
                if self.selectedDataArrColorWhite.count > 0{
                    selectedDataArrColorFancy.removeAll()
                    self.delegate?.didselectOption(searchTitle: "Color-Fancy", details: selectedDataArrColorFancy, shapeArr: [""])
                    DataManager.shared.defaultSelectedDataArrColorFancy.removeAll()
                    
                    DataManager.shared.defaultSelectedIndicesColor =  selectedIndicesColor
                    
                    DataManager.shared.defaultSelectedDataArrColorWhite = selectedDataArrColorWhite
                   
                    self.delegate?.didselectOption(searchTitle: "Color", details: selectedDataArrColorWhite, shapeArr: [""])
                }
                else{
                    selectedDataArrColorWhite.removeAll()
                    self.delegate?.didselectOption(searchTitle: "Color", details: selectedDataArrColorWhite, shapeArr: [""])
                    DataManager.shared.defaultSelectedIndicesColor.removeAll()
                    DataManager.shared.defaultSelectedDataArrColorWhite.removeAll()
                     
                }
            }
            else{
                
                if selectedIndicesColor.contains(indexPath) {
                    selectedIndicesColor.remove(indexPath)
                    if let selectData = dataArrColorFancy?[indexPath.row]{
                        self.selectedDataArrColorFancy.enumerated().forEach { index, item in
                            if selectData.attribID == item.attribID{
                                self.selectedDataArrColorFancy.remove(at: index)
                            }
                        }
                    }
                    cell.isGradientApplied = false
                } else {
                    selectedIndicesColor.insert(indexPath)
                    if let selectData = dataArrColorFancy?[indexPath.row]{
                        self.selectedDataArrColorFancy.append(selectData)
                    }
                    cell.isGradientApplied = true
                }
                
                
                
                if self.selectedDataArrColorFancy.count > 0{
                   
                   selectedDataArrColorWhite.removeAll()
                   self.delegate?.didselectOption(searchTitle: "Color", details: selectedDataArrColorWhite, shapeArr: [""])
                   
                   DataManager.shared.defaultSelectedDataArrColorWhite.removeAll()
                    
                    DataManager.shared.defaultSelectedIndicesColor =  selectedIndicesColor
                    
                    DataManager.shared.defaultSelectedDataArrColorFancy = selectedDataArrColorFancy
                    
                    self.delegate?.didselectOption(searchTitle: "Color-Fancy", details: selectedDataArrColorFancy, shapeArr: [""])
                }
                else{
                    selectedDataArrColorFancy.removeAll()
                    self.delegate?.didselectOption(searchTitle: "Color-Fancy", details: selectedDataArrColorFancy, shapeArr: [""])
                    
                    DataManager.shared.defaultSelectedIndicesColor.removeAll()
                    DataManager.shared.defaultSelectedDataArrColorFancy.removeAll()
                }
            }
            
            
        }
        
        if let indexPath = collectionClarity.indexPath(for: cell) {
            if selectedIndicesClarity.contains(indexPath) {
                selectedIndicesClarity.remove(indexPath)
                
                if let selectData = dataArrClarity?[indexPath.row]{
                    self.selectedDataArrClarity.enumerated().forEach { index, item in
                        if selectData.attribID == item.attribID{
                            self.selectedDataArrClarity.remove(at: index)
                        }
                        
                    }
                    
                }
                
                cell.isGradientApplied = false
            } else {
                selectedIndicesClarity.insert(indexPath)
                if let selectData = dataArrClarity?[indexPath.row]{
                    self.selectedDataArrClarity.append(selectData)
                }
                cell.isGradientApplied = true
            }
            
           
            if self.selectedDataArrClarity.count > 0{
                
                DataManager.shared.defaultSelectedIndicesClarity =  selectedIndicesClarity
                
                DataManager.shared.defaultSelectedDataArrClarity = selectedDataArrClarity
                
                self.delegate?.didselectOption(searchTitle: "Clarity", details: selectedDataArrClarity, shapeArr: [""])
            }
            else{
                DataManager.shared.defaultSelectedIndicesClarity.removeAll()
                
                DataManager.shared.defaultSelectedDataArrClarity.removeAll()
                
                selectedDataArrClarity.removeAll()
                
                self.delegate?.didselectOption(searchTitle: "Clarity", details: selectedDataArrClarity, shapeArr: [""])
            }
        }
        
        if let indexPath = collectionCertificate.indexPath(for: cell) {
            if selectedIndicesCertificate.contains(indexPath) {
                selectedIndicesCertificate.remove(indexPath)
                
                if let selectData = dataArrCertificate?[indexPath.row]{
                    self.selectedDataArrCertificate.enumerated().forEach { index, item in
                        if selectData.attribID == item.attribID{
                            self.selectedDataArrCertificate.remove(at: index)
                        }
                        
                    }
                    
                }
                
                cell.isGradientApplied = false
            } else {
                selectedIndicesCertificate.insert(indexPath)
                if let selectData = dataArrCertificate?[indexPath.row]{
                    self.selectedDataArrCertificate.append(selectData)
                }
                cell.isGradientApplied = true
            }
            
            if self.selectedDataArrCertificate.count > 0{
                
                DataManager.shared.defaultSelectedIndicesCertificate = selectedIndicesCertificate
                
                DataManager.shared.defaultSelectedDataArrCertificate = selectedDataArrCertificate
                
                self.delegate?.didselectOption(searchTitle: "Certificate", details: selectedDataArrCertificate, shapeArr: [""])
            }
            else{
                DataManager.shared.defaultSelectedIndicesCertificate.removeAll()
                
                DataManager.shared.defaultSelectedDataArrCertificate.removeAll()
                
                selectedDataArrCertificate.removeAll()
                self.delegate?.didselectOption(searchTitle: "Certificate", details: selectedDataArrCertificate, shapeArr: [""])
                
            }
        }
        
        if let indexPath = collectionFluorescence.indexPath(for: cell) {
            if selectedIndicesFluorescence.contains(indexPath) {
                selectedIndicesFluorescence.remove(indexPath)
                
                if let selectData = dataArrFluorescence?[indexPath.row]{
                    
                    self.selectedDataArrFluorescence.enumerated().forEach { index, item in
                        if selectData.attribID == item.attribID{
                            self.selectedDataArrFluorescence.remove(at: index)
                        }
                        
                    }
                    
                }
                
                cell.isGradientApplied = false
            } else {
                selectedIndicesFluorescence.insert(indexPath)
                if let selectData = dataArrFluorescence?[indexPath.row]{
                    self.selectedDataArrFluorescence.append(selectData)
                }
                cell.isGradientApplied = true
            }
            
            if self.selectedDataArrFluorescence.count > 0{
                
                DataManager.shared.defaultSelectedIndicesFluorescence = selectedIndicesFluorescence
                
                DataManager.shared.defaultSelectedDataArrFluorescence = selectedDataArrFluorescence
                
                self.delegate?.didselectOption(searchTitle: "Fluorescence", details: selectedDataArrFluorescence, shapeArr: [""])
            }
            else{
                DataManager.shared.defaultSelectedIndicesFluorescence.removeAll()
                
                DataManager.shared.defaultSelectedDataArrFluorescence.removeAll()
                selectedDataArrFluorescence.removeAll()
                self.delegate?.didselectOption(searchTitle: "Fluorescence", details: selectedDataArrFluorescence, shapeArr: [""])
            }
        }
        
        if let indexPath = collectionMake.indexPath(for: cell) {
               
            if selectedIndicesMake == indexPath {
                // Deselect the currently selected cell
                selectedIndicesMake = nil
                if let selectData = dataArrMake?[indexPath.row] {
                    selectedDataArrMake.removeAll { $0.attribID == selectData.attribID }
                }
                cell.isGradientApplied = false
                
            } else {
                
                // Deselect the previously selected cell
                if let previousIndex = selectedIndicesMake {
                    if let previousCell = collectionMake.cellForItem(at: previousIndex) as? SearchesOptionCVC {
                        previousCell.isGradientApplied = false
                    }
                    if let previousData = dataArrMake?[previousIndex.row] {
                        selectedDataArrMake.removeAll { $0.attribID == previousData.attribID }
                    }
                }
                
                // Select the new cell
                selectedIndicesMake = indexPath
                if let selectData = dataArrMake?[indexPath.row] {
                    selectedDataArrMake.append(selectData)
                }
                cell.isGradientApplied = true
            }
            
            // Notify the delegate
//            print(dataArrMake?.first?.attribID)
            if !selectedDataArrMake.isEmpty {
                
                
                DataManager.shared.defaultSelectedIndicesMake = selectedIndicesMake
                
                DataManager.shared.defaultSelectedDataArrMake = selectedDataArrMake
                
                self.setupGetDataDIA(attributID: (selectedIndicesMake?.row ?? 0) + 1)
                
                delegate?.didselectOption(searchTitle: "Make", details: selectedDataArrMake, shapeArr: [""])
            }
            else{
                delegate?.didselectOption(searchTitle: "Make", details: [], shapeArr: [""])
                
                DataManager.shared.defaultSelectedDataArrMake.removeAll()
                DataManager.shared.defaultSelectedIndicesMake = nil
                DataManager.shared.defaultSelectedIndicesCut.removeAll()
                DataManager.shared.defaultSelectedIndicesPolish.removeAll()
                DataManager.shared.defaultSelectedIndicesSymmetry.removeAll()
                self.selectedIndicesMake = nil
                self.selectedDataArrCut.removeAll()
                self.selectedDataArrPolish.removeAll()
                self.selectedDataArrSymmetry.removeAll()
                
                
               var advanceFilterDataDic = DataManager.shared.advanceFilterDictionaryOfSets
                
                let keyToRemoveCut = "Cut"
                let keyToRemovePolish = "Polish"
                let keyToRemoveSymtry = "Symmetry"
                
                if advanceFilterDataDic[keyToRemoveCut] != nil {
                    advanceFilterDataDic.removeValue(forKey: keyToRemoveCut)
                }
                
                if advanceFilterDataDic[keyToRemovePolish] != nil {
                    advanceFilterDataDic.removeValue(forKey: keyToRemovePolish)
                }
                
                if advanceFilterDataDic[keyToRemoveSymtry] != nil {
                    advanceFilterDataDic.removeValue(forKey: keyToRemoveSymtry)
                }
                
                DataManager.shared.advanceFilterDictionaryOfSets = advanceFilterDataDic

            }
            
            
        }
        self.btnClerBG()
    }
    
//    func imageViewTapped(in cell: SearchDiamondCVC) {
//        if let indexPath = collectionShap.indexPath(for: cell) {
//            if selectedIndicesShaps.contains(indexPath) {
//                selectedIndicesShaps.remove(indexPath)
//                self.shapeArr.enumerated().forEach { index, item in
//                    if item == shapeDataArr[indexPath.row]{
//                        self.shapeArr.remove(at: index)
//                    }
//                }
//                cell.isShadowApplied = false
//            } else {
//                selectedIndicesShaps.insert(indexPath)
//                self.shapeArr.append(shapeDataArr[indexPath.row])
//                cell.isShadowApplied = true
//                
////                if shapeDataArr[indexPath.row] == "All"{
////                    self.shapeDataArr.enumerated().forEach{ index,item in
////                        let idxPath = IndexPath(row: index, section: 0)
////                        selectedIndicesShaps.insert(idxPath)
////                        self.shapeArr.append(item)
////                        cell.isShadowApplied = true
////                    }
////                    
////                }
////                else{
////                    selectedIndicesShaps.insert(indexPath)
////                    self.shapeArr.append(shapeDataArr[indexPath.row])
////                    cell.isShadowApplied = true
////                }
//                    
//                
//            }
//            
//            if self.shapeArr.count > 0{
//                self.delegate?.didselectOption(searchTitle: "Shape", details: [], shapeArr: shapeArr)
//            }
//        }
//    }
    
    func imageViewTapped(in cell: SearchDiamondCVC) {
        if let indexPath = collectionShap.indexPath(for: cell) {
            let selectedItem = shapeDataArr[indexPath.row]
            
            // Handling the "All" selection
            if selectedItem == "All" {
                if selectedIndicesShaps.contains(indexPath) {
                    // Deselect all
                    selectedIndicesShaps.removeAll()
                    shapeArr.removeAll()
                    for i in 0..<shapeDataArr.count {
                        let idxPath = IndexPath(row: i, section: 0)
                        if let cell = collectionShap.cellForItem(at: idxPath) as? SearchDiamondCVC {
                            cell.isShadowApplied = false
                        }
                    }
                } else {
                    // Select all
                    for i in 0..<shapeDataArr.count {
                        let idxPath = IndexPath(row: i, section: 0)
                        selectedIndicesShaps.insert(idxPath)
                        shapeArr.append(shapeDataArr[i])
                        if let cell = collectionShap.cellForItem(at: idxPath) as? SearchDiamondCVC {
                            cell.isShadowApplied = true
                        }
                    }
                }
            } else {
                if selectedIndicesShaps.contains(indexPath) {
                    // Deselect the specific item
                    selectedIndicesShaps.remove(indexPath)
                    if let index = shapeArr.firstIndex(of: selectedItem) {
                        shapeArr.remove(at: index)
                    }
                   
                    cell.isShadowApplied = false
                } else {
                    // Select the specific item
                    selectedIndicesShaps.insert(indexPath)
                    shapeArr.append(selectedItem)
                    cell.isShadowApplied = true
                }
                
                // Handle the case where individual items are selected/deselected and "All" should be updated
                if selectedIndicesShaps.count == shapeDataArr.count - 1, let allIndex = shapeDataArr.firstIndex(of: "All") {
                    let allIndexPath = IndexPath(row: allIndex, section: 0)
                    selectedIndicesShaps.insert(allIndexPath)
                    shapeArr.append("All")
                    if let allCell = collectionShap.cellForItem(at: allIndexPath) as? SearchDiamondCVC {
                        allCell.isShadowApplied = true
                    }
                } else if let allIndex = shapeDataArr.firstIndex(of: "All") {
                    let allIndexPath = IndexPath(row: allIndex, section: 0)
                    selectedIndicesShaps.remove(allIndexPath)
                    if let index = shapeArr.firstIndex(of: "All") {
                        shapeArr.remove(at: index)
                    }
                    if let allCell = collectionShap.cellForItem(at: allIndexPath) as? SearchDiamondCVC {
                        allCell.isShadowApplied = false
                    }
                }
            }
            
            if shapeArr.count > 0 {
                 DataManager.shared.defaultSelectedIndicesShaps = selectedIndicesShaps
                DataManager.shared.defaultShapeArr = shapeArr
                self.delegate?.didselectOption(searchTitle: "Shape", details: [], shapeArr: shapeArr)
            }
            else{
                self.delegate?.didselectOption(searchTitle: "Shape", details: [], shapeArr: [])
            }
        }
    }
}
