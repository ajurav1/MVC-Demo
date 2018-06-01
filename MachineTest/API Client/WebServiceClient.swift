//
//  WebServiceClient.swift
//  MachineTest
//
//  Created by Ajay Walia  on 24/05/18.
//  Copyright © 2018 mac min . All rights reserved.
//

import Foundation

enum ReqestType:String{
    case post = "POST"
    case get = "GET"
}

enum WebServiceError: Error{
    case dataParsingFailed
    case dataModelParsingFailed
    case invalidResponse
    case resultValidationFailed
    case networkNotReachable
    case invalidUrl
    case jsonParsingFailed
}

class WebServiceClient<DataModel:Decodable> {
    typealias ResultData = (_ result: Result<DataModel, SAError>) -> ()
    
    static func callData(ofRequestType requestType: ReqestType ,withInputModel inputDataModel: Encodable? = nil, atPath path:String, completionHandler: @escaping ResultData){
        do{
            var inputData: Data?
            //encode model to data if needed
            if let inputModel = inputDataModel{
                inputData = try inputModel.getData()
            }
            //call network API
            NetworkUtility.shareInstance.callData(requestType: requestType, jsonInputData: inputData, subPath: path) { (result) in
                switch result{
                case .success(let data):
                    //decode data to model
                    DataModel.getDataModel(fromData: data, completionHandler: { (result) in
                        completionHandler(result)
                    })
                case .fail(let error):
                    completionHandler(Result.fail(error))
                }
            }
        }
        catch {
            completionHandler(Result.fail(SAError.init(error)))
        }
    }
}
