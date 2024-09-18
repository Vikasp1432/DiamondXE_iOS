//
//  CancellationDoneAlertView.swift
//  DiamondXE
//
//  Created by iOS Developer on 18/09/24.
//

import UIKit

class CancellationDoneAlertView: UIViewController {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var doneButton: UIButton!
    @IBAction func doneButtonAction(_ sender: UIButton) {
        hide()
    }
    
    @IBOutlet weak var done: UIButton!
  

    var isWallet = true
    var isPaymntMode = false
    
  
    
    init() {
        super.init(nibName: "CancellationAlertView", bundle: nil)
        self.modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configView()
       
        self.done.setGradientLayerWithoutShadow(colorsInOrder: [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])

        
    }
    
  
   
  
    
    private func configView() {
        self.view.backgroundColor = .clear
        self.backView.backgroundColor = .black.withAlphaComponent(0.6)
        self.backView.alpha = 0
        self.contentView.alpha = 0
        self.contentView.layer.cornerRadius = 10
    }
    
    func appear(sender: UIViewController, tag:Int) {

            sender.present(self, animated: false) {
                self.show()
                
        }
    }
    
    
  
    
    
    private func show() {
        UIView.animate(withDuration: 0.2, delay: 0.0) {
            self.backView.alpha = 1
            self.contentView.alpha = 1
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
    
    @IBAction func btnactionsDone(_ sender : UIButton){
       
            hide()
       
       
    }
}
   
