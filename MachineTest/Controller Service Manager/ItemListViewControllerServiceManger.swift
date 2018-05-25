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
class ItemListViewControllerServiceManger: NSObject{
    weak var delegate: ItemListViewControllerServiceMangerDelegate?
    
    func getItemListData(itemDataInput: ItemDataInput){
        WebServiceClient<APIResponseClient<[ItemDataModel]>>.callData(withRequestType: .post, itemDataInput, path: "quickSearchCat") { (result) in
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

