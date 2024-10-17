//
//  VideoHandler.swift
//  DiamondXE
//
//  Created by iOS Developer on 08/10/24.
//

import Foundation
import AVFoundation


class VideoHandler {
    var base64VideoArray = [String]()
    
    // Function to pick video and convert to Base64
    func processVideo(url: URL, completion: @escaping (String) -> Void) {
        // Compress the video
        compressVideo(inputURL: url) { compressedURL in
            guard let compressedURL = compressedURL else { return }
            
            // Convert to Data
            do {
                let videoData = try Data(contentsOf: compressedURL)
                
                // Convert to Base64 string
                let base64String = videoData.base64EncodedString(options: .lineLength64Characters)
                
                // Append to array
                self.base64VideoArray.append(base64String)
                
                // Return the Base64 string via completion handler
                completion(base64String)
                
            } catch {
                print("Error converting video to data: \(error)")
            }
        }
    }

    // Compress the video using AVAssetExportSession
    func compressVideo(inputURL: URL, completion: @escaping (URL?) -> Void) {
        let avAsset = AVURLAsset(url: inputURL)
        let exportSession = AVAssetExportSession(asset: avAsset, presetName: AVAssetExportPresetMediumQuality)
        
        // Create a temporary path to store the compressed video
        let compressedVideoPath = NSTemporaryDirectory() + UUID().uuidString + ".mp4"
        let compressedVideoURL = URL(fileURLWithPath: compressedVideoPath)
        
        exportSession?.outputURL = compressedVideoURL
        exportSession?.outputFileType = .mp4
        exportSession?.exportAsynchronously {
            switch exportSession?.status {
            case .completed:
                print("Video compressed successfully!")
                completion(compressedVideoURL)
            case .failed:
                print("Video compression failed: \(exportSession?.error?.localizedDescription ?? "Unknown error")")
                completion(nil)
            default:
                completion(nil)
            }
        }
    }
}
