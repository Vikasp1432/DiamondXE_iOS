//
//  ReturnOrderParamSrtruct.swift
//  DiamondXE
//
//  Created by iOS Developer on 08/10/24.
//

import Foundation


struct ReturnDiaObject: Codable {
    var certificateno, reason, remark, videoURL, image, video: String?
    enum CodingKeys: String, CodingKey {
        case reason, remark, image, video
        case certificateno = "certificate_no"
        case videoURL = "video_url"
    }
    
    func toDictionary() -> [String: Any] {
           return [
               "certificate_no": certificateno ?? "",
               "reason": reason ?? "",
               "remark": remark ?? "",
               "video_url": videoURL ?? "",
               "image": image ?? "",
               "video": video ?? ""
           ]
       }
}
