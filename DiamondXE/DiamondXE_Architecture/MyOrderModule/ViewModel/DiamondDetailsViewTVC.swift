//
//  DiamondDetailsViewTVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 13/09/24.
//

import UIKit
import UIView_Shimmer

class DiamondDetailsViewTVC: UITableViewCell, ShimmeringViewProtocol {
    
    static let cellIdentifierDiamondDetailsViewTVC = String(describing: DiamondDetailsViewTVC.self)
    
    
    @IBOutlet var viewBG : UIView!
    @IBOutlet var imgDiamond : UIImageView!
    @IBOutlet var lblShapeTop : UILabel!
    @IBOutlet var lblCertificateNo : UILabel!
    @IBOutlet var lblShape : UILabel!
    @IBOutlet var lblCarat : UILabel!
    @IBOutlet var lblColor : UILabel!
    @IBOutlet var lblClarity : UILabel!
    @IBOutlet var lblType : UILabel!
    @IBOutlet var lblCut : UILabel!
    @IBOutlet var lblPolish : UILabel!
    @IBOutlet var lblSYM : UILabel!
    @IBOutlet var lblDiaType: UILabel!
    @IBOutlet var viewDiaType : UIView!
    @IBOutlet var lblFLR : UILabel!
    @IBOutlet var lblLAB : UILabel!
    @IBOutlet var lblTable : UILabel!
    @IBOutlet var lblDepth : UILabel!
    @IBOutlet var lblTotalAmnt : UILabel!
    
    
    var shimmeringAnimatedItems: [UIView] {
        [
            self.imgDiamond,
            self.lblShapeTop,
            self.lblCertificateNo,
            self.lblShape,
            self.lblCarat,
            self.lblColor,
            self.lblClarity,
            self.lblType,
            self.lblCut,
            self.lblPolish,
            self.lblSYM,
            self.lblDiaType,
            self.viewDiaType,
            self.lblFLR,
            self.lblLAB,
            self.lblTable,
            self.lblDepth,
            self.lblTotalAmnt,
            self.viewBG
            
        ]
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
