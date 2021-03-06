//
//  ItemDataModel.swift
//  MachineTest
//
//  Created by Ajay Walia on 05/05/18.
//  Copyright © 2018 mac min . All rights reserved.
//

import Foundation
struct APIResponseClient<T: Codable>: Codable{
    var statusCode: Int?
    var message: String?
    var data: T?
    
    func validate() -> Bool {
        if self.statusCode != 200{
            AppHelper.showAlert(title: "Validation Error " + String(statusCode ?? 1001), subtitle: self.message ?? "No meesage")
            return false
        }
        return true
    }
}
