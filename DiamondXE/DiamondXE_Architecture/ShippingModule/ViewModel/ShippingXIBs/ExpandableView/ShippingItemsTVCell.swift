//
//  ShippingItemsTVCell.swift
//  DiamondXE
//
//  Created by iOS Developer on 24/07/24.
//

import UIKit

class ShippingItemsTVCell: UITableViewCell {
    
    static let cellIdentifierShippingItems = String(describing: ShippingItemsTVCell.self)
    
    
    @IBOutlet var btnDropdownExpand:UIButton!
    @IBOutlet var viewTopDrpDn:UIView!
    @IBOutlet var itemsTableView:UITableView!
    @IBOutlet weak var viewHeightConstraint: NSLayoutConstraint!

    
    @IBOutlet var viewDataTable:UIView!
    
    @IBOutlet var bgDataView:UIView!
    
    var isHideItems = false
    var itemIndex : Int?
    
    var btnExpand : (() -> Void) = {  }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        itemsTableView.delegate = self
        itemsTableView.dataSource = self
       

        
        itemsTableView.register(UINib(nibName: ShippingItemsListCell.cellIdentifierShippingItemsList, bundle: nil), forCellReuseIdentifier: ShippingItemsListCell.cellIdentifierShippingItemsList)
        
        itemsTableView.tableHeaderView = UIView(frame: .zero)

        itemsTableView.contentInset = UIEdgeInsets.zero
        itemsTableView.scrollIndicatorInsets = UIEdgeInsets.zero

    }
    
    
    @IBAction func expandCollapseButtonTapped(_ sender: UIButton) {
        btnExpand()
//        isExpanded.toggle()
//        if isExpanded{
//            self.itemsTableView.isHidden = false
//        }else{
//            self.itemsTableView.isHidden = true
//        }
        
//        if let tableView = self.superview as? UITableView {
//                tableView.beginUpdates()
//                tableView.endUpdates()
//            }
    }
    
    
    func setupData(isExpand:Bool, itemIdexs:Int ,completion: @escaping (Bool) -> Void){
        if isExpand{
            viewDataTable.isHidden = true
            btnDropdownExpand.setImage( UIImage(named: "d_down"), for: .normal)
            self.viewHeightConstraint.constant = 0

        }
        else{
            viewDataTable.isHidden = false
            btnDropdownExpand.setImage(UIImage(named: "d_up"), for: .normal)
            self.viewHeightConstraint.constant = CGFloat(140*itemIdexs)
            
        }
        self.itemIndex = itemIdexs
        itemsTableView.reloadData()
        completion(true)
    }
    
    
//    private func updateTableViewHeight() {
//        if isExpanded {
//            tableViewHeightConstraint.constant = 500
//        } else {
//            tableViewHeightConstraint.constant = 0
//        }
//    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
}


extension ShippingItemsTVCell:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.itemIndex ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ShippingItemsListCell.cellIdentifierShippingItemsList, for: indexPath) as! ShippingItemsListCell
        cell.selectionStyle = .none

        
        return cell
    }
    
  
    
}

