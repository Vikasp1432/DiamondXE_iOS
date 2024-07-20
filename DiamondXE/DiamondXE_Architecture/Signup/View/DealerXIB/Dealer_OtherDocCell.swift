//
//  Dealer_OtherDocCell.swift
//  DiamondXE
//
//  Created by iOS Developer on 29/04/24.
//

import UIKit
import DTTextField

protocol CustomDatePickerDelegate: AnyObject {
    func didSelectDate(date: String)
}


class Dealer_OtherDocCell: UITableViewCell , UITextFieldDelegate{
    
    @IBOutlet var viewBGHeader:UIView!
    @IBOutlet var viewBGData:UIView!
    
    @IBOutlet  var btnPassportFront:UIButton!
    @IBOutlet  var btnPassportBack:UIButton!
    @IBOutlet  var btnLicenceFront:UIButton!
   
    
    
    @IBOutlet  var btnverifyLicence:UIButton!
    
    @IBOutlet var btnDropDown:UIButton!
    @IBOutlet var btnAddDoc:UIButton!
    
    
    @IBOutlet var btnSelectDrivingLic:UIButton!
    @IBOutlet var btnSelectPassportFront:UIButton!
    @IBOutlet var btnSelectPassportBack:UIButton!

    
    @IBOutlet var btnDoc1Verify:UIButton!
    @IBOutlet var btnDoc1Verified:UIButton!
    
    @IBOutlet var btnDoc2Verify:UIButton!
    @IBOutlet var btnDoc2Verified:UIButton!
    
    
    @IBOutlet var btnDoc1FrontIcon:UIButton!
    @IBOutlet var btnDoc1BackIcon:UIButton!
    
    @IBOutlet var btnDoc2FrontIcon:UIButton!
    @IBOutlet var btnDoc2BackIcon:UIButton!
    
    @IBOutlet var lblSelect1:UILabel!
    @IBOutlet var lblSelect2:UILabel!
    
    @IBOutlet var txtSelect1:DTTextField!
    @IBOutlet var txtSelect2:DTTextField!
    
    @IBOutlet var txtDOB:DTTextField!
    @IBOutlet var viewBG:UIView!


    var passportFront : String?
    var passportBack : String?
    var drivLicence : String?
    //other doc
    var doc1Front : String?
    var doc2Front : String?
    var doc1Back : String?
    var doc2Back : String?
 
    
    var docParamStr = [String:Any]()
    var otherDocDetais = OtherDocInfo()
    private let datePicker = UIDatePicker()
    
   

    var dateString = ""
 
    var buttonPressed : ((Int) -> Void) = {_ in }
    var buttonPressedAddView : ((Int) -> Void) = {_ in }
    var buttonRemoveDocView : ((Int) -> Void) = {_ in }
    var buttonDocBase64 : ((Int) -> Void) = {_ in }
    var buttonActionPopup : ((Int) -> Void) = {_ in }
    var btnVerifyDoc:((Int) -> Void) = {_ in}
    
    var btnDOB:((Int) -> Void) = {_ in}
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       // print("")
        
        viewBG.layer.shadowColor = UIColor.shadowViewclr.cgColor
        viewBG.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        viewBG.layer.shadowRadius = 2.0
        viewBG.layer.shadowOpacity = 0.3
        viewBG.layer.masksToBounds = false
        
        txtSelect1.delegate = self
        txtSelect2.delegate = self
        BaseViewController.setClrUItextField2(textFields: [txtDOB,txtSelect1, txtSelect2])
        
        txtDOB.addInputViewDatePicker(target: self, selector: #selector(doneButtonPressed))
        
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
           // Check which text field triggered the method
//           if textField == txtSelect1 {
//               self.btnDoc1Verify.isHidden = false
//               self.btnDoc1Verified.isHidden = true
//           } else if textField == txtSelect2 {
//               self.btnDoc2Verify.isHidden = false
//               self.btnDoc2Verified.isHidden = true
//           }
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
        if let  datePicker = self.txtDOB.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            self.txtDOB.text = dateFormatter.string(from: datePicker.date)
            dateFormatter.dateFormat = "yyyy-MM-dd"
            self.dateString = dateFormatter.string(from: datePicker.date)
        }
        self.txtDOB.resignFirstResponder()
     
    }
    
    func returnDOB() -> String{
        return dateString
    }
    
    func returnPassportNum() -> String{
        return self.txtSelect1.text ?? ""
    }
    
    func returnDrivLinceNum() -> String{
        return self.txtSelect2.text ?? ""
    }
    
    func returnDocArr() -> [OtherDocInfo]{
        var otherDetails = [OtherDocInfo]()
        if txtSelect1.text ?? "" != "" && ((txtSelect1.text?.isEmpty) != nil){
            self.otherDocDetais.otherDocumentType = self.lblSelect1.text ?? ""
            self.otherDocDetais.otherDocumentNumber = self.txtSelect1.text ?? ""
            self.otherDocDetais.otherDocument = self.doc1Front
            self.otherDocDetais.otherDocumentBack = self.doc1Back
            
            otherDetails.append(self.otherDocDetais)
        }
        
        if txtSelect2.text ?? "" != "" && ((txtSelect2.text?.isEmpty) != nil){
            self.otherDocDetais.otherDocumentType = self.lblSelect2.text ?? ""
            self.otherDocDetais.otherDocumentNumber = self.txtSelect2.text ?? ""
            self.otherDocDetais.otherDocument = self.doc2Front
            self.otherDocDetais.otherDocumentBack = self.doc2Back
            
            otherDetails.append(self.otherDocDetais)
        }
        
        return otherDetails
    }
    
    
   

    func setupData(isExpand:Bool){
        if isExpand{
            viewBGData.isHidden = true
            btnDropDown.setImage( UIImage(named: "d_down"), for: .normal)

        }
        else{
            viewBGData.isHidden = false
            btnDropDown.setImage(UIImage(named: "d_up"), for: .normal)
            
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    @IBAction func buttonAction(_ sender: UIButton) {
//        self.isExpanded.toggle()
       
        buttonPressed(sender.tag)
    }
    
    @IBAction func buttonActionAddDoc(_ sender: UIButton) {
        buttonPressedAddView(sender.tag)
        
    }
    
    @IBAction func buttonActionRemoveDoc(_ sender: UIButton) {
        buttonRemoveDocView(sender.tag)
        
    }
    
    @IBAction func buttonActionDocBase64(_ sender: UIButton) {
        buttonDocBase64(sender.tag)
        
    }
    
    @IBAction func buttonActionPopup(_ sender: UIButton) {
        buttonActionPopup(sender.tag)
        
    }
    
    @IBAction func btnActionVerifyDoc(_ sender:UIButton){
        self.btnVerifyDoc(sender.tag)
    }
    
    
    @IBAction func buttonActionGetDOB(_ sender: UIButton) {
        btnDOB(0)
    }
    

}





class CustomDatePicker: NSObject {
    
    private var datePicker: UIDatePicker
       private weak var viewController: UIViewController?
       weak var delegate: CustomDatePickerDelegate?
       
       override init() {
           datePicker = UIDatePicker()
           datePicker.datePickerMode = .date
           if #available(iOS 13.4, *) {
               datePicker.preferredDatePickerStyle = .wheels
           }
       }
       
       func showDatePicker(in viewController: UIViewController) {
           self.viewController = viewController
           
           let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
           
           // Add the date picker to the alert
           let pickerViewController = UIViewController()
           pickerViewController.preferredContentSize = CGSize(width: viewController.view.frame.width, height: 250)
           pickerViewController.view.addSubview(datePicker)
           
           datePicker.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([
               datePicker.leadingAnchor.constraint(equalTo: pickerViewController.view.leadingAnchor),
               datePicker.trailingAnchor.constraint(equalTo: pickerViewController.view.trailingAnchor),
               datePicker.topAnchor.constraint(equalTo: pickerViewController.view.topAnchor),
               datePicker.bottomAnchor.constraint(equalTo: pickerViewController.view.bottomAnchor)
           ])
           
           alert.setValue(pickerViewController, forKey: "contentViewController")
           
           let selectAction = UIAlertAction(title: "Select", style: .default) { _ in
               self.dateSelected()
           }
           
           let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
           
           alert.addAction(selectAction)
           alert.addAction(cancelAction)
           
           viewController.present(alert, animated: true, completion: nil)
       }
       
       private func dateSelected() {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "dd/MM/yyyy"
           let selectedDate = dateFormatter.string(from: datePicker.date)
           delegate?.didSelectDate(date: selectedDate)
       }
   }
