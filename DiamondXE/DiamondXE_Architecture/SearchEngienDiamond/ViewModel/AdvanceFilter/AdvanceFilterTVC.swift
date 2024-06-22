//
//  AdvanceFilterTVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 05/06/24.
//

import UIKit
import DropDown

class AdvanceFilterTVC: UITableViewCell, UITextFieldDelegate {
    
    static let cellIdentifierAdvanceFilTVC = String(describing: AdvanceFilterTVC.self)
    
    @IBOutlet var collectionCut:UICollectionView!
    @IBOutlet var collectionPlolish:UICollectionView!
    @IBOutlet var collectionSymmetry:UICollectionView!
    @IBOutlet var collectionTech:UICollectionView!
    
    @IBOutlet var collectionEyeClan:UICollectionView!
    @IBOutlet var collectionShade:UICollectionView!
    @IBOutlet var collectionLuster:UICollectionView!
    
    @IBOutlet var lblIntencity:UILabel!
    @IBOutlet var intencityView:UIView!
    
    @IBOutlet var lblOvertone:UILabel!
    @IBOutlet var overtoneView:UIView!
    
    @IBOutlet var lblTablePerFrome:UILabel!
    @IBOutlet var tablePerFromeView:UIView!
    
    @IBOutlet var lblTablePerTo:UILabel!
    @IBOutlet var tablePerToView:UIView!
    
    @IBOutlet var lblDepthPerFrome:UILabel!
    @IBOutlet var depthPerFromeView:UIView!
    
    @IBOutlet var lblDepthPerTo:UILabel!
    @IBOutlet var depthPerToView:UIView!
    
    @IBOutlet var lblPavillionPerFrome:UILabel!
    @IBOutlet var pavillionPerFromeView:UIView!
    
    @IBOutlet var lblPavillionPerTo:UILabel!
    @IBOutlet var pavillionPerToView:UIView!
    
    @IBOutlet var lblCrownPerFrome:UILabel!
    @IBOutlet var crownPerFromeView:UIView!
    
    @IBOutlet var lblCrownPerTo:UILabel!
    @IBOutlet var crownPerToView:UIView!
    
    @IBOutlet var txtlengthTo:UITextField!
    @IBOutlet var txtWidthTo:UITextField!
    @IBOutlet var txtDepthTo:UITextField!
    @IBOutlet var txtlengthFrom:UITextField!
    @IBOutlet var txtWidthFrom:UITextField!
    @IBOutlet var txtDepthFrom:UITextField!
    @IBOutlet var txtLotID:UITextField!
    @IBOutlet var txtLocation:UITextField!
    
    
    
    let dropDown = DropDown()

    var dataArrCut : [SearchAttribDetail]?
    var dataArrPolish : [SearchAttribDetail]?
    var dataArrSymmetry: [SearchAttribDetail]?
    var dataArrTech: [SearchAttribDetail]?
    var dataArrIntencity: [SearchAttribDetail]?
    
    var dataArrOvertone: [SearchAttribDetail]?
    var dataArrTablePer: [SearchAttribDetail]?
    var dataArrDepthPer: [SearchAttribDetail]?
    var dataArrCrown: [SearchAttribDetail]?
    var dataArrPavillion: [SearchAttribDetail]?
    var dataArrEyeClean: [SearchAttribDetail]?
    var dataArrShade: [SearchAttribDetail]?
    var dataArrLuster: [SearchAttribDetail]?
    
    var selectedIndicesCut: Set<IndexPath> = []
    var selectedIndicesPolish: Set<IndexPath> = []
    var selectedIndicesSymmetry: Set<IndexPath> = []
    var selectedIndicesEyeClean: Set<IndexPath> = []
    var selectedIndicesShade: Set<IndexPath> = []
    var selectedIndicesLuster: Set<IndexPath> = []
    var selectedIndicesTech: Set<IndexPath> = []
    
    
    var searchAttriStruct =  SearchOptionDataStruct()
    
    var selectedDataArrCut = [SearchAttribDetail]()
    var selectedDataArrPolish = [SearchAttribDetail]()
    var selectedDataArrSymmetry = [SearchAttribDetail]()
    var selectedDataArrIntencity = [SearchAttribDetail]()
    
    var selectedDataArrOvertone = [SearchAttribDetail]()
    var selectedDataArrTablePerFrom = [SearchAttribDetail]()
    var selectedDataArrTablePerTo = [SearchAttribDetail]()

    var selectedDataArrDepthPerFrom = [SearchAttribDetail]()
    var selectedDataArrDepthPerTo = [SearchAttribDetail]()

    var selectedDataArrCrownFrom = [SearchAttribDetail]()
    var selectedDataArrPavillionFrom = [SearchAttribDetail]()
    var selectedDataArrCrownTo = [SearchAttribDetail]()
    var selectedDataArrPavillionTo = [SearchAttribDetail]()
    
    var selectedDataArrEyeClean = [SearchAttribDetail]()
    var selectedDataArrShade = [SearchAttribDetail]()
    var selectedDataArrTech = [SearchAttribDetail]()
    var selectedDataArrLuster = [SearchAttribDetail]()
    
    var textData = [SearchAttribDetail]()

    
    var delegate : SearchOptionSelecteDelegate?

    
    public var height: CGFloat? {
           didSet { setNeedsUpdateConstraints() }
     }


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        txtlengthTo.delegate = self
        txtWidthTo.delegate = self
        txtDepthTo.delegate = self
        txtlengthFrom.delegate = self
        txtWidthFrom.delegate = self
        txtDepthFrom.delegate = self
        txtLotID.delegate = self
        txtLocation.delegate = self
        configureCollectionView(collectionCut)
        configureCollectionView(collectionPlolish)
        configureCollectionView(collectionSymmetry)
        configureCollectionView(collectionTech)
        configureCollectionView(collectionShade)
        configureCollectionView(collectionEyeClan)
        configureCollectionView(collectionLuster)
        
        collectionCut.register(UINib(nibName: FilterCVC.cellIdentifierAdvanceFilCVC, bundle: nil), forCellWithReuseIdentifier: FilterCVC.cellIdentifierAdvanceFilCVC)
        collectionPlolish.register(UINib(nibName: FilterCVC.cellIdentifierAdvanceFilCVC, bundle: nil), forCellWithReuseIdentifier: FilterCVC.cellIdentifierAdvanceFilCVC)
        collectionSymmetry.register(UINib(nibName: FilterCVC.cellIdentifierAdvanceFilCVC, bundle: nil), forCellWithReuseIdentifier: FilterCVC.cellIdentifierAdvanceFilCVC)
        collectionTech.register(UINib(nibName: FilterCVC.cellIdentifierAdvanceFilCVC, bundle: nil), forCellWithReuseIdentifier: FilterCVC.cellIdentifierAdvanceFilCVC)
        
        collectionEyeClan.register(UINib(nibName: FilterCVC.cellIdentifierAdvanceFilCVC, bundle: nil), forCellWithReuseIdentifier: FilterCVC.cellIdentifierAdvanceFilCVC)
        
        collectionShade.register(UINib(nibName: FilterCVC.cellIdentifierAdvanceFilCVC, bundle: nil), forCellWithReuseIdentifier: FilterCVC.cellIdentifierAdvanceFilCVC)
        
        collectionLuster.register(UINib(nibName: FilterCVC.cellIdentifierAdvanceFilCVC, bundle: nil), forCellWithReuseIdentifier: FilterCVC.cellIdentifierAdvanceFilCVC)
       
        
        let tapGestureIntencity = UITapGestureRecognizer(target: self, action: #selector(handleIntencityTap))
        lblIntencity.isUserInteractionEnabled = true
        lblIntencity.addGestureRecognizer(tapGestureIntencity)
        
        let tapGestureOvertone = UITapGestureRecognizer(target: self, action: #selector(handleOvertoneTap))
        lblOvertone.isUserInteractionEnabled = true
        lblOvertone.addGestureRecognizer(tapGestureOvertone)
        
        let tapGestureTableFrom = UITapGestureRecognizer(target: self, action: #selector(handleTablePerFromTap))
        lblTablePerFrome.isUserInteractionEnabled = true
        lblTablePerFrome.addGestureRecognizer(tapGestureTableFrom)
        
        let tapGestureTableTo = UITapGestureRecognizer(target: self, action: #selector(handleTablePerToTap))
        lblTablePerTo.isUserInteractionEnabled = true
        lblTablePerTo.addGestureRecognizer(tapGestureTableTo)
        
        let tapGestureDepthFrom = UITapGestureRecognizer(target: self, action: #selector(handleDepthPerFromTap))
        lblDepthPerFrome.isUserInteractionEnabled = true
        lblDepthPerFrome.addGestureRecognizer(tapGestureDepthFrom)
        
        let tapGestureDepthTo = UITapGestureRecognizer(target: self, action: #selector(handleDepthPerToTap))
        lblDepthPerTo.isUserInteractionEnabled = true
        lblDepthPerTo.addGestureRecognizer(tapGestureDepthTo)
        
        let tapGestureCrownFrom = UITapGestureRecognizer(target: self, action: #selector(handleCrownFromTap))
        lblCrownPerFrome.isUserInteractionEnabled = true
        lblCrownPerFrome.addGestureRecognizer(tapGestureCrownFrom)
        
        let tapGestureCrownTo = UITapGestureRecognizer(target: self, action: #selector(handleCrownTOTap))
        lblCrownPerTo.isUserInteractionEnabled = true
        lblCrownPerTo.addGestureRecognizer(tapGestureCrownTo)
        
        let tapGesturePavillionFrom = UITapGestureRecognizer(target: self, action: #selector(handleDepthPavllionFromTap))
        lblPavillionPerFrome.isUserInteractionEnabled = true
        lblPavillionPerFrome.addGestureRecognizer(tapGesturePavillionFrom)
        
        let tapGesturePavillionTo = UITapGestureRecognizer(target: self, action: #selector(handleDepthPavllionTOTap))
        lblPavillionPerTo.isUserInteractionEnabled = true
        lblPavillionPerTo.addGestureRecognizer(tapGesturePavillionTo)

        //cler all data
//        clerAll()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
//           if let text = textField.tag {
        self.textData.removeAll()
        switch textField.tag {
        case 1:
            var dataArr = SearchAttribDetail()
            dataArr.displayAttr = textField.text ?? ""
            self.textData.append(dataArr)
            self.delegate?.didselectOption(searchTitle: "LengthFrom", details: self.textData, shapeArr: [])
        case 2:
            var dataArr = SearchAttribDetail()
            dataArr.displayAttr = textField.text ?? ""
            self.textData.append(dataArr)
            self.delegate?.didselectOption(searchTitle: "LengthTo", details: self.textData, shapeArr: [])
        case 3:
            var dataArr = SearchAttribDetail()
            dataArr.displayAttr = textField.text ?? ""
            self.textData.append(dataArr)
            self.delegate?.didselectOption(searchTitle: "WidthFrom", details: self.textData, shapeArr: [])
        case 4:
            var dataArr = SearchAttribDetail()
            dataArr.displayAttr = textField.text ?? ""
            self.textData.append(dataArr)
            self.delegate?.didselectOption(searchTitle: "WidthTo", details: self.textData, shapeArr: [])
        case 5:
            var dataArr = SearchAttribDetail()
            dataArr.displayAttr = textField.text ?? ""
            self.textData.append(dataArr)
            self.delegate?.didselectOption(searchTitle: "DepthFrom", details: self.textData, shapeArr: [])
        case 6:
            var dataArr = SearchAttribDetail()
            dataArr.displayAttr = textField.text ?? ""
            self.textData.append(dataArr)
            self.delegate?.didselectOption(searchTitle: "DepthTo ", details: self.textData, shapeArr: [])
        case 7:
            var dataArr = SearchAttribDetail()
            dataArr.displayAttr = textField.text ?? ""
            self.textData.append(dataArr)
            self.delegate?.didselectOption(searchTitle: "LotID", details: self.textData, shapeArr: [])
        case 8:
            var dataArr = SearchAttribDetail()
            dataArr.displayAttr = textField.text ?? ""
            self.textData.append(dataArr)
            self.delegate?.didselectOption(searchTitle: "Location", details: self.textData, shapeArr: [])
        default:
            print(textField.text)
        }
//           }
       }
    
    
    
    func configureCollectionView(_ collectionView: UICollectionView) {
           collectionView.showsHorizontalScrollIndicator = false
           collectionView.showsVerticalScrollIndicator = false
           collectionView.allowsMultipleSelection = true
           collectionView.delegate = self
           collectionView.dataSource = self
           collectionView.collectionViewLayout = createLeftAlignedLayout()
           collectionView.isScrollEnabled = false

       }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func clerAll(){
        selectedDataArrCut.removeAll()
        selectedDataArrPolish.removeAll()
        selectedDataArrSymmetry.removeAll()
        selectedDataArrIntencity.removeAll()
        
        selectedDataArrOvertone.removeAll()
        selectedDataArrTablePerFrom.removeAll()
        selectedDataArrTablePerTo.removeAll()

        selectedDataArrDepthPerFrom.removeAll()
        selectedDataArrDepthPerTo.removeAll()

        selectedDataArrCrownFrom.removeAll()
        selectedDataArrPavillionFrom.removeAll()
        selectedDataArrCrownTo.removeAll()
        selectedDataArrPavillionTo.removeAll()
        
        selectedDataArrEyeClean.removeAll()
        selectedDataArrShade.removeAll()
        selectedDataArrTech.removeAll()
        selectedDataArrLuster.removeAll()
        
        selectedIndicesCut.removeAll()
        selectedIndicesPolish.removeAll()
        selectedIndicesSymmetry.removeAll()
        selectedIndicesEyeClean.removeAll()
        selectedIndicesShade.removeAll()
        selectedIndicesLuster.removeAll()
        selectedIndicesTech.removeAll()
    }
    
    
    func setupBtnLogicForDia(attributID:Int){
        
            switch attributID {
            case 1:
                self.dataArrCut?.enumerated().forEach { (index, detail) in
                    if index == 0 || index == 1  {
                        self.selectedDataArrCut.append(detail)
                        let itemIndex = index
                        let indexPath = IndexPath(item: itemIndex, section: 0)
                        selectedIndicesCut.insert(indexPath)
                        
                    }
                    delegate?.didselectOption(searchTitle: "Cut", details: selectedDataArrCut, shapeArr: [])
                    self.collectionCut.reloadData()
                }
                self.dataArrPolish?.enumerated().forEach { (index, detail) in
                    if index == 0  {
                        self.selectedDataArrPolish.append(detail)
                        let itemIndex = index
                        let indexPath = IndexPath(item: itemIndex, section: 0)
                        selectedIndicesPolish.insert(indexPath)
                        
                    }
                    delegate?.didselectOption(searchTitle: "Polish", details: selectedDataArrCut, shapeArr: [])
                    self.collectionPlolish.reloadData()
                }
                
                self.dataArrSymmetry?.enumerated().forEach { (index, detail) in
                    if index == 0 {
                        self.selectedDataArrSymmetry.append(detail)
                        let itemIndex = index
                        let indexPath = IndexPath(item: itemIndex, section: 0)
                        selectedIndicesSymmetry.insert(indexPath)
                        
                    }
                    delegate?.didselectOption(searchTitle: "Symmetry", details: selectedDataArrCut, shapeArr: [])
                    self.collectionSymmetry.reloadData()
                }
                
            case 2:
                self.dataArrCut?.enumerated().forEach { (index, detail) in
                    if index == 1  {
                        self.selectedDataArrCut.append(detail)
                        let itemIndex = index
                        let indexPath = IndexPath(item: itemIndex, section: 0)
                        selectedIndicesCut.insert(indexPath)
                        
                    }
                    delegate?.didselectOption(searchTitle: "Symmetry", details: selectedDataArrCut, shapeArr: [])
                    self.collectionCut.reloadData()
                }
                self.dataArrPolish?.enumerated().forEach { (index, detail) in
                    if index == 0 || index == 1  {
                        self.selectedDataArrPolish.append(detail)
                        let itemIndex = index
                        let indexPath = IndexPath(item: itemIndex, section: 0)
                        selectedIndicesPolish.insert(indexPath)
                        
                    }
                    delegate?.didselectOption(searchTitle: "Polish", details: selectedDataArrCut, shapeArr: [])
                    self.collectionPlolish.reloadData()
                }
                
                self.dataArrSymmetry?.enumerated().forEach { (index, detail) in
                    if index == 0 || index == 1 {
                        self.selectedDataArrSymmetry.append(detail)
                        let itemIndex = index
                        let indexPath = IndexPath(item: itemIndex, section: 0)
                        selectedIndicesSymmetry.insert(indexPath)
                        
                    }
                    delegate?.didselectOption(searchTitle: "Symmetry", details: selectedDataArrCut, shapeArr: [])
                    self.collectionSymmetry.reloadData()
                }
                
            case 3:
                self.dataArrCut?.enumerated().forEach { (index, detail) in
                    if index == 2 || index == 1  {
                        self.selectedDataArrCut.append(detail)
                        let itemIndex = index
                        let indexPath = IndexPath(item: itemIndex, section: 0)
                        selectedIndicesCut.insert(indexPath)
                        
                    }
                    delegate?.didselectOption(searchTitle: "Cut", details: selectedDataArrCut, shapeArr: [])
                    self.collectionCut.reloadData()
                }
                self.dataArrPolish?.enumerated().forEach { (index, detail) in
                    if index == 0 || index == 1  {
                        self.selectedDataArrPolish.append(detail)
                        let itemIndex = index
                        let indexPath = IndexPath(item: itemIndex, section: 0)
                        selectedIndicesPolish.insert(indexPath)
                        
                    }
                    delegate?.didselectOption(searchTitle: "Polish", details: selectedDataArrCut, shapeArr: [])
                    self.collectionPlolish.reloadData()
                }
                
                self.dataArrSymmetry?.enumerated().forEach { (index, detail) in
                    if index == 0 || index == 1 {
                        self.selectedDataArrSymmetry.append(detail)
                        let itemIndex = index
                        let indexPath = IndexPath(item: itemIndex, section: 0)
                        selectedIndicesSymmetry.insert(indexPath)
                        
                    }
                    delegate?.didselectOption(searchTitle: "Symmetry", details: selectedDataArrCut, shapeArr: [])
                    self.collectionSymmetry.reloadData()
                }
            default:
                print("")
                
            }
    }
    
    
    
    func filterDataStruct(searchAttributeStruct:SearchOptionDataStruct){
        
        searchAttributeStruct.details?.forEach { attributeData in
            
            if attributeData.attribType == attributeTypeCut{
                self.dataArrCut = attributeData.attribDetails
                self.collectionCut.reloadData()
            }
            
            if attributeData.attribType == attributeTypePolish{
                self.dataArrPolish = attributeData.attribDetails
                self.collectionPlolish.reloadData()
            }
            
            if attributeData.attribType == attributeTypeTechnology{
                self.dataArrTech = attributeData.attribDetails
                self.collectionTech.reloadData()
            }
            
            if attributeData.attribType == attributeTypSymmetry{
                self.dataArrSymmetry = attributeData.attribDetails
                self.collectionSymmetry.reloadData()
            }
            
            if attributeData.attribType == attributeTypeIntensity{
                self.dataArrIntencity = attributeData.attribDetails
            }
            
            if attributeData.attribType == attributeTypeEyeClean{
                self.dataArrEyeClean = attributeData.attribDetails
                self.collectionEyeClan.reloadData()
            }
            
            if attributeData.attribType == attributeTypeShade{
                self.dataArrShade = attributeData.attribDetails
                self.collectionShade.reloadData()
            }
            
            if attributeData.attribType == attributeTypeLuster{
                self.dataArrLuster = attributeData.attribDetails
                self.collectionLuster.reloadData()
            }
            
            
            if attributeData.attribType == attributeTypeOvertone{
                self.dataArrOvertone = attributeData.attribDetails
            }
            
            if attributeData.attribType == attributeTypTablePer{
                self.dataArrTablePer = attributeData.attribDetails
            }
            
            if attributeData.attribType == attributeTypeDepthPer{
                self.dataArrDepthPer = attributeData.attribDetails
            }
            
            if attributeData.attribType == attributeTypeCrown{
                self.dataArrCrown = attributeData.attribDetails
            }
            
            if attributeData.attribType == attributeTypePavillion{
                self.dataArrPavillion = attributeData.attribDetails
            }
           
        }
        
    }
    
    
    @IBAction func btnActionDropDown(_ sender :UIButton){
        
    }
    
    @objc private func handleIntencityTap() {
          
        var intencityTitle = [String]()
        self.dataArrIntencity?.forEach { attributeData in
            intencityTitle.append(attributeData.displayAttr ?? "")
           
        }
        intencityTitle.append("")
        intencityTitle.append("")
        intencityTitle.append("")
//        intencityTitle.append("")
//        intencityTitle.append("")

        openDropDown(dataArr: intencityTitle, anchorView: self.intencityView, titleLabel: lblIntencity, refr: "FCIntencity")
       
       }
    
    @objc private func handleOvertoneTap() {
          
        var overtoneTitle = [String]()
        self.dataArrOvertone?.forEach { attributeData in
            overtoneTitle.append(attributeData.displayAttr ?? "")
        }
        openDropDown(dataArr: overtoneTitle, anchorView: overtoneView, titleLabel: lblOvertone, refr: "FCOvertone")
       }
    
    @objc private func handleTablePerFromTap() {
          
        var tablePerTitle = [String]()
        self.dataArrTablePer?.forEach { attributeData in
            tablePerTitle.append(attributeData.displayAttr ?? "")
        }
        openDropDown(dataArr: tablePerTitle, anchorView: tablePerFromeView, titleLabel: lblTablePerFrome, refr: "TabplePerFrom")
       }
    
    @objc private func handleTablePerToTap() {
          
        var tablePerTitle = [String]()
        self.dataArrTablePer?.forEach { attributeData in
            tablePerTitle.append(attributeData.displayAttr ?? "")
        }
        openDropDown(dataArr: tablePerTitle, anchorView: tablePerToView, titleLabel: lblTablePerTo, refr: "TablePerTo")
       }
    
    @objc private func handleDepthPerFromTap() {
          
        var depthPerTitle = [String]()
        self.dataArrDepthPer?.forEach { attributeData in
            depthPerTitle.append(attributeData.displayAttr ?? "")
        }
        openDropDown(dataArr: depthPerTitle, anchorView: depthPerFromeView, titleLabel: lblDepthPerFrome, refr: "DepthPerFrom")
       }
    
    @objc private func handleDepthPerToTap() {
          
        var depthPerTitle = [String]()
        self.dataArrDepthPer?.forEach { attributeData in
            depthPerTitle.append(attributeData.displayAttr ?? "")
        }
        openDropDown(dataArr: depthPerTitle, anchorView: depthPerToView, titleLabel: self.lblDepthPerTo, refr: "DepthPerTo")
       }
    
    @objc private func handleCrownFromTap() {
          
        var crownTitle = [String]()
        self.dataArrCrown?.forEach { attributeData in
            crownTitle.append(attributeData.displayAttr ?? "")
        }
        openDropDown(dataArr: crownTitle, anchorView: crownPerFromeView, titleLabel: self.lblCrownPerFrome, refr: "CrownFrom")
       }
    
    @objc private func handleCrownTOTap() {
          
        var crownTitle = [String]()
        self.dataArrCrown?.forEach { attributeData in
            crownTitle.append(attributeData.displayAttr ?? "")
        }
        openDropDown(dataArr: crownTitle, anchorView: crownPerToView, titleLabel: self.lblCrownPerTo, refr: "CrownTo")
       }
    
    @objc private func handleDepthPavllionFromTap() {
          
        var pavllionTitle = [String]()
        self.dataArrPavillion?.forEach { attributeData in
            pavllionTitle.append(attributeData.displayAttr ?? "")
        }
        openDropDown(dataArr: pavllionTitle, anchorView: pavillionPerFromeView, titleLabel: self.lblPavillionPerFrome, refr: "PavllionFrom")
       }
    
    @objc private func handleDepthPavllionTOTap() {
          
        var pavllionTitle = [String]()
        self.dataArrPavillion?.forEach { attributeData in
            pavllionTitle.append(attributeData.displayAttr ?? "")
        }
        openDropDown(dataArr: pavllionTitle, anchorView: pavillionPerToView, titleLabel: self.lblPavillionPerTo, refr: "PavllionTo")
       }
    
    
    
    func openDropDown(dataArr:[String], anchorView:UIView, titleLabel:UILabel, refr:String){
        dropDown.anchorView = anchorView
        dropDown.dataSource = dataArr
        dropDown.backgroundColor = .whitClr
        dropDown.selectionBackgroundColor = UIColor(red: 0.6494, green: 0.8155, blue: 1.0, alpha: 0.2)
        dropDown.shadowColor = UIColor(white: 0.6, alpha: 1)
        dropDown.shadowOpacity = 0.7
        dropDown.shadowRadius = 15
        dropDown.cellHeight = 40
        dropDown.height = 250
//        dropDown.bottomOffset = CGPoint(x: 0, y: anchorView.bounds.height)
        if dropDown.dataSource.count > 10 {
                   dropDown.dismissMode = .onTap
                   dropDown.reloadAllComponents()
               }

        
//        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.topOffset = CGPoint(x: 0, y:-(dropDown.anchorView?.plainView.bounds.height)!)

        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            titleLabel.text = dataArr[index]
            setDataByDropDown(title: refr, index: index)
            dropDown.hide()
            
        }
        dropDown.show()
    }
    
    
    //"PavllionTo"PavllionFrom"CrownTo"Crown From"DepthPerTo"DepthPerFromTablePerToTabplePerFromFCOvertone""
    func setDataByDropDown(title:String, index:Int){
        switch title {
        case "FCIntencity":
            if let selectData = self.dataArrIntencity?[index]{
                selectedDataArrIntencity.append(selectData)

            }
            if self.selectedDataArrIntencity.count > 0{
                self.delegate?.didselectOption(searchTitle: title, details: selectedDataArrIntencity, shapeArr: [""])
            }
        case "FCOvertone":
            if let selectData = self.dataArrOvertone?[index]{
                selectedDataArrOvertone.append(selectData)

            }
            if self.selectedDataArrOvertone.count > 0{
                self.delegate?.didselectOption(searchTitle: title, details: selectedDataArrOvertone, shapeArr: [""])
            }
        case "TabplePerFrom":
            if let selectData = self.dataArrTablePer?[index]{
                selectedDataArrTablePerFrom.append(selectData)

            }
            if self.selectedDataArrTablePerFrom.count > 0{
                self.delegate?.didselectOption(searchTitle: title, details: selectedDataArrTablePerFrom, shapeArr: [""])
            }
        case "TabplePerTo":
            if let selectData = self.dataArrTablePer?[index]{
                selectedDataArrTablePerTo.append(selectData)

            }
            if self.selectedDataArrTablePerTo.count > 0{
                self.delegate?.didselectOption(searchTitle: title, details: selectedDataArrTablePerTo, shapeArr: [""])
            }
        case "DepthPerFrom":
            if let selectData = self.dataArrDepthPer?[index]{
                selectedDataArrDepthPerFrom.append(selectData)

            }
            if self.selectedDataArrDepthPerFrom.count > 0{
                self.delegate?.didselectOption(searchTitle: title, details: selectedDataArrDepthPerFrom, shapeArr: [""])
            }
        case "DepthPerTo":
            if let selectData = self.dataArrDepthPer?[index]{
                selectedDataArrDepthPerTo.append(selectData)

            }
            if self.selectedDataArrDepthPerTo.count > 0{
                self.delegate?.didselectOption(searchTitle: title, details: selectedDataArrDepthPerTo, shapeArr: [""])
            }
        case "CrownFrom":
            if let selectData = self.dataArrCrown?[index]{
                selectedDataArrCrownFrom.append(selectData)

            }
            if self.selectedDataArrCrownFrom.count > 0{
                self.delegate?.didselectOption(searchTitle: title, details: selectedDataArrCrownFrom, shapeArr: [""])
            }
        case "CrownTo":
            if let selectData = self.dataArrCrown?[index]{
                selectedDataArrCrownTo.append(selectData)

            }
            if self.selectedDataArrCrownTo.count > 0{
                self.delegate?.didselectOption(searchTitle: title, details: selectedDataArrCrownTo, shapeArr: [""])
            }
        case "PavllionFrom":
            if let selectData = self.dataArrPavillion?[index]{
                selectedDataArrPavillionFrom.append(selectData)

            }
            if self.selectedDataArrPavillionFrom.count > 0{
                self.delegate?.didselectOption(searchTitle: title, details: selectedDataArrPavillionFrom, shapeArr: [""])
            }
        case "PavllionTo":
            if let selectData = self.dataArrPavillion?[index]{
                selectedDataArrPavillionTo.append(selectData)

            }
            if self.selectedDataArrPavillionFrom.count > 0{
                self.delegate?.didselectOption(searchTitle: title, details: selectedDataArrPavillionTo, shapeArr: [""])
            }
        default:
            print(title)
        }
    }
    
    
  
}


extension AdvanceFilterTVC:UICollectionViewDelegate, UICollectionViewDataSource, AdvanceOptionsCVCellDelegate{
    func titleTappedCell(in cell: FilterCVC, category: String) {
        print(category)
        switch category {
        case "CUT":
            if let indexPath = collectionCut.indexPath(for: cell) {
                if selectedIndicesCut.contains(indexPath) {
                    selectedIndicesCut.remove(indexPath)
                    
                    if let selectData = dataArrCut?[indexPath.row]{
                        self.selectedDataArrCut.enumerated().forEach { index, item in
                            if selectData.attribID == item.attribID{
                                self.selectedDataArrCut.remove(at: index)
                            }
                            
                        }
                        
                    }
                    
                    cell.isGradientApplied = false
                } else {
                    selectedIndicesCut.insert(indexPath)
                    if let selectData = dataArrCut?[indexPath.row]{
                        self.selectedDataArrCut.append(selectData)
                    }
                    cell.isGradientApplied = true
                }
                
                if self.selectedDataArrCut.count > 0{
                    self.delegate?.didselectOption(searchTitle: "Cut", details: selectedDataArrCut, shapeArr: [""])
                }
            }
        case "POLISH":
            if let indexPath = collectionPlolish.indexPath(for: cell) {
                if selectedIndicesPolish.contains(indexPath) {
                    selectedIndicesPolish.remove(indexPath)
                    if let selectData = dataArrPolish?[indexPath.row]{
                        self.selectedDataArrPolish.enumerated().forEach { index, item in
                            if selectData.attribID == item.attribID{
                                self.selectedDataArrPolish.remove(at: index)
                            }
                            
                        }
                        
                    }
                    cell.isGradientApplied = false
                } else {
                    selectedIndicesPolish.insert(indexPath)
                    if let selectData = dataArrPolish?[indexPath.row]{
                        self.selectedDataArrPolish.append(selectData)
                    }
                    cell.isGradientApplied = true
                }
                if self.selectedDataArrPolish.count > 0{
                    self.delegate?.didselectOption(searchTitle: "Polish", details: selectedDataArrPolish, shapeArr: [""])
                }
            }
        case "SYMMETRY":
            if let indexPath = collectionSymmetry.indexPath(for: cell) {
                if selectedIndicesSymmetry.contains(indexPath) {
                    selectedIndicesSymmetry.remove(indexPath)
                    if let selectData = dataArrSymmetry?[indexPath.row]{
                        self.selectedDataArrSymmetry.enumerated().forEach { index, item in
                            if selectData.attribID == item.attribID{
                                self.selectedDataArrSymmetry.remove(at: index)
                            }
                            
                        }
                        
                    }
                    cell.isGradientApplied = false
                } else {
                    selectedIndicesSymmetry.insert(indexPath)
                    if let selectData = dataArrSymmetry?[indexPath.row]{
                        self.selectedDataArrSymmetry.append(selectData)
                    }
                    cell.isGradientApplied = true
                }
                
                if self.selectedDataArrSymmetry.count > 0{
                    self.delegate?.didselectOption(searchTitle: "Symmerty", details: selectedDataArrSymmetry, shapeArr: [""])
                }
            }
        case "TECHNOLOGY":
            if let indexPath = collectionTech.indexPath(for: cell) {
                if selectedIndicesTech.contains(indexPath) {
                    selectedIndicesTech.remove(indexPath)
                    if let selectData = dataArrTech?[indexPath.row]{
                        self.selectedDataArrTech.enumerated().forEach { index, item in
                            if selectData.attribID == item.attribID{
                                self.selectedDataArrSymmetry.remove(at: index)
                            }
                            
                        }
                        
                    }
                    cell.isGradientApplied = false
                } else {
                    selectedIndicesTech.insert(indexPath)
                    if let selectData = dataArrTech?[indexPath.row]{
                        self.selectedDataArrTech.append(selectData)
                    }
                    cell.isGradientApplied = true
                }
                if self.selectedDataArrTech.count > 0{
                    self.delegate?.didselectOption(searchTitle: "Technology", details: selectedDataArrTech, shapeArr: [""])
                }
            }
        case "SHADE":
            if let indexPath = collectionShade.indexPath(for: cell) {
                if selectedIndicesShade.contains(indexPath) {
                    selectedIndicesShade.remove(indexPath)
                    if let selectData = dataArrShade?[indexPath.row]{
                        self.selectedDataArrShade.enumerated().forEach { index, item in
                            if selectData.attribID == item.attribID{
                                self.selectedDataArrShade.remove(at: index)
                            }
                            
                        }
                        
                    }
                    cell.isGradientApplied = false
                } else {
                    selectedIndicesShade.insert(indexPath)
                    if let selectData = dataArrShade?[indexPath.row]{
                        self.selectedDataArrShade.append(selectData)
                    }
                    cell.isGradientApplied = true
                }
                if self.selectedDataArrShade.count > 0{
                    self.delegate?.didselectOption(searchTitle: "Shade", details: selectedDataArrShade, shapeArr: [""])
                }
            }
        case "EYECLAN":
            if let indexPath = collectionEyeClan.indexPath(for: cell) {
                if selectedIndicesEyeClean.contains(indexPath) {
                    selectedIndicesEyeClean.remove(indexPath)
                    if let selectData = dataArrEyeClean?[indexPath.row]{
                        self.selectedDataArrEyeClean.enumerated().forEach { index, item in
                            if selectData.attribID == item.attribID{
                                self.selectedDataArrEyeClean.remove(at: index)
                            }
                            
                        }
                        
                    }
                    cell.isGradientApplied = false
                } else {
                    selectedIndicesEyeClean.insert(indexPath)
                    if let selectData = dataArrEyeClean?[indexPath.row]{
                        self.selectedDataArrEyeClean.append(selectData)
                    }
                    cell.isGradientApplied = true
                }
                if self.selectedDataArrEyeClean.count > 0{
                    self.delegate?.didselectOption(searchTitle: "EyeClean", details: selectedDataArrEyeClean, shapeArr: [""])
                }
            }
        case "LUSTER":
            if let indexPath = collectionLuster.indexPath(for: cell) {
                if selectedIndicesLuster.contains(indexPath) {
                    selectedIndicesLuster.remove(indexPath)
                    if let selectData = dataArrLuster?[indexPath.row]{
                        self.selectedDataArrLuster.enumerated().forEach { index, item in
                            if selectData.attribID == item.attribID{
                                self.selectedDataArrLuster.remove(at: index)
                            }
                            
                        }
                        
                    }
                    cell.isGradientApplied = false
                } else {
                    selectedIndicesLuster.insert(indexPath)
                    if let selectData = dataArrEyeClean?[indexPath.row]{
                        self.selectedDataArrEyeClean.append(selectData)
                    }
                    cell.isGradientApplied = true
                }
                
                if self.selectedDataArrLuster.count > 0{
                    self.delegate?.didselectOption(searchTitle: "Luster", details: selectedDataArrLuster, shapeArr: [""])
                }
            }
        default:
            print("")
        }
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView {
        case self.collectionCut:
            return self.dataArrCut?.count ?? 0
        case self.collectionPlolish:
            return self.dataArrPolish?.count ?? 0
        case self.collectionSymmetry:
            return self.dataArrSymmetry?.count ?? 0
        case self.collectionTech:
            return self.dataArrTech?.count ?? 0
        case self.collectionShade:
            return self.dataArrShade?.count ?? 0
        case self.collectionEyeClan:
            return self.dataArrEyeClean?.count ?? 0
        case self.collectionLuster:
            return self.dataArrLuster?.count ?? 0
        default:
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterCVC.cellIdentifierAdvanceFilCVC, for: indexPath) as! FilterCVC
        cell.delegate = self
        switch collectionView {
        case self.collectionCut:
            cell.lblTitle.text = self.dataArrCut?[indexPath.row].displayAttr
            cell.categoryStr = "CUT"
            cell.isGradientApplied = selectedIndicesCut.contains(indexPath)
        case self.collectionPlolish:
            cell.lblTitle.text = self.dataArrPolish?[indexPath.row].displayAttr
            cell.categoryStr = "POLISH"
            cell.isGradientApplied = selectedIndicesPolish.contains(indexPath)

        case self.collectionSymmetry:
            cell.lblTitle.text = self.dataArrSymmetry?[indexPath.row].displayAttr
            cell.categoryStr = "SYMMETRY"
            cell.isGradientApplied = selectedIndicesSymmetry.contains(indexPath)

        case self.collectionTech:
            cell.lblTitle.text = self.dataArrTech?[indexPath.row].displayAttr
            cell.categoryStr = "TECHNOLOGY"
            cell.isGradientApplied = selectedIndicesTech.contains(indexPath)


        case self.collectionShade:
            cell.lblTitle.text = self.dataArrShade?[indexPath.row].displayAttr
            cell.categoryStr = "SHADE"
            cell.isGradientApplied = selectedIndicesShade.contains(indexPath)


        case self.collectionEyeClan:
            cell.lblTitle.text = self.dataArrEyeClean?[indexPath.row].displayAttr
            cell.categoryStr = "EYECLAN"
            cell.isGradientApplied = selectedIndicesEyeClean.contains(indexPath)

        case self.collectionLuster:
            cell.lblTitle.text = self.dataArrLuster?[indexPath.row].displayAttr
            cell.categoryStr = "LUSTER"
            cell.isGradientApplied = selectedIndicesLuster.contains(indexPath)


        default:
           print("Nothing")
        }

        return cell
    }


    private func createLeftAlignedLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
                widthDimension: .estimated(45),
                heightDimension: .absolute(50)
            )
            
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
            
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(50)
            )
            
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: groupSize,
                subitems: [item]
            )
            
            group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
            group.interItemSpacing = .fixed(6)
        
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 6
            section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0)
            
            return UICollectionViewCompositionalLayout(section: section)
        }
    
 
    
}
