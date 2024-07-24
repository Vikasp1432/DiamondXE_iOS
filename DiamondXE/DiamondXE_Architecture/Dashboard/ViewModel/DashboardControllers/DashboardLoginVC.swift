//
//  DashboardLoginVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 16/05/24.
//

import UIKit

class DashboardLoginVC: BaseViewController , ChildViewControllerProtocol {
    
    func didSendString(str: String) {
        print(str)
    }
    
    var delegate : BaseViewControllerDelegate?
    
    
    @IBOutlet var menuTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuTableView.delegate = self
        menuTableView.dataSource = self

        // Do any additional setup after loading the view.
        
        menuTableView.register(UINib(nibName: ExpandableCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: ExpandableCell.cellIdentifier)
        menuTableView.register(UINib(nibName: MainCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: MainCell.cellIdentifier)
        menuTableView.showsHorizontalScrollIndicator = false
        menuTableView.showsVerticalScrollIndicator = false
    }
    


}

extension DashboardLoginVC: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
            return sectionsAccountProfile.count
        }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            let section = sectionsAccountProfile[section]
            if section.isExpandableCellsHidden {
                return 1
            } else {
                return section.expandableCellOptions.count + 1
            }
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: MainCell.cellIdentifier, for: indexPath) as! MainCell
                cell.configure2(with: sectionsAccountProfile[indexPath.section])
                cell.mainIconIMG.image = sectionsAccountProfile[indexPath.section].mainCellOptionsIcons[indexPath.section]
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: ExpandableCell.cellIdentifier, for: indexPath) as! ExpandableCell
                cell.label.text = sectionsAccountProfile[indexPath.section].expandableCellOptions[indexPath.row - 1]
                cell.iconIMG.image = sectionsAccountProfile[indexPath.section].expandableCellOptionsIcons[indexPath.row - 1]
                return cell
            }
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            if indexPath.row == 0 {
                let section = indexPath.section
                
                //self.sideMenuActions(sectionStr: sections[section].mainCellTitle)
                
                let isCurrentlyHidden = sectionsAccountProfile[section].isExpandableCellsHidden
                sectionsAccountProfile[section].isExpandableCellsHidden = !isCurrentlyHidden
                sectionsAccountProfile[section].isExpanded = !isCurrentlyHidden // Update the expanded state

                if sectionsAccountProfile[section].expandableCellOptions.isEmpty {
                    // If there are no expandable options, do nothing
                    return
                }

                var indexPaths = [IndexPath]()
                for row in 1...sectionsAccountProfile[section].expandableCellOptions.count {
                    indexPaths.append(IndexPath(row: row, section: section))
                }
                
                tableView.beginUpdates()
                if isCurrentlyHidden {
                    // Expand the section with animation
                    tableView.insertRows(at: indexPaths, with: .fade)
                } else {
                    // Collapse the section with animation
                    tableView.deleteRows(at: indexPaths, with: .fade)
                }
                tableView.endUpdates()

                // Reload the main cell to update the icon
                let mainCellIndexPath = IndexPath(row: 0, section: section)
                tableView.reloadRows(at: [mainCellIndexPath], with: .none)
            }
            
            else{
                self.sideMenuActions(sectionStr: sectionsAccountProfile[indexPath.section].expandableCellOptions[indexPath.row - 1])
            }
        }
    
    
    func sideMenuActions(sectionStr:String){
        
        if nv_home == sectionStr{
//            if menu == true {
//                homeMenuActive()
//            }
        }
        
        else if nv_naturalDiamond == sectionStr{
           
        }
        
        else if nv_labGrownDiamond == sectionStr{
           
        }
        
        
        else if nv_diamondEducation == sectionStr{
            print(sectionStr)
            
           
        }
        
        else if nv_jeweller == sectionStr{
            print(sectionStr)
           
            
        }
        
        else if nv_supplier == sectionStr{
            print(sectionStr)
           
        }
        
        else if nv_aboutUS == sectionStr{
            print(sectionStr)
           
            
        }
        
        else if nv_whyUS == sectionStr{
            print(sectionStr)
            
        }
        
        else if nv_blogs == sectionStr{
            print(sectionStr)
          
         
        }
        
        else if nv_mediaGalley == sectionStr{
            print(sectionStr)
          
           
        }
        
        else if nv_support == sectionStr{
            print(sectionStr)
           
            
        }
        
        else if nv_termCondition == sectionStr{
            print(sectionStr)
          
            
        }
        
        
    }
    
}
