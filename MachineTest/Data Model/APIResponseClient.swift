//
//  ItemDataModel.swift
//  MachineTest
//
//  Created by Ajay Walia on 05/05/18.
//  Copyright © 2018 mac min . All rights reserved.
//

import Foundation
struct APIResponseClient<T1: Codable>: DataModel{
    typealias T = APIResponseClient<T1>
    var statusCode: Int?
    var message: String?
    var data: T1?
    
    func validate() -> Bool {
        if self.statusCode != 200{
            Helper.showAlert(title: "Error", subtitle: self.message ?? "No meesage")
            return false
        }
        return true
    }
}