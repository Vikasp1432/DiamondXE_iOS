//
//  NewArrivalsTVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 21/05/24.
//

import UIKit

class NewArrivalsTVC: UITableViewCell {
    static let cellIdentifierNewArrTVC = String(describing: NewArrivalsTVC.self)
    
    @IBOutlet var newArrImg1:UIImageView!
    @IBOutlet var newArrImg2:UIImageView!
    @IBOutlet var lblTitle:UILabel!
    
    var tapAction : ((Int) -> Void) = { _ in}
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        newArrImg1.isUserInteractionEnabled = true
        newArrImg1.addGestureRecognizer(tapGestureRecognizer)
        
        let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(imageTapped2(tapGestureRecognizer:)))
        newArrImg2.isUserInteractionEnabled = true
        newArrImg2.addGestureRecognizer(tapGestureRecognizer2)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        tapAction(newArrImg1.tag)
    }
    
    @objc func imageTapped2(tapGestureRecognizer: UITapGestureRecognizer)
    {
        tapAction(newArrImg2.tag)
    }
    
}
