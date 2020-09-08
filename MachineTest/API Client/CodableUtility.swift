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
    
    func getJsonObject() throws -> Any{
        return try JSONSerialization.jsonObject(with: self.getData(), options: .allowFragments)
    }
    
    func getJsonObject() throws -> Any{
        return try JSONSerialization.jsonObject(with: self.getData(), options: .allowFragments)
    }
}

extension Decodable{
    static func getDataModel(fromData jsonData: Data, completionHandler: (_ result: Result<Self, Error>) -> ()){
        do {
            let apiResponse = try JSONDecoder().decode(Self.self, from: jsonData)
            completionHandler(Result.success(apiResponse))
        } catch {
            if let jsonDict = try? JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? NSDictionary{
                print(jsonDict ?? "unable to parse json object") //To see unexpected json data
            }
            completionHandler(Result.failure(error))
        }
    }
    static func getDataModel(fromJsonObject object: Any, completionHandler: (_ result: Result<Self, Error>) -> ()){
        do {
            let data = try JSONSerialization.data(withJSONObject: object, options: JSONSerialization.WritingOptions.prettyPrinted)
            self.getDataModel(fromData: data, completionHandler: { (result) in
                 completionHandler(result)
            })
        } catch {
            completionHandler(Result.failure(error))
        }
    }
}
extension URLComponents {
    mutating func setQueryItems(with parameters: [String: String]) {
        self.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
    }
}
