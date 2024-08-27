//
//  PaymentOptionTVC.swift
//  DiamondXE
//
//  Created by iOS Developer on 21/08/24.
//

import UIKit
import DTTextField

class PaymentOptionTVC: UITableViewCell {
    
    static let cellIdentifierPaymentOptionTVC = String(describing: PaymentOptionTVC.self)

    @IBOutlet var btnRTGSBG : UIButton!
    @IBOutlet var btnDebitCSBG : UIButton!
    @IBOutlet var btnNetBankSBG : UIButton!
    @IBOutlet var btnBank1SBG : UIButton!
    @IBOutlet var btnBank2BG : UIButton!
    @IBOutlet var paymentOptionBG : UIView!
    @IBOutlet var viewBG:UIView!
    
    @IBOutlet var txtPaymentMode:DTTextField!
    @IBOutlet var txtChecqDate:DTTextField!
    @IBOutlet var txtChecqNum:DTTextField!
    
    @IBOutlet var lblBranchName:UILabel!
    @IBOutlet var lblIFSC:UILabel!
    @IBOutlet var lblSWIFT:UILabel!
    @IBOutlet var lblBankName:UILabel!
    @IBOutlet var lblAccountNum:UILabel!
    
    @IBOutlet var lblTitle1:UILabel!
    @IBOutlet var lblTitle2:UILabel!
    
    @IBOutlet var viewSelectDate:UIView!
    
    @IBOutlet var banksCollectionView:UICollectionView!
    @IBOutlet var banksViewBG:UIView!
    
    @IBOutlet var txtSelectedBnk:DTTextField!
    @IBOutlet var viewSelectedBnkBG:UIView!
    @IBOutlet var banksViewDropDown:UIButton!
    
    @IBOutlet var imgViewBnk1:UIImageView!
    @IBOutlet var imgViewBnk2:UIImageView!
    
     var buttonGroup: SingleSelectionButtonGroup!
    
     var buttonGroup2: SingleSelectionButtonGroup2!
    
    var btnAction : ((Int) -> Void) = {_ in }
    var paymentModeAction : (() -> Void) = { }
    
    var selectBankAction : (() -> Void) = { }
    
    var btnActionBanks : ((Int) -> Void) = {_ in }
    var btnDate:(() -> Void) = {}
    
    var dateString = ""
    
    var customPymnt = CustomPaymentVC()
    var selectedIndexPath: IndexPath?

    
    
    @IBOutlet var viewPaymtOptnBG:UIView!
    
    var netBankingData = NetBanking()
    var bnkCellTap:((Int) -> Void) = {_ in}

    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewBG.applyShadow()
        // Initialization code
        btnRTGSBG.applyVerticalGradientBackground(colors: [UIColor.btnGradient1, UIColor.btnGradient2], image: UIImage(named: "rtgs"))
      
        btnDebitCSBG.applyVerticalGradientBackground(colors: [UIColor.btnGradient1, UIColor.btnGradient2], image: UIImage(named: "dabitCard"))
        btnNetBankSBG.applyVerticalGradientBackground(colors: [UIColor.btnGradient1, UIColor.btnGradient2], image: UIImage(named: "netBanking"))
//        btnBank1SBG.applyVerticalGradientBackground(colors: [UIColor.btnGradient1, UIColor.btnGradient2])
//        btnBank2BG.applyVerticalGradientBackground(colors: [UIColor.btnGradient1, UIColor.btnGradient2])
        banksCollectionView.delegate = self
        banksCollectionView.dataSource = self
        banksCollectionView.register(UINib(nibName: PopularBanksCVC.cellIdentifierPopularBanksCVC, bundle: nil), forCellWithReuseIdentifier: PopularBanksCVC.cellIdentifierPopularBanksCVC)
        
     
        buttonGroup = SingleSelectionButtonGroup(buttons: [btnRTGSBG, btnDebitCSBG, btnNetBankSBG])
        buttonGroup2 = SingleSelectionButtonGroup2(buttons: [btnBank1SBG, btnBank2BG])

       
       // txtPaymentMode.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        viewPaymtOptnBG.addGestureRecognizer(tapGesture)
        
        let tapbnkGesture = UITapGestureRecognizer(target: self, action: #selector(bnkviewTapped))
        viewSelectedBnkBG.addGestureRecognizer(tapbnkGesture)
        
//        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(doneButtonPressed))
//        viewSelectDate.addGestureRecognizer(tapGesture2)
        
        txtChecqDate.addInputViewDatePicker(target: self, selector: #selector(doneButtonPressed))

    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        if let dtTextField = textField as? DTTextField {
            dtTextField.borderColor = UIColor.tabSelectClr
        }
           return true
       }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Change border color or perform any other actions
        if let customTextField = textField as? DTTextField {
            customTextField.borderColor = UIColor.tabSelectClr
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let customTextField = textField as? DTTextField {
            customTextField.borderColor = UIColor.borderClr
        }
    }
    
    
    @objc func doneButtonPressed() {
        if let  datePicker = self.txtChecqDate.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            self.txtChecqDate.text = dateFormatter.string(from: datePicker.date)
            dateFormatter.dateFormat = "yyyy-MM-dd"
            self.dateString = dateFormatter.string(from: datePicker.date)
        }
        self.txtChecqDate.resignFirstResponder()
     
    }
    
    func returnDOB() -> String{
        return dateString
    }
    
    
    @objc func viewTapped() {
        paymentModeAction()
    }
    
    @objc func bnkviewTapped() {
        selectBankAction()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func btnActionRTGS(_ sender:UIButton){
        btnAction(sender.tag)
        //buttonGroup.selectButton(sender)
    }
    
    
    @IBAction func btnActionBanks(_ sender:UIButton){
        btnActionBanks(sender.tag)
    }
    
    
    @IBAction func buttonActionGetDOB(_ sender: UIButton) {
        btnDate()
    }
    
    func paymentOptionViewHideShow(isShow:Bool){
        if isShow{
            paymentOptionBG.isHidden = false
        }
        else{
            paymentOptionBG.isHidden = true
        }
    }
    
    func bnkViewHideShow(isShow:Bool){
        if isShow{
            banksViewBG.isHidden = false
        }
        else{
            banksViewBG.isHidden = true
        }
    }
    
    func dataCollect()  -> Bool{
        
        if self.validateData() {
            customPymnt.paymentMode = self.txtPaymentMode.text ?? ""
            customPymnt.checkNum = self.txtChecqNum.text ?? ""
            customPymnt.selectedDate = self.txtChecqDate.text ?? ""
            return true
        }
        
        return false
    }
    
    
    func validateData() -> Bool {
        
        if txtPaymentMode.text != "Select Payment mode"{
            guard !txtPaymentMode.text!.isEmptyStr else {
                txtPaymentMode.showError(message: "Select Payment Mode")
                return false
            }
        }
        guard !txtChecqNum.text!.isEmptyStr else {
            txtChecqNum.showError(message: "Enter Checque number")
            return false
        }
        
        if txtChecqDate.text != "DD/MM/YYYY"{
            guard !txtChecqDate.text!.isEmptyStr else {
                txtChecqDate.showError(message: "Enter Date")
                return false
            }
        }
        return true
    }
    
    func selectedIndex(index : IndexPath) {
       
        
        self.selectedIndexPath = index
        banksCollectionView.reloadData()
      

    }
    
    
    
}


extension PaymentOptionTVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return netBankingData.popularBanks?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularBanksCVC.cellIdentifierPopularBanksCVC, for: indexPath) as! PopularBanksCVC
        
        if let image = netBankingData.popularBanks?[indexPath.row].img {
            cell.imgView.sd_setImage(with: URL(string: image!))
        }
        
        
        
        cell.tapAction = {
            self.bnkCellTap(indexPath.row)
            // self.tapAction(upiApp.appName)
            
            if let previousIndexPath = self.selectedIndexPath {
                let previousCell = collectionView.cellForItem(at: previousIndexPath) as? PopularBanksCVC
                previousCell?.imgView.borderWidth = 0
                previousCell?.imgView.borderColor = UIColor.clear
            }

            // Select the new cell
            let cell = collectionView.cellForItem(at: indexPath) as? PopularBanksCVC
          cell?.imgView.borderColor = UIColor.tabSelectClr
          cell?.imgView.borderWidth = 1.5
          cell?.imgView.cornerRadius = 3

            // Update the selected index path
            self.selectedIndexPath = indexPath
            
        }
        
        cell.imgView.borderWidth = 0
        cell.imgView.borderColor = UIColor.clear
      
        // Add border if the cell is selected
        if indexPath == selectedIndexPath {
            cell.imgView.borderColor = UIColor.tabSelectClr
            cell.imgView.borderWidth = 1.5
            cell.imgView.cornerRadius = 3
            
        }
        
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let noOfCellsInRow = 5 //number of column you want
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
        + flowLayout.sectionInset.right
        + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        return CGSize(width: size + 20 , height: size  )
       }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 8
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0) // Adjust the left padding
    }
    
    
}


/////????////????////????////?????///????

class SingleSelectionButtonGroup2 {
    private var buttons: [UIButton] = []
    private var selectedButton: UIButton?

    // Initialize with an array of buttons
    init(buttons: [UIButton]) {
            self.buttons = buttons
            setupButtons()
            // Select the first button by default
            if let firstButton = buttons.first {
                selectButton(firstButton)
            }
        }

    // Setup each button with a target action
    private func setupButtons() {
        for button in buttons {
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            button.layer.borderWidth = 1.5
            button.layer.borderColor = UIColor.clear.cgColor // Set initial border color to clear
        }
    }

    // Handle button tap
    @objc private func buttonTapped(_ sender: UIButton) {
        selectButton(sender)
    }

    // Select a button and deselect others
     func selectButton(_ button: UIButton) {
        // Deselect the currently selected button
        selectedButton?.layer.borderColor = UIColor.clear.cgColor

        // Select the new button
        button.layer.borderColor = UIColor.gradient2.cgColor
        selectedButton = button
    }
    
    
   
}

protocol SingleSelectionButtonGroupDelegate: AnyObject {
    func didSelectButton(withTag tag: Int?)
}

class SingleSelectionButtonGroup {
    private var buttons: [UIButton] = []
    private var selectedButton: UIButton?
    weak var delegate: SingleSelectionButtonGroupDelegate?

    // Initialize with an array of buttons
    init(buttons: [UIButton]) {
        self.buttons = buttons
        setupButtons()
    }

    // Setup each button with a target action
    private func setupButtons() {
        for button in buttons {
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            button.layer.borderWidth = 1.5
            button.layer.borderColor = UIColor.clear.cgColor // Set initial border color to clear
        }
    }

    // Handle button tap
    @objc private func buttonTapped(_ sender: UIButton) {
        toggleButtonSelection(sender)
    }

    // Toggle button selection and deselection
    private func toggleButtonSelection(_ button: UIButton) {
        if selectedButton == button {
            // If the same button is tapped again, deselect it
            button.layer.borderColor = UIColor.clear.cgColor
            selectedButton = nil
            delegate?.didSelectButton(withTag: nil) // Send nil when no button is selected
        } else {
            // Deselect the currently selected button
            selectedButton?.layer.borderColor = UIColor.clear.cgColor
            
            // Select the new button
            button.layer.borderColor = UIColor.gradient2.cgColor // Change to desired color
            selectedButton = button
            delegate?.didSelectButton(withTag: button.tag) // Send the selected button's tag
        }
    }
}



