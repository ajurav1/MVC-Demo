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
struct ItemDataInput: CodableModel{
    typealias dataType = ItemDataInput
    
    var languageId:String?
    var currentLocation:[String]?
}
class ItemListViewControllerServiceManger {
    weak var delegate: ItemListViewControllerServiceMangerDelegate?
    
    func getItemListData(){
        let itemDataInput: ItemDataInput = ItemDataInput.init(languageId: "57db712ea202dc0eb1ee0f93", currentLocation: ["30","76"])
        guard let inputData = itemDataInput.getJsonData() else {
            AppHelper.showAlert(title: "Error", subtitle: "Fail to prase input data")
            return
        }
        NetworkUtility.shareInstance.callData(requestType: .post, jsonInputData: inputData, path: "quickSearchCat") { (result) in
            switch result{
            case .success(let data):
                self.didPraseData(data)
                
            case .fail(let error):
                AppHelper.showAlert(error)
            }
        }
    }
    
    private func didPraseData(_ responseData: Data){
        APIResponseClient<[ItemDataModel]>.getDataModel(responseData) { (result) in
            switch result{
            case .success(let apiResponse):
                if apiResponse.validate(){
                    self.delegate?.itemListViewControllerServiceMangerDelegate(serviceManger: self, didFetchingData: apiResponse.data)
                }
                
            case .fail(let error):
                AppHelper.showAlert(error)
            }
        }
    }
}
