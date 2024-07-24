//
//  LocationPinView.swift
//  DiamondXE
//
//  Created by iOS Developer on 21/06/24.
//

import UIKit
import CoreLocation
import UIView_Shimmer

extension UITextField: ShimmeringViewProtocol { }

class LocationPinView: BaseViewController, CLLocationManagerDelegate {

    //IBOutlets
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var doneButton: UIButton!
    @IBAction func doneButtonAction(_ sender: UIButton) {
        if sender.tag == 0 {
            hide()
        }
        else{
            pincodeDelagate?.didEnterPincode(pincode: self.txtPincode.text ?? "", indexPath: self.indexPath)
            hide()
        }
        
    }
    
    @IBOutlet var btnSubmit : UIButton!
    @IBOutlet var txtPincode : UITextField!
    let locationManager = CLLocationManager()
    
    var excludedItems: Set<UIView> {
        [txtPincode]
    }
    

    var pincodeDelagate : PinCodeDelegate?
    var indexPath = IndexPath()
    
    init() {
        super.init(nibName: "LocationPinView", bundle: nil)
        self.modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configView()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        btnSubmit.setGradientLayer(colorsInOrder: [UIColor.gradient2.cgColor, UIColor.gradient1.cgColor])
    }
    
  
    
    private func configView() {
        self.view.backgroundColor = .clear
        self.backView.backgroundColor = .black.withAlphaComponent(0.6)
        self.backView.alpha = 0
        self.contentView.alpha = 0
        self.contentView.layer.cornerRadius = 10
    }
    
    func appear(sender: UIViewController, pincode:Int) {
        sender.present(self, animated: false) {
            self.show()
           
            
        }
    }
    
    @IBAction func locatemeButtonAction(_ sender: UIButton) {
        // Check the authorization status before requesting location
               if CLLocationManager.authorizationStatus() == .authorizedWhenInUse || CLLocationManager.authorizationStatus() == .authorizedAlways {
                   txtPincode.setTemplateWithSubviews(true, animate: true)

                   if CLLocationManager.locationServicesEnabled() {
                       locationManager.requestLocation()
                   } else {
                       txtPincode.setTemplateWithSubviews(true, animate: false)
                       showLocationServicesDisabledAlert()
                   }
               } else {
                   locationManager.requestWhenInUseAuthorization()
               }
        
    }
    
    // CLLocationManagerDelegate method for location authorization status change
       func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
           if #available(iOS 14.0, *) {
               if manager.authorizationStatus == .authorizedWhenInUse || manager.authorizationStatus == .authorizedAlways {
                   locationManager.requestLocation()
               } else {
                   txtPincode.setTemplateWithSubviews(true, animate: false)
                   showLocationServicesDisabledAlert()
               }
           } else {
               // Fallback on earlier versions
           }
       }

       // CLLocationManagerDelegate method for successful location update
       func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
           if let location = locations.first {
               DispatchQueue.global(qos: .userInitiated).async {
                   self.reverseGeocode(location: location)
               }
           }
       }

       // CLLocationManagerDelegate method for location update failure
       func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
           print("Failed to get user location: \(error.localizedDescription)")
           // Handle error (e.g., show an alert to the user)
           showLocationErrorAlert(error: error)
       }

       // Method to reverse geocode the location to get postal code
       private func reverseGeocode(location: CLLocation) {
           let geocoder = CLGeocoder()
           geocoder.reverseGeocodeLocation(location) { [weak self] (placemarks, error) in
               if let error = error {
                   print("Reverse geocoding failed: \(error.localizedDescription)")
                   // Handle error
                   return
               }

               if let placemark = placemarks?.first {
                   DispatchQueue.main.async {
                       if let postalCode = placemark.postalCode, let city = placemark.locality {
                           self?.txtPincode.setTemplateWithSubviews(false, animate: false)
                           self?.txtPincode.text = "\(postalCode), \(city)"
                           print("Postal Code: \(postalCode)")
                       } else {
                           // Handle missing postal code
                           self?.txtPincode.text = "Postal code not found"
                       }
                   }
               }
               self?.txtPincode.setTemplateWithSubviews(false, animate: true)
           }
       }

       // Show alert if location services are disabled
       private func showLocationServicesDisabledAlert() {
           let alert = UIAlertController(title: "Location Services Disabled", message: "Please enable location services in Settings", preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
           present(alert, animated: true, completion: nil)
       }

       // Show alert for location errors
       private func showLocationErrorAlert(error: Error) {
           let alert = UIAlertController(title: "Location Error", message: error.localizedDescription, preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
           present(alert, animated: true, completion: nil)
       }
    
    
    private func show() {
        UIView.animate(withDuration: 0.2, delay: 0.0) {
            self.backView.alpha = 1
            self.contentView.alpha = 1
        }
    }
    
    func hide() {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut) {
            self.backView.alpha = 0
            self.contentView.alpha = 0
        } completion: { _ in
            self.dismiss(animated: false)
            self.removeFromParent()
        }
    }
}

