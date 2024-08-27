//
//  ShippingModuleVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 23/07/24.
//

import UIKit

class ShippingModuleVC: BaseViewController {
    
    @IBOutlet var btnShipping : UIButton!
    @IBOutlet var btnKYC : UIButton!
    @IBOutlet var btnPayment : UIButton!
    
    @IBOutlet var shippingTableView:UITableView!

    var isExpand = true

    override func viewDidLoad() {
        super.viewDidLoad()
        
        shippingTableView.delegate = self
        shippingTableView.dataSource = self

        // Do any additional setup after loading the view.
        
        btnShipping.layer.shadowColor = UIColor.black.cgColor
        btnShipping.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        btnShipping.layer.shadowRadius = 3.0
        btnShipping.layer.shadowOpacity = 0.3
        btnShipping.layer.masksToBounds = false
        
        btnKYC.layer.shadowColor = UIColor.black.cgColor
        btnKYC.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        btnKYC.layer.shadowRadius = 3.0
        btnKYC.layer.shadowOpacity = 0.3
        btnKYC.layer.masksToBounds = false
        
        btnPayment.layer.shadowColor = UIColor.black.cgColor
        btnPayment.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        btnPayment.layer.shadowRadius = 3.0
        btnPayment.layer.shadowOpacity = 0.3
        btnPayment.layer.masksToBounds = false
        
        shippingTableView.register(UINib(nibName: ShippingItemsTVCell.cellIdentifierShippingItems, bundle: nil), forCellReuseIdentifier: ShippingItemsTVCell.cellIdentifierShippingItems)
    }
    
    @IBAction func btnActionBack(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }


}


extension ShippingModuleVC:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ShippingItemsTVCell.cellIdentifierShippingItems, for: indexPath) as! ShippingItemsTVCell
        cell.selectionStyle = .none
       // cell.innerData = [1,2,4,5,6,7]
        
//        cell.innerData = data[indexPath.row]
       // cell.isExpanded.toggle()
        
        cell.btnExpand =  {
            self.isExpand.toggle()
            cell.setupData(isExpand: self.isExpand, itemIdexs: 2, completion: {_ in
                self.shippingTableView.reloadSections([0], with: .fade)
            })
            
       }
        

        return cell
    }
    
    
    @IBAction func btnActionPayment(_ sender:UIButton){
        self.navigationManager(storybordName: "PaymentModule", storyboardID: "PaymentModuleVC", controller: PaymentModuleVC())
    }

    
}
