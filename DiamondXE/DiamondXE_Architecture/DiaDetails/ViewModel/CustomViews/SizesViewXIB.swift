//
//  SizesViewXIB.swift
//  DiamondXE
//
//  Created by iOS Developer on 27/06/24.
//

import UIKit

struct ShapeSizeDataStruct: Codable {
    var shape: String?
    var details: [ShapeSizeDetail]?
}

// MARK: - Detail
struct ShapeSizeDetail: Codable {
    var carat: String?
    var image: String?
}




class SizesViewXIB: UIViewController {
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var doneButton: UIButton!
    @IBAction func doneButtonAction(_ sender: UIButton) {
        hide()
    }
    
    
    @IBOutlet weak var caratCollection: UICollectionView!
    @IBOutlet weak var shapeCollection: UICollectionView!
    @IBOutlet weak var previewIMG: UIImageView!
//    @IBOutlet weak var contentView: UIView!
    
    var selectedIndicesShaps: Set<IndexPath> = []
    var selectedIndicesCarat: Set<IndexPath> = []
    
    var dataArrCarat : [ShapeSizeDataStruct]?
    var sizeArrCarat : [ShapeSizeDetail]?
    var imgArr = [
                    UIImage(named:"round") ,
                    UIImage(named:"princess_") ,
                    UIImage(named:"emrald") ,
                    UIImage(named:"heart_") ,
                    UIImage(named:"radiant"),
                    UIImage(named:"oval"),
                    UIImage(named:"pear"),
                    UIImage(named:"marquise"),
                    UIImage(named:"asscher")]
    var shapeDataArr = [
                    "Round" ,
                    "Princess" ,
                    "Emrald" ,
                    "Heart",
                    "Radiant",
                    "Oval",
                    "Pear",
                    "Marquise",
                    "Asscher"]
    
    var shapeStr = String()
    
    init() {
        super.init(nibName: "SizesViewXIB", bundle: nil)
        self.modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        caratCollection.delegate = self
        shapeCollection.delegate = self
        caratCollection.dataSource = self
        shapeCollection.dataSource = self
        
        configView()
        // Do any additional setup after loading the view.
        
        shapeCollection.register(UINib(nibName: SearchDiamondCVC.cellIdentifierShapeDiamondCVC, bundle: nil), forCellWithReuseIdentifier: SearchDiamondCVC.cellIdentifierShapeDiamondCVC)
        
        caratCollection.register(UINib(nibName: SearchesOptionCVC.cellIdentifierSearchOptionCVC, bundle: nil), forCellWithReuseIdentifier: SearchesOptionCVC.cellIdentifierSearchOptionCVC)
        
        configureCollectionView(caratCollection)
        configureCollectionView(shapeCollection)
        getCarateWithImgPreview()
    }
    
    
    func configureCollectionView(_ collectionView: UICollectionView) {
           collectionView.showsHorizontalScrollIndicator = false
           collectionView.showsVerticalScrollIndicator = false
           collectionView.allowsMultipleSelection = true
           collectionView.delegate = self
           collectionView.dataSource = self

       }
    
    private func configView() {
        self.view.backgroundColor = .clear
        self.backView.backgroundColor = .black.withAlphaComponent(0.6)
        self.backView.alpha = 0
        self.contentView.alpha = 0
        self.contentView.layer.cornerRadius = 10
    }
    
    
    private func show() {
        UIView.animate(withDuration: 0.2, delay: 0.0) {
            self.backView.alpha = 1
            self.contentView.alpha = 1
        }
    }
    
    func appear(sender: UIViewController, tag:Int, url:String) {
        sender.present(self, animated: false) {
            self.show()
        }
    }
    
    func hide() {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut) {
            self.backView.alpha = 0
            self.contentView.alpha = 0
        } completion: { _ in
            self.dismiss(animated: false)
            self.removeFromParent()
        }
    }
    
    
    
    func getCarateWithImgPreview(){
        
        AlamofireManager().makeGETAPIRequestWithLocation(url: APIs().get_DiamodPreview_API, completion: { result in
            switch result {
            case .success(let data):
                do {
                    self.dataArrCarat = try JsonParsingManagar.parse(jsonData: data!, type: [ShapeSizeDataStruct].self)
                    print(self.dataArrCarat)
                    self.dataArrCarat
                    self.caratCollection.reloadData()
                    
                } catch {
                    print("Error")
                }
            case .failure(let error): break
                // Handle the error
            }
        })
        
        
    }
    
    func selectShapeIndex(shapeName: String) -> ([ShapeSizeDetail]?) {

        guard let index = shapeDataArr.firstIndex(of: shapeName) else {
                    print("Shape not found")
                    return (nil)
                }

        let selectedShape = dataArrCarat?.first { $0.shape == shapeName }
                guard let shape = selectedShape else {
                    print("Shape details not found")
                    return (nil)
                }


        return (shape.details)
        
        
        }
    
    
}


extension SizesViewXIB: CustomCollectionViewCellDelegate, OptionsCollectionViewCellDelegate {
    
    func btnTappedCell(in cell: SearchesOptionCVC) {
        if let indexPath = caratCollection.indexPath(for: cell) {
            // Deselect the previously selected item
            if let previousIndex = selectedIndicesCarat.first {
                selectedIndicesCarat.remove(previousIndex)
                if let previousCell = caratCollection.cellForItem(at: previousIndex) as? SearchesOptionCVC {
                    previousCell.isGradientApplied = false
                }
            }
            
            // Select the new item
            selectedIndicesCarat.insert(indexPath)
            cell.isGradientApplied = true
            caratCollection.reloadItems(at: [indexPath])
        }
    }
    
    func imageViewTapped(in cell: SearchDiamondCVC) {
        if let indexPath = shapeCollection.indexPath(for: cell) {
            // Deselect the previously selected item
            if let previousIndex = selectedIndicesShaps.first {
                selectedIndicesShaps.remove(previousIndex)
                if let previousCell = shapeCollection.cellForItem(at: previousIndex) as? SearchDiamondCVC {
                    previousCell.isShadowApplied = false
                }
            }
            
            // Select the new item
            selectedIndicesShaps.insert(indexPath)
            self.shapeStr = shapeDataArr[indexPath.row]
            cell.isShadowApplied = true
            selectedIndicesCarat.removeAll()
            selectedIndicesCarat.insert(IndexPath(row: 0, section: 0))
            caratCollection.reloadData()
        }
    }
}


extension SizesViewXIB: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView {
        case self.caratCollection:
//            return 10
            if shapeStr.isEmpty{
                self.sizeArrCarat = self.selectShapeIndex(shapeName: "Round")
                return self.sizeArrCarat?.count ?? 0
            }
            else{
                self.sizeArrCarat = self.selectShapeIndex(shapeName: shapeStr)
                return self.sizeArrCarat?.count ?? 0
            }
            
            
        case self.shapeCollection:
            return shapeDataArr.count
            
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        switch collectionView {
        case self.shapeCollection:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchDiamondCVC.cellIdentifierShapeDiamondCVC, for: indexPath) as! SearchDiamondCVC
            cell.lblCateIMG.image = imgArr[indexPath.row]
            cell.delegate = self
            cell.isShadowApplied = selectedIndicesShaps.contains(indexPath)
            return cell
        case self.caratCollection:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchesOptionCVC.cellIdentifierSearchOptionCVC, for: indexPath) as! SearchesOptionCVC
              cell.delegate = self
            cell.isGradientApplied = selectedIndicesCarat.contains(indexPath)
            cell.btnTitle.setTitle(self.sizeArrCarat?[indexPath.row].carat, for: .normal)
            if let imgURL = self.sizeArrCarat?[selectedIndicesCarat.first?.row ?? 0].image {
                self.previewIMG.sd_setImage(with: URL(string:  imgURL), placeholderImage: UIImage(named: "place_Holder"))
            }
            
            
            
            return cell
            
            
        default:
            
            return UICollectionViewCell()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch collectionView {
        case self.shapeCollection:
            let noOfCellsInRow = 4  //number of column you want
            let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
            let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
            
            let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
            return CGSize(width: size + 24  , height: size + 35)
            
            
        default:
            let noOfCellsInRow = 6 //number of column you want
            let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
            let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
            
            let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
            return CGSize(width: size + 15 , height: size )
        }
        
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 13
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0) // Adjust the left padding
    }
    
    
    
}
