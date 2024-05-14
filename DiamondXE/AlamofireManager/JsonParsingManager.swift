//
//  JsonParsingManager.swift
//  OGenie
//
//  Created by Genie Talk on 01/05/23.
//

import Foundation
class JsonParsingManagar{
    
    static func parse<T: Codable>(jsonData: Data, type: T.Type) throws -> T {
        let decoder = JSONDecoder()
        do {
            let result = try decoder.decode(type, from: jsonData)
            return result
        } catch {
            if let decodingError = error as? DecodingError {
                    switch decodingError {
                    case .dataCorrupted(let context):
                        print("Data corrupted: \(context)")
                    case .keyNotFound(let key, let context):
                        print("Key not found: \(key.stringValue), \(context)")
                    case .valueNotFound(let type, let context):
                        print("Value not found: \(type), \(context)")
                    case .typeMismatch(let type, let context):
                        print("Type mismatch: \(type), \(context)")
                    @unknown default:
                        print("Unknown error")
                    }
                } else {
                    print("Unexpected error: \(error)")
                }
            
            throw error
        }
    }
    
}
