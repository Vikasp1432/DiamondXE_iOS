//
//  AllDiamondDetailsTVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 22/06/24.
//

import UIKit

class AllDiamondDetailsTVC: UITableViewCell {
    static let cellIdentifierAllDimdDetailsTVC = String(describing: AllDiamondDetailsTVC.self)
    
    @IBOutlet var lblMasurment :UILabel!
    @IBOutlet var lblDepth :UILabel!
    @IBOutlet var lblTable :UILabel!
    @IBOutlet var lblCrownHeight :UILabel!
    @IBOutlet var lblCrownAngle :UILabel!
    @IBOutlet var lblPalivionDepth :UILabel!
    @IBOutlet var lblPalivionAngle :UILabel!
    
    @IBOutlet var lblShade :UILabel!
    @IBOutlet var lblGridCulet :UILabel!
    @IBOutlet var lblGrowthType :UILabel!
    @IBOutlet var lblInclusion :UILabel!
    @IBOutlet var lblStatus :UILabel!
    @IBOutlet var lblKeytoSymbole :UILabel!
    @IBOutlet var lblRemark :UILabel!
    @IBOutlet var lblReportComment:UILabel!
    @IBOutlet var lblLocation:UILabel!
    
    @IBOutlet var btnDropDown:UIButton!
    @IBOutlet var viewBGData:UIView!
    @IBOutlet var bg1View:UIView!
    @IBOutlet var bg2View:UIView!
    
    
    var buttonPressed : ((Int) -> Void) = {_ in }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bg1View.applyShadow()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cellTapped))
        bg2View.addGestureRecognizer(tapGesture)
    }
    
    @objc func cellTapped() {
        buttonPressed(0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
        buttonPressed(sender.tag)
    }
    
    func setupData(isExpand:Bool){
        if isExpand{
            viewBGData.isHidden = true
            btnDropDown.setImage( UIImage(named: "d_down"), for: .normal)

        }
        else{
            viewBGData.isHidden = false
            btnDropDown.setImage(UIImage(named: "d_up"), for: .normal)
            
        }
    }
    
}
