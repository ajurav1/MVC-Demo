//
//  ItemDataModel.swift
//  MachineTest
//
//  Created by Ajay Walia on 25/04/18.
//  Copyright © 2018 mac min . All rights reserved.
//

import Foundation
struct ItemDataModel: Codable {
    var _id: String?
    var pic: ImageDataModel?
    var categoryName: String?
    var businessList: [BusinessDataModel]?
}
