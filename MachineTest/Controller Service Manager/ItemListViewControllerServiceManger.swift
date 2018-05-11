//
//  ItemListViewControllerServiceManger.swift
//  MachineTest
//
//  Created by Ajay Walia  on 25/04/18.
//  Copyright © 2018 mac min . All rights reserved.
//

import Foundation

protocol ItemListViewControllerServiceMangerDelegate : class{
    func itemListViewControllerServiceMangerDelegate(serviceManger: ItemListViewControllerServiceManger, didFetchingData data: [ItemDataModel]?)
}
struct ItemDataInput: DataModel{
    typealias T = ItemDataInput
    var languageId:String?
    var currentLocation:[String]?
}
class ItemListViewControllerServiceManger {
    weak var delegate: ItemListViewControllerServiceMangerDelegate?
    
    func getItemListData(){
        let itemDataInput: ItemDataInput = ItemDataInput.init(languageId: "57db712ea202dc0eb1ee0f93", currentLocation: ["30","76"])
        guard let inputData = itemDataInput.getJsonData() else {
            return
        }
        NetworkUtility.shareInstance.callData(jsonInputData: inputData, path: "quickSearchCat") { (responseData) in
            guard let apiResponse = APIResponseClient<[ItemDataModel]>.getDataModel(responseData) else {
                Helper.showAlert(title: "Error", subtitle: "Unable To Parse Data")
                return
            }
            if apiResponse.validate(){
                self.delegate?.itemListViewControllerServiceMangerDelegate(serviceManger: self, didFetchingData: apiResponse.data)
            }
        }
    }
}
