//
//  ItemDataModel.swift
//  MachineTest
//
//  Created by Ajay Walia on 05/05/18.
//  Copyright © 2018 mac min . All rights reserved.


import Foundation
protocol CodableModel: Codable{
    associatedtype dataType : Decodable
    static func getDataModel(_ jsonData: Data) -> dataType?
    func getJsonData() -> Data?
}
extension CodableModel{
    static func getDataModel(_ jsonData: Data) -> dataType?{
        let jsonDecoder = JSONDecoder()
        if let apiResponse = try? jsonDecoder.decode(dataType.self, from: jsonData){
            return apiResponse
        }
        
        if let jsonDict = try? JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? NSDictionary{
            print(jsonDict ?? "unable to parse json object") //To see unexpected json data
        }
        
        return nil
    }
    func getJsonData() -> Data? {
        let jsonEncoder = JSONEncoder()
        if let data = try? jsonEncoder.encode(self){
            return data
        }
        return nil
    }
}
