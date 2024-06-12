//
//  AdvanceFilterTVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 05/06/24.
//

import UIKit
import DropDown

class AdvanceFilterTVC: UITableViewCell {
    
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
    

    
    public var height: CGFloat? {
           didSet { setNeedsUpdateConstraints() }
     }


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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

        openDropDown(dataArr: intencityTitle, anchorView: self.intencityView, titleLabel: lblIntencity)
       
       }
    
    @objc private func handleOvertoneTap() {
          
        var overtoneTitle = [String]()
        self.dataArrOvertone?.forEach { attributeData in
            overtoneTitle.append(attributeData.displayAttr ?? "")
        }
        openDropDown(dataArr: overtoneTitle, anchorView: overtoneView, titleLabel: lblOvertone)
       }
    
    @objc private func handleTablePerFromTap() {
          
        var tablePerTitle = [String]()
        self.dataArrTablePer?.forEach { attributeData in
            tablePerTitle.append(attributeData.displayAttr ?? "")
        }
        openDropDown(dataArr: tablePerTitle, anchorView: tablePerFromeView, titleLabel: lblTablePerFrome)
       }
    
    @objc private func handleTablePerToTap() {
          
        var tablePerTitle = [String]()
        self.dataArrTablePer?.forEach { attributeData in
            tablePerTitle.append(attributeData.displayAttr ?? "")
        }
        openDropDown(dataArr: tablePerTitle, anchorView: tablePerToView, titleLabel: lblTablePerTo)
       }
    
    @objc private func handleDepthPerFromTap() {
          
        var depthPerTitle = [String]()
        self.dataArrDepthPer?.forEach { attributeData in
            depthPerTitle.append(attributeData.displayAttr ?? "")
        }
        openDropDown(dataArr: depthPerTitle, anchorView: depthPerFromeView, titleLabel: lblDepthPerFrome)
       }
    
    @objc private func handleDepthPerToTap() {
          
        var depthPerTitle = [String]()
        self.dataArrDepthPer?.forEach { attributeData in
            depthPerTitle.append(attributeData.displayAttr ?? "")
        }
        openDropDown(dataArr: depthPerTitle, anchorView: depthPerToView, titleLabel: self.lblDepthPerTo)
       }
    
    @objc private func handleCrownFromTap() {
          
        var crownTitle = [String]()
        self.dataArrDepthPer?.forEach { attributeData in
            crownTitle.append(attributeData.displayAttr ?? "")
        }
        openDropDown(dataArr: crownTitle, anchorView: crownPerFromeView, titleLabel: self.lblCrownPerFrome)
       }
    
    @objc private func handleCrownTOTap() {
          
        var crownTitle = [String]()
        self.dataArrDepthPer?.forEach { attributeData in
            crownTitle.append(attributeData.displayAttr ?? "")
        }
        openDropDown(dataArr: crownTitle, anchorView: crownPerToView, titleLabel: self.lblCrownPerTo)
       }
    
    @objc private func handleDepthPavllionFromTap() {
          
        var pavllionTitle = [String]()
        self.dataArrDepthPer?.forEach { attributeData in
            pavllionTitle.append(attributeData.displayAttr ?? "")
        }
        openDropDown(dataArr: pavllionTitle, anchorView: pavillionPerFromeView, titleLabel: self.lblPavillionPerFrome)
       }
    
    @objc private func handleDepthPavllionTOTap() {
          
        var pavllionTitle = [String]()
        self.dataArrDepthPer?.forEach { attributeData in
            pavllionTitle.append(attributeData.displayAttr ?? "")
        }
        openDropDown(dataArr: pavllionTitle, anchorView: pavillionPerToView, titleLabel: self.lblPavillionPerTo)
       }
    
    
    
    func openDropDown(dataArr:[String], anchorView:UIView, titleLabel:UILabel){
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
            dropDown.hide()
            
        }
        dropDown.show()
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
                    cell.isGradientApplied = false
                } else {
                    selectedIndicesCut.insert(indexPath)
                    cell.isGradientApplied = true
                }
            }
        case "POLISH":
            if let indexPath = collectionPlolish.indexPath(for: cell) {
                if selectedIndicesPolish.contains(indexPath) {
                    selectedIndicesPolish.remove(indexPath)
                    cell.isGradientApplied = false
                } else {
                    selectedIndicesPolish.insert(indexPath)
                    cell.isGradientApplied = true
                }
            }
        case "SYMMETRY":
            if let indexPath = collectionSymmetry.indexPath(for: cell) {
                if selectedIndicesSymmetry.contains(indexPath) {
                    selectedIndicesSymmetry.remove(indexPath)
                    cell.isGradientApplied = false
                } else {
                    selectedIndicesSymmetry.insert(indexPath)
                    cell.isGradientApplied = true
                }
            }
        case "TECHNOLOGY":
            if let indexPath = collectionTech.indexPath(for: cell) {
                if selectedIndicesTech.contains(indexPath) {
                    selectedIndicesTech.remove(indexPath)
                    cell.isGradientApplied = false
                } else {
                    selectedIndicesTech.insert(indexPath)
                    cell.isGradientApplied = true
                }
            }
        case "SHADE":
            if let indexPath = collectionShade.indexPath(for: cell) {
                if selectedIndicesShade.contains(indexPath) {
                    selectedIndicesShade.remove(indexPath)
                    cell.isGradientApplied = false
                } else {
                    selectedIndicesShade.insert(indexPath)
                    cell.isGradientApplied = true
                }
            }
        case "EYECLAN":
            if let indexPath = collectionEyeClan.indexPath(for: cell) {
                if selectedIndicesEyeClean.contains(indexPath) {
                    selectedIndicesEyeClean.remove(indexPath)
                    cell.isGradientApplied = false
                } else {
                    selectedIndicesEyeClean.insert(indexPath)
                    cell.isGradientApplied = true
                }
            }
        case "LUSTER":
            if let indexPath = collectionLuster.indexPath(for: cell) {
                if selectedIndicesLuster.contains(indexPath) {
                    selectedIndicesLuster.remove(indexPath)
                    cell.isGradientApplied = false
                } else {
                    selectedIndicesLuster.insert(indexPath)
                    cell.isGradientApplied = true
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
