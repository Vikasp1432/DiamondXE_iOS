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
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!

    var isHideItems = false
    
    var btnExpand : (() -> Void) = {  }
    
    var innerData: [Int] = [] {
           didSet {
               itemsTableView.reloadData()
               updateTableViewHeight()
           }
       }
       
       var isExpanded: Bool = false {
           didSet {
               itemsTableView.isHidden = !isExpanded
               updateTableViewHeight()
           }
       }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        itemsTableView.delegate = self
        itemsTableView.dataSource = self
//        itemsTableView.isHidden = true
        itemsTableView.isHidden = !isExpanded

        
        itemsTableView.register(UINib(nibName: ShippingItemsListCell.cellIdentifierShippingItemsList, bundle: nil), forCellReuseIdentifier: ShippingItemsListCell.cellIdentifierShippingItemsList)
        
//

    }
    
    
    @IBAction func expandCollapseButtonTapped(_ sender: UIButton) {
        isExpanded.toggle()
        if let tableView = self.superview as? UITableView {
                tableView.beginUpdates()
                tableView.endUpdates()
            }
    }
    
    private func updateTableViewHeight() {
        if isExpanded {
            tableViewHeightConstraint.constant = 500
        } else {
            tableViewHeightConstraint.constant = 0
        }
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
}


extension ShippingItemsTVCell:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return innerData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ShippingItemsListCell.cellIdentifierShippingItemsList, for: indexPath) as! ShippingItemsListCell
        cell.selectionStyle = .none

        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//       
////           // Or your desired cell height
//      }
    
}

