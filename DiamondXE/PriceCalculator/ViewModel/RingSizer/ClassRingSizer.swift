//
//  ClassRingSizer.swift
//  DXE Price
//
//  Created by iOS Developer on 12/04/24.
//

import Foundation
import UIKit
import QuartzCore

@IBDesignable
class RingSizer : UIView
{
    // Display ring size in the middle of the circle.
    private let textLabel : UILabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 70, height: 20))
    
    private let textLabel2 : UILabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 70, height: 20))
    
    private let textLabelHeading : UILabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 90, height: 40))
    
    // Stroke width of the arrows
    @IBInspectable var arrowStrokeWidth : CGFloat = 1.5
    // Stroke width of the lines of the grid
    @IBInspectable var linesStrokeWidth : CGFloat = 1.0
    // Stroke width of the circle upon which ring will be placed
    @IBInspectable var ringStrokeWidth  : CGFloat = 2.0
    
    // Diameter of the ring. Should be in mm
    @IBInspectable var diameter : CGFloat = 9.91
    // Color of the arrows drawn. To remove color set UIColor.clear
    @IBInspectable var arrowColor  : UIColor = UIColor.red
    // Color of the grid lines drawn. To remove color set UIColor.clear
    @IBInspectable var linesColor  : UIColor = UIColor.red
    // Color of the text of textLabel.
    @IBInspectable var textColor   : UIColor = UIColor.white
    // Color of the background of textLabel.
    @IBInspectable var textBgColor : UIColor = UIColor.systemBlue
    
    // Font of the textLabel. Default is 12 and system Font
    @IBInspectable var textFont : UIFont = UIFont.systemFont(ofSize: 12)
    // left and right text Padding to add in textLabel
    @IBInspectable var textPaddingWidth  : CGFloat = 10
    // top and bottom text Padding to add in textLabel
    @IBInspectable var textPaddingHeight : CGFloat = 5
    
    private var labelText : String = "00mm"
    private var mmConstant : CGFloat = 0.0779
    @IBInspectable var viewHeight : CGFloat = 0
    @IBInspectable var viewWidth : CGFloat = 0
    
    
    
    var isRingSizerOpen = Bool()
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.addSubview(self.textLabel)
        self.addSubview(self.textLabel2)
        self.addSubview(self.textLabelHeading)
        
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    
    func calculateRingSize(radius: Double) -> Double {
        // Formula for calculating ring size from radius
        return 2 * radius * Double.pi
    }
    
    private func  updateValues() -> Void
    {
        self.textLabel.textColor = textColor
        self.textLabel.font = textFont
        self.textLabel.textAlignment = NSTextAlignment.center
        self.textLabel.backgroundColor = textBgColor
        self.textLabel.text = labelText
        self.textLabel.layer.cornerRadius = 5.0
        self.textLabel.clipsToBounds = true
        
        self.textLabel2.textColor = textColor
        self.textLabel2.font = textFont
        self.textLabel2.textAlignment = NSTextAlignment.center
        self.textLabel2.backgroundColor = textBgColor
        self.textLabel2.text = labelText
        self.textLabel2.layer.cornerRadius = 5.0
        self.textLabel2.clipsToBounds = true
        
        self.textLabelHeading.textColor = .black
        self.textLabelHeading.font = textFont
        self.textLabelHeading.textAlignment = NSTextAlignment.center
        self.textLabelHeading.backgroundColor = textBgColor
        self.textLabelHeading.text = "Place your\nfinger here"
        self.textLabelHeading.layer.cornerRadius = 5.0
        self.textLabelHeading.clipsToBounds = true
        self.textLabelHeading.numberOfLines = 2
        
        
        
    }
    
    
    
    override func draw(_ rect: CGRect)
    {
        mmConstant = UIDevice().pointConversion
        let radius : CGFloat = self.diameter/2.0
        let distance : CGFloat = (radius / mmConstant)
        
        let midX : CGFloat = rect.size.width  / 2
        let midY : CGFloat = rect.size.height / 2
        let endX: CGFloat = rect.size.width - 15.0
        
        
        if let context = UIGraphicsGetCurrentContext()
        {
            // Creating grid lines
            context.setStrokeColor(linesColor.cgColor)
            context.setLineWidth(linesStrokeWidth)
            
            if isRingSizerOpen{
                // print("True")
                self.textLabel2.isHidden = true
                self.textLabelHeading.isHidden = true
                
                let blurEffect = UIBlurEffect(style: .light)

                
                let fillColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.5) // Set your desired fill color here
                context.setFillColor(fillColor.cgColor)
                
                //                context.setFillColor(UIColor(named: "clrBGLight")!.cgColor)
                let backgroundRect = CGRect(x: midX - distance, y: midY - distance, width: 2 * distance, height: 2 * distance)
                context.fillEllipse(in: backgroundRect)
                
                context.strokePath()
                // Creating ring
                let borderRect : CGRect = CGRect.init(x: midX - distance,
                                                      y: midY - distance,
                                                      width: 2 * distance,
                                                      height: 2 * distance)
                
                
                context.setStrokeColor(linesColor.cgColor)
                context.setLineWidth(ringStrokeWidth)
                context.strokeEllipse(in: borderRect)
                
                context.strokePath()
                
                self.updateValues()
                
                self.textLabel.sizeToFit()
                self.textLabel.frame = CGRect.init(x: 0, y: 0, width: self.textLabel.frame.size.width + textPaddingWidth, height: self.textLabel.frame.size.height + textPaddingHeight)
                self.textLabel.center = CGPoint.init(x: midX, y: midY)
                self.textLabel.removeFromSuperview()
                self.addSubview(self.textLabel)
                
                // We have to draw arrows now
                context.setStrokeColor(linesColor.cgColor)
                context.setLineWidth(linesStrokeWidth)
                context.move(to: CGPoint.init(x: midX - distance + 5, y: midY))
                context.addLine(to: CGPoint.init(x: self.textLabel.frame.origin.x - 5, y: midY))
                
                context.move(to: CGPoint.init(x: midX + distance - 5, y: midY))
                context.addLine(to: CGPoint.init(x: self.textLabel.frame.origin.x + self.textLabel.frame.size.width + 5, y: midY))
                
                context.strokePath()
                
                // Arrow to Left
                context.setStrokeColor(arrowColor.cgColor)
                context.setLineWidth(arrowStrokeWidth)
                
                context.move(to: CGPoint.init(x: midX - distance + 5, y: midY))
                context.addLine(to: CGPoint.init(x: midX - distance + 10, y: midY - 7))
                context.move(to: CGPoint.init(x: midX - distance + 5, y: midY))
                context.addLine(to: CGPoint.init(x: midX - distance + 10, y: midY + 7))
                
                // Arrow to Right
                context.move(to: CGPoint.init(x: midX + distance - 5, y: midY))
                context.addLine(to: CGPoint.init(x: midX + distance - 10, y: midY - 7))
                context.move(to: CGPoint.init(x: midX + distance - 5, y: midY))
                context.addLine(to: CGPoint.init(x: midX + distance - 10, y: midY + 7))
                
                
                context.strokePath()
                
            }
            else{
                
                let fillColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.5) // Set your desired fill color here
                context.setFillColor(fillColor.cgColor)
                
                let topLineY = midY - distance
                let bottomLineY = midY + distance
                
                let fillHeight = bottomLineY - topLineY
                let fillRect = CGRect(x: 0, y: topLineY, width: rect.size.width, height: fillHeight)
                context.fill(fillRect)
                // Creating grid lines
                context.setStrokeColor(linesColor.cgColor)
                context.setLineWidth(linesStrokeWidth)
                
                //            // line 1
                context.move(to: CGPoint.init(x: 0, y: (midY - distance)))
                context.addLine(to: CGPoint.init(x: rect.size.width, y: midY - distance))
                // line 2
                context.move(to: CGPoint.init(x: 0, y: (midY + distance)))
                context.addLine(to: CGPoint.init(x: rect.size.width, y: (midY + distance)))
                
                //                context.setFillColor(UIColor(named: "clrBGLight")!.cgColor)
                //                let backgroundRect = CGRect(x: 0, y: midY, width: 2 * distance, height: 2 * distance)
                //                        context.fillEllipse(in: backgroundRect)
                
                
                context.strokePath()
                self.updateValues()
                
                context.setStrokeColor(linesColor.cgColor)
                context.setLineWidth(linesStrokeWidth)
                
                self.textLabel.sizeToFit()
                self.textLabel.frame = CGRect.init(x: 0, y: midY - 15, width: self.textLabel.frame.size.width + textPaddingWidth, height: self.textLabel.frame.size.height + textPaddingHeight)
                self.textLabel.removeFromSuperview()
                self.addSubview(self.textLabel)
                
                
                context.move(to: CGPoint.init(x: 15 , y: midY - distance + 5))
                context.addLine(to: CGPoint.init(x: 15 , y: self.textLabel.frame.origin.y - 5))
                
                context.move(to: CGPoint.init(x: 15 , y: midY + distance - 5))
                context.addLine(to: CGPoint.init(x: 15, y: self.textLabel.frame.origin.y + self.textLabel.frame.size.height + 5))
                
                context.strokePath()
                
                self.textLabelHeading.isHidden = false
                self.textLabelHeading.sizeToFit()
                self.textLabelHeading.frame = CGRect.init(x: 0, y: 0, width: self.textLabelHeading.frame.size.width + textPaddingWidth, height: self.textLabelHeading.frame.size.height + textPaddingHeight)
                self.textLabelHeading.center = CGPoint.init(x: midX, y: midY)
                self.textLabelHeading.removeFromSuperview()
                self.addSubview(self.textLabelHeading)
                
                context.move(to: CGPoint.init(x: 15 , y: midY - distance + 5))
                context.addLine(to: CGPoint.init(x: 15 , y: self.textLabelHeading.frame.origin.y - 5))
                
                context.move(to: CGPoint.init(x: 15 , y: midY + distance - 5))
                context.addLine(to: CGPoint.init(x: 15, y: self.textLabelHeading.frame.origin.y + self.textLabelHeading.frame.size.height + 5))
                
                context.strokePath()
                
                // Arrow to Left
                context.setStrokeColor(arrowColor.cgColor)
                context.setLineWidth(arrowStrokeWidth)
                
                context.move(to: CGPoint.init(x: 15 , y: midY - distance + 5))
                context.addLine(to: CGPoint.init(x: 15 - 7 , y: midY - distance + 10))
                context.move(to: CGPoint.init(x: 15 , y: midY - distance + 5))
                context.addLine(to: CGPoint.init(x: 15 + 7 , y: midY  - distance + 10))
                
                // Arrow to Right
                context.move(to: CGPoint.init(x: 15, y: midY + distance - 5))
                context.addLine(to: CGPoint.init(x: 15 - 7, y: midY + distance - 10))
                context.move(to: CGPoint.init(x: 15 , y: midY + distance - 5))
                context.addLine(to: CGPoint.init(x: 15 + 7 , y: midY + distance - 10))
                
                context.strokePath()
                
                context.setStrokeColor(linesColor.cgColor)
                context.setLineWidth(linesStrokeWidth)
                
                self.textLabel2.isHidden = false
                
                self.textLabel2.sizeToFit()
                self.textLabel2.frame = CGRect.init(x: endX , y: midY - 15, width: self.textLabel2.frame.size.width + textPaddingWidth, height: self.textLabel2.frame.size.height + textPaddingHeight)
                self.textLabel2.center = CGPoint.init(x: endX - 15, y: midY)
                
                self.textLabel2.textAlignment = .left
                self.textLabel2.removeFromSuperview()
                self.addSubview(self.textLabel2)
                
                context.move(to: CGPoint.init(x: endX , y: midY - distance + 5))
                context.addLine(to: CGPoint.init(x: endX , y: self.textLabel.frame.origin.y - 5))
                
                context.move(to: CGPoint.init(x: endX , y: midY + distance - 5))
                context.addLine(to: CGPoint.init(x: endX, y: self.textLabel.frame.origin.y + self.textLabel.frame.size.height + 5))
                
                context.strokePath()
                
                // Arrow to Left
                context.setStrokeColor(arrowColor.cgColor)
                context.setLineWidth(arrowStrokeWidth)
                
                context.move(to: CGPoint.init(x: endX , y: midY - distance + 5))
                context.addLine(to: CGPoint.init(x: endX - 7 , y: midY - distance + 10))
                context.move(to: CGPoint.init(x: endX , y: midY - distance + 5))
                context.addLine(to: CGPoint.init(x: endX + 7 , y: midY  - distance + 10))
                
                // Arrow to Right
                context.move(to: CGPoint.init(x: endX, y: midY + distance - 5))
                context.addLine(to: CGPoint.init(x: endX - 7, y: midY + distance - 10))
                context.move(to: CGPoint.init(x: endX , y: midY + distance - 5))
                context.addLine(to: CGPoint.init(x: endX + 7 , y: midY + distance - 10))
                
                
                
                
                context.strokePath()
                
            }
            
            // line 3
            //            context.move(to: CGPoint.init(x: (midX - distance), y: 0))
            //            context.addLine(to: CGPoint.init(x: (midX - distance), y: rect.size.height))
            //            // line 4
            //            context.move(to: CGPoint.init(x: (midX + distance), y:0.0))
            //            context.addLine(to: CGPoint.init(x: (midX + distance), y:rect.size.height))
            
            backgroundColor = UIColor.white
            // Set up drawing context
            guard let context = UIGraphicsGetCurrentContext() else { return }
            
            // Set grid line properties
            let gridColor = UIColor(named: "ThemeClr")?.withAlphaComponent(0.5).cgColor
            let lineWidth: CGFloat = 0.5
            // Set vertical line properties
            let verticalLineCount = Int(bounds.width / 10)
            let verticalSpacing = bounds.width / CGFloat(verticalLineCount)
            
            // Draw vertical grid lines
            context.setStrokeColor(gridColor!)
            context.setLineWidth(lineWidth)
            for i in 1..<verticalLineCount {
                let x = CGFloat(i) * verticalSpacing
                context.move(to: CGPoint(x: x, y: 0))
                context.addLine(to: CGPoint(x: x, y: bounds.height))
            }
            
            // Set horizontal line properties
            let horizontalLineCount = Int(bounds.height / 10)
            let horizontalSpacing = bounds.height / CGFloat(horizontalLineCount)
            
            // Draw horizontal grid lines
            for i in 1..<horizontalLineCount {
                let y = CGFloat(i) * horizontalSpacing
                context.move(to: CGPoint(x: 0, y: y))
                context.addLine(to: CGPoint(x: bounds.width, y: y))
            }
            
            // Draw grid lines
            context.strokePath()
            
        }
    }
    
    
    func setSize(diameter: CGFloat, text: String) -> Void
    {
        self.labelText = "\(text)-IND"
        self.diameter = diameter
        self.setNeedsDisplay()
    }
    /* Get all ring sizes currently USA, Japan, Europe and Austrailia formats added */
    func getRingSizes() -> NSMutableArray
    {
        let ringSizes = NSMutableArray.init()
        if let filePath = Bundle.main.path(forResource: "sizes", ofType: "json")
        {
            if let data = NSData.init(contentsOfFile: filePath)
            {
                if let json = try? JSONSerialization.jsonObject(with: data as Data, options: []) as? [String:AnyObject]
                {
                    if let jsonArray = json["data"]!["sizes"] as? [[String: String]]
                    {
                        for jsonObject in jsonArray
                        {
                            let ringSizeModel : RingSizeModel = RingSizeModel.init(diameter_mm: CGFloat((jsonObject["diameter_mm"]! as NSString).floatValue), usaCode: jsonObject["usa"]!, inrCode: jsonObject["india"]!, diameter_eur: CGFloat((jsonObject["diameter_EUR"]! as NSString).floatValue), ukCode: jsonObject["diameter_UK"]!)
                            ringSizes.add(ringSizeModel)
                        }
                    }
                }
            }
        }
        
        return ringSizes
    }
}
