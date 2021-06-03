//
//  JsonUtil.swift
//  flux-ios-mensajeria
//
//  Created by Alex Cachiguango on 15/8/18.
//  Copyright © 2018 Kruger Corporation. All rights reserved.
//

import Foundation
class JsonUtil {
    /**
     - Parse de Data a objeto
     - Parameters:
     - value: json Data
     - myStruct: struct Decodable
     */
    static func decode<T: Decodable>(_ value: Data?, myStruct: T.Type) -> Decodable? {
        if let data = value, !data.isEmpty {
            do {
                return try JSONDecoder().decode(myStruct, from: data)
            } catch {
                debugPrint("Error serializing JSON: \(error)")
            }
        }
        return nil
    }
    /**
     - Parse de json a objeto
     - Parameters:
     - jsonData: json
     - myStruct: struct Decodable
     */
    static func decode<T: Decodable>(_ jsonData: String, myStruct: T.Type) -> Decodable? {
        if let data = jsonData.data(using: String.Encoding.utf8), !data.isEmpty {
            do {
                return try JSONDecoder().decode(myStruct, from: data)
            } catch {
                debugPrint("error serializing JSON: \(error)")
            }
        }
        return nil
    }
    static func decode<T: Decodable>(_ value: Any?, myStruct: T.Type) -> Decodable? {
        if let json = value {
            do {
                let data = try JSONSerialization.data(withJSONObject: json,
                                                      options: JSONSerialization.WritingOptions.prettyPrinted)
                return try JSONDecoder().decode(myStruct, from: data)
            } catch {
                debugPrint("error serializing JSON: \(error)")
            }
        }
        return nil
    }
    /**
     - Parse de string a Data
     - Parameters:
     - value: json
     */
    static func toData(_ value: String) -> Data? {
        if let data = value.data(using: String.Encoding.utf8) {
            return data
        }
        return nil
    }
    
}
