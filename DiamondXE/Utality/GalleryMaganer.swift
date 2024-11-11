//
//  PictureGallery.swift
//  DiamondXE
//
//  Created by iOS Developer on 03/05/24.
//

import Foundation
import UIKit




//class ImagePickerManager: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//
//    var picker = UIImagePickerController();
//    var alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
//    var viewController: UIViewController?
//    //var pickImageCallback : ((UIImage) -> ())?;
//    var pickImageBase64 : ((String) -> ())?;
//    
//    override init(){
//        super.init()
//        
//        picker.view.backgroundColor = .white
//        let cameraAction = UIAlertAction(title: "Camera", style: .default){
//            UIAlertAction in
//            self.openCamera()
//        }
//       // cameraAction.setValue(UIColor.themeClr, forKey: "titleTextColor")
//
//        
//        let galleryAction = UIAlertAction(title: "Gallery", style: .default){
//            UIAlertAction in
//            self.openGallery()
//        }
//        //galleryAction.setValue(UIColor.themeClr, forKey: "titleTextColor")
//
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel){
//            UIAlertAction in
//        }
//        cancelAction.setValue(UIColor.red, forKey: "titleTextColor")
//
//
//        // Add the actions
//        picker.delegate = self
//        alert.addAction(cameraAction)
//        alert.addAction(galleryAction)
//        alert.addAction(cancelAction)
//    }
//
//    func pickImage(_ viewController: UIViewController, _ callback: @escaping ((String) -> ())) {
//        pickImageBase64 = callback;
//        self.viewController = viewController;
//
//        alert.popoverPresentationController?.sourceView = self.viewController!.view
//
//        viewController.present(alert, animated: true, completion: nil)
//    }
//    func openCamera(){
//        alert.dismiss(animated: true, completion: nil)
//        if(UIImagePickerController .isSourceTypeAvailable(.camera)){
//            picker.sourceType = .camera
//            self.viewController!.present(picker, animated: true, completion: nil)
//        } else {
//            let alertController: UIAlertController = {
//                let controller = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
//                let action = UIAlertAction(title: "OK", style: .default)
//                controller.addAction(action)
//                return controller
//            }()
//            viewController?.present(alertController, animated: true)
//        }
//    }
//    func openGallery(){
//        alert.dismiss(animated: true, completion: nil)
//        picker.sourceType = .photoLibrary
//        self.viewController!.present(picker, animated: true, completion: nil)
//    }
//
//    
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        picker.dismiss(animated: true, completion: nil)
//    }
//   
//    // For Swift 4.2+
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        picker.dismiss(animated: true, completion: nil)
//        guard let image = info[.originalImage] as? UIImage else {
//            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
//        }
//       // pickImageCallback?(image)
//        // Convert image to Base64 string
//        let base64String = image.jpegData(compressionQuality: 0.5)?.base64EncodedString() ?? ""
//        pickImageBase64?(base64String)
//        
//    }
//
//
//
//    @objc func imagePickerController(_ picker: UIImagePickerController, pickedImage: UIImage?) {
//    }
//
//}


class ImagePickerManager: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var picker = UIImagePickerController()
    var alert = UIAlertController(title: "Choose Media", message: nil, preferredStyle: .actionSheet)
    var viewController: UIViewController?
    
    // Image callback (Base64)
    var pickImageBase64: ((String) -> ())?
    var pickImage: ((UIImage) -> ())?
    var pickedImage : UIImage?
    
    // Video callback (URL for multipart)
    var pickVideoURL: ((URL) -> ())?

    override init() {
        super.init()
        
        picker.view.backgroundColor = .white
      
    }

    enum MediaType {
        case video
        case image
    }

    // Picking an image
    func pickImage(_ viewController: UIViewController, _ callback: @escaping ((String) -> ())) {
        pickImageBase64 = callback
        self.viewController = viewController
        self.addButtonsO(showVideoOption: true)
        alert.popoverPresentationController?.sourceView = self.viewController!.view
        viewController.present(alert, animated: true, completion: nil)
    }
    
    func pickImageItem(_ viewController: UIViewController, _ callback: @escaping ((UIImage) -> ())) {
        pickImage = callback
        self.viewController = viewController
      //  self.pickedImage = img
        self.addButtonsO(showVideoOption: false)
        alert.popoverPresentationController?.sourceView = self.viewController!.view
        viewController.present(alert, animated: true, completion: nil)
    }
    
    
    
    func addButtonsO(showVideoOption: Bool){
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { UIAlertAction in
            self.openCamera()
        }
        alert.addAction(cameraAction)
        
        let galleryImageAction = UIAlertAction(title: "Gallery - Image", style: .default) { UIAlertAction in
            self.openGallery(forMediaType: .image)
        }
        alert.addAction(galleryImageAction)
        
        if showVideoOption {
            let galleryVideoAction = UIAlertAction(title: "Gallery - Video", style: .default) { UIAlertAction in
                self.openGallery(forMediaType: .video)
            }
            alert.addAction(galleryVideoAction)
        }
        
//        
//        if let pikedImg = pickedImage {
//               let removeImageAction = UIAlertAction(title: "Remove Image", style: .destructive) { _ in
//                   self.pickImage?(UIImage(named: "cameraIC")!)
//               }
//               alert.addAction(removeImageAction)
//        }
//        
        

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { UIAlertAction in }
        cancelAction.setValue(UIColor.red, forKey: "titleTextColor")
        
        picker.delegate = self
        alert.addAction(cancelAction)
    }
    

    // Picking a video
    func pickVideo(_ viewController: UIViewController, _ callback: @escaping ((URL) -> ())) {
        pickVideoURL = callback
        self.viewController = viewController
        alert.popoverPresentationController?.sourceView = self.viewController!.view
        viewController.present(alert, animated: true, completion: nil)
    }

    func openCamera() {
        alert.dismiss(animated: true, completion: nil)
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
            self.viewController!.present(picker, animated: true, completion: nil)
        } else {
            let alertController = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default)
            alertController.addAction(action)
            viewController?.present(alertController, animated: true)
        }
    }

    func openGallery(forMediaType mediaType: MediaType) {
        alert.dismiss(animated: true, completion: nil)
        picker.sourceType = .photoLibrary
        
        switch mediaType {
        case .image:
            picker.mediaTypes = ["public.image"]
        case .video:
            picker.mediaTypes = ["public.movie"]
        }
        
        self.viewController!.present(picker, animated: true, completion: nil)
    }

    // ImagePickerDelegate method
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

    // For Swift 4.2+
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        if let mediaType = info[.mediaType] as? String {
            if mediaType == "public.movie" {
                // Handle video selection
                guard let videoURL = info[.mediaURL] as? URL else { return }
                pickVideoURL?(videoURL)
            } else if mediaType == "public.image" {
                // Handle image selection
                guard let image = info[.originalImage] as? UIImage else { return }
                let base64String = image.jpegData(compressionQuality: 0.5)?.base64EncodedString() ?? ""
                pickImageBase64?(base64String)
                pickImage?(image)
                pickedImage = image
                
            }
        }
    }
    
    // Function to upload video and image as multipart
    func uploadMedia(videoURL: URL?, imageBase64: String?, to urlString: String, completion: @escaping (Bool, String?) -> ()) {
        let boundary = UUID().uuidString
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        // Build the multipart body
        var body = Data()

        // Video part
        if let videoURL = videoURL, let videoData = try? Data(contentsOf: videoURL) {
            let videoFileName = videoURL.lastPathComponent
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"video\"; filename=\"\(videoFileName)\"\r\n".data(using: .utf8)!)
            body.append("Content-Type: video/mp4\r\n\r\n".data(using: .utf8)!)
            body.append(videoData)
            body.append("\r\n".data(using: .utf8)!)
        }

        // Image part
        if let imageBase64 = imageBase64, let imageData = Data(base64Encoded: imageBase64) {
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"image\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
            body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
            body.append(imageData)
            body.append("\r\n".data(using: .utf8)!)
        }

        // End boundary
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)

        request.httpBody = body

        // Send the request
        let session = URLSession.shared
        session.uploadTask(with: request, from: body) { data, response, error in
            guard let data = data, error == nil else {
                completion(false, error?.localizedDescription)
                return
            }

            // Parse the response
            if let responseString = String(data: data, encoding: .utf8) {
                completion(true, responseString)
            } else {
                completion(false, "Failed to parse response")
            }
        }.resume()
    }
}
