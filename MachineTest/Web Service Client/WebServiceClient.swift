//
//  WebServiceClient.swift
//  MachineTest
//
//  Created by Ajay Walia  on 24/05/18.
//  Copyright © 2018 mac min . All rights reserved.
//

import Foundation

class WebServiceClient<dataModel:CodableModel> {
    typealias resultData = (_ result: Result<dataModel, SAError>) -> ()
    static func callData(requestType: ReqestType ,inputData: Data? = nil, path:String, completionHandler: @escaping resultData){
        NetworkUtility.shareInstance.callData(requestType: requestType, jsonInputData: inputData, path: "quickSearchCat") { (result) in
            switch result{
            case .success(let data):
                dataModel.getDataModel(data, completionHandler: { (result) in
                    switch result{
                    case .success(let response):
                        completionHandler(Result.success(response as! dataModel))
                    case .fail(let error):
                        completionHandler(Result.fail(error))
                    }
                })
                
            case .fail(let error):
                completionHandler(Result.fail(error))
            }
        }
    }
}
