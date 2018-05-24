//
//  ItemDataModel.swift
//  MachineTest
//
//  Created by Ajay Walia on 25/04/18.
//  Copyright © 2018 mac min . All rights reserved.
//

import Foundation
struct ItemDataModel: Codable {
    var userdID: String?
    var pic: ImageDataModel?
    var categoryName: String?
    var businessList: [BusinessDataModel]?
    
    enum CodingKeys: String, CodingKey
    {
        case userdID = "_id"
        case pic
        case categoryName
        case businessList
    }
}

