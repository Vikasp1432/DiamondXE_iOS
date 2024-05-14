//
//  Dealer_OtherDocCell.swift
//  DiamondXE
//
//  Created by iOS Developer on 29/04/24.
//

import UIKit

class Dealer_OtherDocCell: UITableViewCell , UITextFieldDelegate{
    
    @IBOutlet var viewBGHeader:UIView!
    @IBOutlet var viewBGData:UIView!
    
    @IBOutlet var viewBGData1:UIView!
    @IBOutlet var viewBGData2:UIView!
    
    @IBOutlet var viewAddDoc1:UIView!
    @IBOutlet var viewAddDoc2:UIView!
    
    @IBOutlet var viewAddDoc3:UIView!
    @IBOutlet var viewAddDoc4:UIView!
    
    @IBOutlet var btnDropDown:UIButton!
    @IBOutlet var btnAddDoc:UIButton!
    
    
    @IBOutlet var btnDropDown1c:UIButton!
    @IBOutlet var btnDropDown2c:UIButton!
    
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
    
    @IBOutlet var txtSelect1:FloatingTextField!
    @IBOutlet var txtSelect2:FloatingTextField!
    
    @IBOutlet var txtDOB:FloatingTextField!

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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       // print("")
        
        txtSelect1.delegate = self
        txtSelect2.delegate = self
        BaseViewController.setClrUItextField(textFields: [txtDOB,txtSelect1, txtSelect2])
        
        txtDOB.addInputViewDatePicker(target: self, selector: #selector(doneButtonPressed))

        
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
           // Check which text field triggered the method
           if textField == txtSelect1 {
               self.btnDoc1Verify.isHidden = false
               self.btnDoc1Verified.isHidden = true
           } else if textField == txtSelect2 {
               self.btnDoc2Verify.isHidden = false
               self.btnDoc2Verified.isHidden = true
           }
        
           return true
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
            btnDropDown.setImage( UIImage(named: "d_down"), for: .normal)

        }
        else{
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
    
}
