//
//  DashboardVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 23/04/24.
//

import UIKit

class DashboardVC: BaseViewController {
    
  
 
    @IBOutlet var containerViewSideMenu: UIView!
    @IBOutlet var viewBG: UIImageView!
    @IBOutlet var swipeGesture: UISwipeGestureRecognizer!
    @IBOutlet var menuTableView: UITableView!
    @IBOutlet var lblVersion: UILabel!
    
    let screen = UIScreen.main.bounds
    var menu = false
    var home = CGAffineTransform()
    
    
    @IBOutlet var viewTabBar:UIView!
    @IBOutlet var btnSearch:UIButton!
    
    @IBOutlet weak var btnHome: UIButton!
    @IBOutlet weak var btnCategory: UIButton!
    @IBOutlet weak var btnWish: UIButton!
    @IBOutlet weak var btnCart: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    
    @IBOutlet weak var containerView: UIView!
 
    private var currentViewController: UIViewController?
    private var currentViewControllerIdentifier: String?
//    private let viewControllerIdentifiers = ["HomeVC", "CategoriesVC", "WishVC", "CartVC", "DashboardLoginVC"]
//    private let storyboardNames = ["HomeVC", "CategoriesVC", "WishlistVC", "CartVC", "Dashboard"]

  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.lblVersion.text = getAppVersion
        btnSearch.layer.shadowOffset = CGSize(width:0, height:0)
        btnSearch.layer.shadowRadius = 2.5
        btnSearch.layer.shadowColor = UIColor.black.cgColor
        btnSearch.layer.shadowOpacity = 0.5
        btnSearch.clipsToBounds = false
        btnSearch.superview?.clipsToBounds = false
        
      
        loadViewController(withIdentifier: viewControllerIdentifiers[0], fromStoryboard: storyboardNames[0])

       
        home = self.containerView.transform
        
        // define uitableview cell
        menuTableView.register(UINib(nibName: ExpandableCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: ExpandableCell.cellIdentifier)
        menuTableView.register(UINib(nibName: MainCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: MainCell.cellIdentifier)
        menuTableView.showsHorizontalScrollIndicator = false
        menuTableView.showsVerticalScrollIndicator = false
      
    }
    
    private func loadViewController(withIdentifier identifier: String, fromStoryboard storyboardName: String) {
            // Determine the direction
            let direction: SlideDirection = {
                if let currentIdentifier = currentViewControllerIdentifier,
                   let currentIndex = viewControllerIdentifiers.firstIndex(of: currentIdentifier),
                   let newIndex = viewControllerIdentifiers.firstIndex(of: identifier) {
                    return newIndex > currentIndex ? .right : .left
                }
                return .right
            }()

            // Instantiate the view controller
            let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
         let  newViewController = storyboard.instantiateViewController(withIdentifier: identifier)
            let width = containerView.bounds.size.width
            let initialFrame = CGRect(x: direction == .right ? width : -width, y: 0, width: width, height: containerView.bounds.size.height)
            let finalFrame = containerView.bounds

            newViewController.view.frame = initialFrame
            containerView.addSubview(newViewController.view)
            addChild(newViewController)
            newViewController.didMove(toParent: self)
            
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                newViewController.view.frame = finalFrame
                self.currentViewController?.view.frame = CGRect(x: direction == .right ? -width : width, y: 0, width: width, height: self.containerView.bounds.size.height)
            }) { _ in
                self.currentViewController?.willMove(toParent: nil)
                self.currentViewController?.view.removeFromSuperview()
                self.currentViewController?.removeFromParent()
                self.currentViewController = newViewController
                self.currentViewControllerIdentifier = identifier
            }
        }

    
    
    
    func showMenu() {
        containerViewSideMenu.layer.shadowOffset = CGSize(width:0, height:0)
        containerViewSideMenu.layer.shadowRadius = 4.5
        containerViewSideMenu.layer.shadowColor = UIColor.gray.cgColor
        containerViewSideMenu.layer.shadowOpacity = 0.6
        self.containerViewSideMenu.layer.cornerRadius = 2
        self.viewBG.layer.cornerRadius = self.containerViewSideMenu.layer.cornerRadius
        let x = screen.width * 0.8
        let originalTransform = self.containerViewSideMenu.transform
        let scaledTransform = originalTransform.scaledBy(x: 0.8, y: 0.8)
            let scaledAndTranslatedTransform = scaledTransform.translatedBy(x: x, y: 0)
            UIView.animate(withDuration: 0.3, animations: {
                self.containerViewSideMenu.transform = scaledAndTranslatedTransform
                
            })
        
    }
    
    func hideMenu() {
        
            UIView.animate(withDuration: 0.3, animations: {
                self.containerViewSideMenu.transform = self.home
                self.containerViewSideMenu.layer.cornerRadius = 0
                self.viewBG.layer.cornerRadius = 0
                
            })
        
    }
    
    
    
    @IBAction func showMenu(_ sender: UISwipeGestureRecognizer) {
        
       // print("menu interaction")
        
        if menu == false && swipeGesture.direction == .right {
            
            print("user is showing menu")
            
            showMenu()
            
            menu = true
            
        }
        
    }
    
    
    
    @IBAction func hideMenu(_ sender: Any) {
        
        if menu == true {
            
          //  print("user is hiding menu")
            
            hideMenu()
            
            menu = false
            
        }
        
        
    }
    
    
    @IBAction func btnActionTapped(_ sender: UIButton) {
        let identifier = viewControllerIdentifiers[sender.tag]
        let storyboardName = storyboardNames[sender.tag]
        loadViewController(withIdentifier: identifier, fromStoryboard: storyboardName)
       }
        
        
//        switch sender.tag {
//        case 0:
//            loadViewController(withIdentifier: "HomeVC", fromStoryboard: "Dashboard")
//        case 1:
//            loadViewController(withIdentifier: "CategoriesVC", fromStoryboard: "Dashboard")
//        case 2:
//            loadViewController(withIdentifier: "WishVC", fromStoryboard: "Dashboard")
//        case 3:
//            loadViewController(withIdentifier: "CartVC", fromStoryboard: "Dashboard")
//        default:
//            loadViewController(withIdentifier: "DashboardLoginVC", fromStoryboard: "Dashboard")
//        }
//    }
   
    
    @IBAction func btnActionSideMenu(_ sender: UIButton) {
       // print("menu interaction")
        
        if menu == false && swipeGesture.direction == .right {
            
            print("user is showing menu")
            
            showMenu()
            
            menu = true
            
        }
    }
    
    
}



extension DashboardVC:UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
            return sections.count
        }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            let section = sections[section]
            if section.isExpandableCellsHidden {
                return 1
            } else {
                return section.expandableCellOptions.count + 1
            }
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: MainCell.cellIdentifier, for: indexPath) as! MainCell
                cell.configure(with: sections[indexPath.section])
                cell.mainIconIMG.image = sections[indexPath.section].mainCellOptionsIcons[indexPath.section]
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: ExpandableCell.cellIdentifier, for: indexPath) as! ExpandableCell
                cell.label.text = sections[indexPath.section].expandableCellOptions[indexPath.row - 1]
                cell.iconIMG.image = sections[indexPath.section].expandableCellOptionsIcons[indexPath.row - 1]
                return cell
            }
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            if indexPath.row == 0 {
                let section = indexPath.section
                let isCurrentlyHidden = sections[section].isExpandableCellsHidden
                sections[section].isExpandableCellsHidden = !isCurrentlyHidden
                sections[section].isExpanded = !isCurrentlyHidden // Update the expanded state

                if sections[section].expandableCellOptions.isEmpty {
                    // If there are no expandable options, do nothing
                    return
                }

                var indexPaths = [IndexPath]()
                for row in 1...sections[section].expandableCellOptions.count {
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
        }
    
}
