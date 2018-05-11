//
//  ItemDataModel.swift
//  MachineTest
//
//  Created by Ajay Walia on 05/05/18.
//  Copyright © 2018 mac min . All rights reserved.
//

import Foundation
protocol DataModel: Codable{
    associatedtype mineType
    static func getDataModel(_ jsonData: Data) -> mineType?
    func getJsonData() -> Data?
}
extension DataModel{
    static func getDataModel(_ jsonData: Data) -> mineType?{
        let jsonDecoder = JSONDecoder()
        if let apiResponse = try? jsonDecoder.decode(self, from: jsonData){
            if let apiData = apiResponse as? Self.mineType{
                return apiData
            }
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
