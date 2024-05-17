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
    private var childControllers: [UIViewController] = []
    private var previouslyVisibleChildViewController: UIViewController?
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnSearch.layer.shadowOffset = CGSize(width:0, height:0)
        btnSearch.layer.shadowRadius = 2.5
        btnSearch.layer.shadowColor = UIColor.black.cgColor
        btnSearch.layer.shadowOpacity = 0.5
        btnSearch.clipsToBounds = false
        btnSearch.superview?.clipsToBounds = false
        
        
        let childViewController1 = HomeVC()
        let childViewController2 = CategoriesVC()
        let childViewController3 = WishVC()
        let childViewController4 = CartVC()
        let childViewController5 = DashboardLoginVC()
        
        childControllers = [childViewController1, childViewController2,
                            childViewController3, childViewController4,
                            childViewController5]
        
         transitionToViewController(at: 0)
        
        //
       
       
        home = self.containerView.transform
        
        
        // define uitableview cell
        menuTableView.register(UINib(nibName: ExpandableCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: ExpandableCell.cellIdentifier)
        menuTableView.register(UINib(nibName: MainCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: MainCell.cellIdentifier)
      
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
        
        print("menu interaction")
        
        if menu == false && swipeGesture.direction == .right {
            
            print("user is showing menu")
            
            showMenu()
            
            menu = true
            
        }
        
    }
    
    
    
    @IBAction func hideMenu(_ sender: Any) {
        
        if menu == true {
            
            print("user is hiding menu")
            
            hideMenu()
            
            menu = false
            
        }
        
        
    }
    
    
    @IBAction func btnActionTapped(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            transitionToViewController(at: sender.tag)
        case 1:
            transitionToViewController(at: sender.tag)
        case 2:
            transitionToViewController(at: sender.tag)
        case 3:
            transitionToViewController(at: sender.tag)
        default:
            transitionToViewController(at: sender.tag)
        }
    }
    
    
    
  
    
    private func getChildViewControllerIndex(of child: UIViewController?) -> Int? {
        guard let child = child else { return nil }
        return childControllers.firstIndex(of: child)
    }
    
    private func transitionToViewController(at index: Int) {
           guard index >= 0, index < childControllers.count else { return }
           let childViewController = childControllers[index]

           // Add child view controller if not already added
           if childViewController.parent != self {
               addChild(childViewController)
               childViewController.view.frame = containerView.bounds
               containerView.addSubview(childViewController.view)
               childViewController.didMove(toParent: self)
           }

           // Calculate transition direction based on current and new indices
           let currentChildIndex = getChildViewControllerIndex(of: previouslyVisibleChildViewController)
           let direction: CGFloat = (index > currentChildIndex ?? 0) ? 1.0 : -1.0

           // Animate transition using a slide animation
        
        print(direction)
        
       // let direction: CGFloat = 1 // 1 for right, -1 for left
//        let transitionOptions: UIView.AnimationOptions = .curveEaseInOut
       
//           let transitionOptions = UIView.AnimationOptions.transitionSlide(along: direction > 0 ? .right : .left, with: .curveEaseInOut, duration: 0.5)
        UIView.transition(with: self.containerView, duration: 0.5, options: .curveEaseInOut, animations: {
               // Update container view to show the new child view controller
               self.containerView.subviews.forEach { $0.removeFromSuperview() }
               self.containerView.addSubview(childViewController.view)
           }) { _ in
               self.previouslyVisibleChildViewController = childViewController
           }
        
       }
    
    
    @IBAction func btnActionSideMenu(_ sender: UIButton) {
        print("menu interaction")
        
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
            return section.isExpandableCellsHidden ? 1 : section.expandableCellOptions.count + 1
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath) as! MainCell
                cell.label.text = sections[indexPath.section].mainCellTitle
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ExpandableCell", for: indexPath) as! ExpandableCell
                cell.label.text = sections[indexPath.section].expandableCellOptions[indexPath.row - 1]
                return cell
            }
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            if indexPath.row == 0 {
                let section = indexPath.section
                let isCurrentlyHidden = sections[section].isExpandableCellsHidden
                sections[section].isExpandableCellsHidden = !isCurrentlyHidden
                
                var indexPaths = [IndexPath]()
                for row in 1...sections[section].expandableCellOptions.count {
                    indexPaths.append(IndexPath(row: row, section: section))
                }
                
                if isCurrentlyHidden {
                    // Expand the section with animation
                    tableView.beginUpdates()
                    tableView.insertRows(at: indexPaths, with: .fade)
                    tableView.endUpdates()
                } else {
                    // Collapse the section with animation
                    tableView.beginUpdates()
                    tableView.deleteRows(at: indexPaths, with: .fade)
                    tableView.endUpdates()
                }
            }

    }
    
}
