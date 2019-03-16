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
class ItemListViewControllerServiceManger: NSObject, GetFireBaseClient, SetFireBaseClient, WebServiceClient{
    typealias DataModel = APIResponseClient<[ItemDataModel]>
    weak var delegate: ItemListViewControllerServiceMangerDelegate?
    
    func getItemListData(itemDataInput: ItemDataInput){
        self.getData(for: .realtime, fromChild: "quickSearchCat") { (result) in
            switch result{
            case .success(let apiResponse):
                if apiResponse.validate(){
                    self.delegate?.itemListViewControllerServiceMangerDelegate(serviceManger: self, didFetchingData: apiResponse.data)
                }else{
                    self.callWebAPI(itemDataInput)
                }
            case .fail(let error):
                AppHelper.showAlert(error)
                self.callWebAPI(itemDataInput)
            }
        }
    }
    func deleteData(){
        self.removeData(fromChild: "quickSearchCat") { (isError) in
            AppHelper.showAlert(isError)
        }
    }
    
    fileprivate func setModelToFirebase(model: Encodable){
        self.setData(withInputModel: model, atChild: "quickSearchCat") { (isError) in
            AppHelper.showAlert(isError)
        }
    }
    
    fileprivate func callWebAPI(_ itemDataInput: ItemDataInput) {
        self.callData(ofRequestType: ReqestType.post, withInputModel: itemDataInput, atPath: "quickSearchCat") { (result) in
            switch result{
            case .success(let apiResponse):
                if apiResponse.validate(){
                    self.delegate?.itemListViewControllerServiceMangerDelegate(serviceManger: self, didFetchingData: apiResponse.data)
                }
                self.setModelToFirebase(model: apiResponse)
                
            case .fail(let error):
                AppHelper.showAlert(error)
            }
        }
    }
}

