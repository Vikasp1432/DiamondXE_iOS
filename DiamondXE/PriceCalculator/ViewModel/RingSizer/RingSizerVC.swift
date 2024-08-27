//
//  RingSigerVC.swift
//  DXE Price
//
//  Created by iOS Developer on 12/04/24.
//

import UIKit

class RingSizerVC: UIViewController {
   
    
    @IBOutlet var ringSizer : RingSizer!
    @IBOutlet var slider : UISlider!
    @IBOutlet var lbldescription : UILabel!
    @IBOutlet var sizerTableView : UITableView!
  
    @IBOutlet var btnRing : UIButton!
    @IBOutlet var BtnFinger  : UIButton!
    @IBOutlet var btnSliderMinus : UIButton!
    @IBOutlet var btnSliderPlus  : UIButton!
    
    var calculation = Calculation()
    var ringSizerInfo = RingSizerInfo()
    var ringSizes : NSMutableArray = NSMutableArray.init()
   

    override func viewDidLoad() {
        super.viewDidLoad()

        self.ringSizes = self.ringSizer.getRingSizes()
        self.ringSizer.textFont = UIFont(name: "Avenir Next Demi Bold", size: 16)!
        self.ringSizer.textColor = UIColor(named: "ThemeClr")!
        self.ringSizer.textBgColor = .clear

      //  self.ringSizer.arrowColor = UIColor.systemBlue;
        self.ringSizer.arrowStrokeWidth = 2

       // self.ringSizer.linesColor = UIColor.systemBlue;
        self.ringSizer.linesStrokeWidth = 1.5
        
       // self.ringSizer.linesColor = UIColor.red
        self.ringSizer.ringStrokeWidth = 1.8
        self.ringSizer.isRingSizerOpen = true

        
        if self.ringSizes.count > 1
        {
            self.slider.maximumValue = Float.init(self.ringSizes.count - 1)
        }
        
        self.ringSizer .setSize(diameter: 13, text: "1")
        
        slider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        
        sizerTableView.register(UINib(nibName: "RingSiZerTableCell", bundle: nil), forCellReuseIdentifier: "RingSiZerTableCell")


    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    
    @objc func sliderValueChanged(_ sender: UISlider) {
        let indexPath = IndexPath.init(row: Int.init(self.slider.value), section: 0)
        let ringSize : RingSizeModel = self.ringSizes.object(at: indexPath.row) as! RingSizeModel
        self.ringSizer.setSize(diameter: ringSize.diameter_mm, text: ringSize.inrCode!)

        self.sizerTableView.selectRow(at: indexPath, animated: true, scrollPosition: UITableView.ScrollPosition.none)
        self.sizerTableView.scrollToRow(at: indexPath, at: UITableView.ScrollPosition.none, animated: true)
        
        self.ringSizerInfo.mm =  self.calculation.decimalManage(value: Double(ringSize.diameter_mm) as Double)
        self.ringSizerInfo.uk =  ringSize.ukCode
        self.ringSizerInfo.usa =  ringSize.usaCode
        self.ringSizerInfo.ind =  ringSize.inrCode
        self.ringSizerInfo.eur =  "\(Double(ringSize.diameter_eur) as Double)"
        
    }

    @IBAction func btnActionRingSelect(_ sender:UIButton){
        self.lbldescription.text = "Put the ring on the circle and adjust the slider to measure ring size."
        self.btnRing.backgroundColor = UIColor(named: "ThemeClr")
        self.BtnFinger.backgroundColor = UIColor(named: "whiteBG")
        self.BtnFinger.setTitleColor(UIColor(named: "ThemeClr"), for: .normal)
        self.btnRing.setTitleColor(UIColor(named: "whiteBG"), for: .normal)
        self.ringSizer.isRingSizerOpen = true
        self.ringSizer.setNeedsDisplay()
        
    }
    
    @IBAction func btnActionBack(_ sender : UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnActionFingerSelect(_ sender:UIButton){
        self.lbldescription.text = "Put your finger between the two golden lines and adjust using the slider."
        self.BtnFinger.backgroundColor = UIColor(named: "ThemeClr")
        self.btnRing.backgroundColor = UIColor(named: "whiteBG")
        self.BtnFinger.setTitleColor(UIColor(named: "whiteBG"), for: .normal)
        self.btnRing.setTitleColor(UIColor(named: "ThemeClr"), for: .normal)
        self.ringSizer.isRingSizerOpen = false
        self.ringSizer.setNeedsDisplay()

    }
    
    @IBAction func btnActionSlidlerPlus(_ sender:UIButton){
        let newValue = slider.value + 1
        slider.setValue(newValue, animated: true)
        
        let indexPath = IndexPath.init(row: Int.init(self.slider.value), section: 0)
        let ringSize : RingSizeModel = self.ringSizes.object(at: indexPath.row) as! RingSizeModel
        self.ringSizer.setSize(diameter: ringSize.diameter_mm, text: ringSize.inrCode!)
        
        self.sizerTableView.selectRow(at: indexPath, animated: true, scrollPosition: UITableView.ScrollPosition.none)
        self.sizerTableView.scrollToRow(at: indexPath, at: UITableView.ScrollPosition.none, animated: true)
        
        self.ringSizerInfo.mm =  self.calculation.decimalManage(value: Double(ringSize.diameter_mm) as Double)
        self.ringSizerInfo.uk =  ringSize.ukCode
        self.ringSizerInfo.usa =  ringSize.usaCode
        self.ringSizerInfo.ind =  ringSize.inrCode
        self.ringSizerInfo.eur =  "\(Double(ringSize.diameter_eur) as Double)"
        
    }
    
    @IBAction func btnActionSlidlerMinus(_ sender:UIButton){
        let newValue = slider.value - 1
        slider.setValue(newValue, animated: true)
        
        let indexPath = IndexPath.init(row: Int.init(self.slider.value), section: 0)
        let ringSize : RingSizeModel = self.ringSizes.object(at: indexPath.row) as! RingSizeModel
        self.ringSizer.setSize(diameter: ringSize.diameter_mm, text: ringSize.inrCode!)
        
       
        self.sizerTableView.selectRow(at: indexPath, animated: true, scrollPosition: UITableView.ScrollPosition.none)
        self.sizerTableView.scrollToRow(at: indexPath, at: UITableView.ScrollPosition.none, animated: true)
        
        self.ringSizerInfo.mm =  self.calculation.decimalManage(value: Double(ringSize.diameter_mm) as Double)
        self.ringSizerInfo.uk =  ringSize.ukCode
        self.ringSizerInfo.usa =  ringSize.usaCode
        self.ringSizerInfo.ind =  ringSize.inrCode
        self.ringSizerInfo.eur =  "\(Double(ringSize.diameter_eur) as Double)"
//        
        
    }
    
    
    @IBAction func btnActionShareSheet(_ sender : UIButton){
        let storyboard = UIStoryboard(name: "RingSizer", bundle: nil)
                let alertSheet = storyboard.instantiateViewController(withIdentifier: "RingSizeShareSheet") as? RingSizeShareSheet
        alertSheet?.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        alertSheet?.ringSizerInfo = self.ringSizerInfo
        alertSheet?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(alertSheet!, animated: true, completion: nil)
        
       
    }

}

extension RingSizerVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ringSizes.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RingSiZerTableCell", for: indexPath) as! RingSiZerTableCell
        let ringSize : RingSizeModel = self.ringSizes.object(at: indexPath.row) as! RingSizeModel
        // set the text from the data model
        cell.lblMM.text = self.calculation.decimalManage(value: Double(ringSize.diameter_mm) as Double) //"\(Double(ringSize.diameter_mm) as Double)"
        cell.lblIEUR.text = "\(Double(ringSize.diameter_eur) as Double)"
        cell.lblUS.text = ringSize.usaCode! as String
        cell.lblIUK.text = ringSize.ukCode! as String
        cell.lblIND.text = ringSize.inrCode! as String
        

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let ringSize : RingSizeModel = self.ringSizes.object(at: indexPath.row) as! RingSizeModel
        self.ringSizer.setSize(diameter: ringSize.diameter_mm, text: ringSize.inrCode!)
        self.ringSizerInfo.mm =  self.calculation.decimalManage(value: Double(ringSize.diameter_mm) as Double)
        self.ringSizerInfo.uk =  ringSize.ukCode
        self.ringSizerInfo.usa =  ringSize.usaCode
        self.ringSizerInfo.ind =  ringSize.inrCode
        self.ringSizerInfo.eur =  "\(Double(ringSize.diameter_eur) as Double)"
        slider.setValue(Float(indexPath.row), animated: true)
    }
}
