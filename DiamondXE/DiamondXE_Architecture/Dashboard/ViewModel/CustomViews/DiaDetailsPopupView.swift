//
//  DiaDetailsPopupView.swift
//  DiamondXE
//
//  Created by iOS Developer on 26/06/24.
//

import UIKit

protocol DiaDetailsPopupViewDelegate: AnyObject {
    func customViewButtonTapped(_ customView: DiaDetailsPopupView, returnValue: String)
}


class DiaDetailsPopupView: UIView {
    
    @IBOutlet weak var viewShare:UIView!
    @IBOutlet weak var viewNotify:UIView!
    @IBOutlet weak var viewMatchPair:UIView!
    @IBOutlet weak var viewDownload:UIView!
    @IBOutlet weak var viewCallEnqry:UIView!
    
    var delegate : DiaDetailsPopupViewDelegate?


    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit(){
        let viewFromXib = Bundle.main.loadNibNamed("DiaDetailsPopupView", owner: self, options: nil)![0] as! UIView
        viewFromXib.frame = self.bounds
        addSubview(viewFromXib)
        
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        viewShare?.addGestureRecognizer(tap1)
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        viewNotify?.addGestureRecognizer(tap2)
        let tap3 = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        viewMatchPair?.addGestureRecognizer(tap3)
        let tap4 = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        viewDownload?.addGestureRecognizer(tap4)
        let tap5 = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        viewCallEnqry?.addGestureRecognizer(tap5)
        
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        
        if let tappedView = sender.view {
            switch tappedView.tag {
            case 0:
                print("Other view tapped")
                self.delegate?.customViewButtonTapped(self, returnValue: "Share")
            case 1:
                print("Other view tapped")
                self.delegate?.customViewButtonTapped(self, returnValue: "Notify")
            case 2:
                print("Other view tapped")
                self.delegate?.customViewButtonTapped(self, returnValue: "MatchPair")
            case 3:
                print("Other view tapped")
                self.delegate?.customViewButtonTapped(self, returnValue: "Download")
            case 4:
                print("Other view tapped")
                self.delegate?.customViewButtonTapped(self, returnValue: "call")
                
            default:
                print("Other view tapped")
                // Handle action for other views
            }
        }
    }

}
