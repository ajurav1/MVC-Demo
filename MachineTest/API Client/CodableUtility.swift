//
//  CodableUtility.swift
//  MachineTest
//
//  Created by Ajay Kumar on 5/31/18.
//  Copyright © 2018 mac min . All rights reserved.
//

import Foundation

extension Encodable{
    func getData() throws -> Data {
        return try JSONEncoder().encode(self)
    }
    
}
extension Data{
    func asDictionary() throws -> [String: AnyObject] {
        guard let dictionary = try JSONSerialization.jsonObject(with: self, options: .allowFragments) as? [String: AnyObject] else {
            throw NSError()
        }
        return dictionary
    }
    func asArray() throws -> [[String: AnyObject]]{
        guard let array = try JSONSerialization.jsonObject(with: self, options: .allowFragments) as? [[String: AnyObject]] else {
            throw NSError()
        }
        return array
    }
}

extension Decodable{
    static func getDataModel(fromData jsonData: Data, completionHandler: (_ result: Result<Self, SAError>) -> ()){
        do {
            let apiResponse = try JSONDecoder().decode(Self.self, from: jsonData)
            completionHandler(Result.success(apiResponse))
        } catch {
            if let jsonDict = try? JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? NSDictionary{
                print(jsonDict ?? "unable to parse json object") //To see unexpected json data
            }
            completionHandler(Result.fail(SAError.init(error)))
        }
    }
    static func getDataModel(fromJsonObject object: Any, completionHandler: (_ result: Result<Self, SAError>) -> ()){
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: object, options: JSONSerialization.WritingOptions.prettyPrinted)
            let responseModel = try JSONDecoder().decode(Self.self, from: jsonData)
            completionHandler(Result.success(responseModel))
        } catch {
            completionHandler(Result.fail(SAError.init(error)))
        }
    }
}
