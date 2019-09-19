//
//  WebServiceClient.swift
//  MachineTest
//
//  Created by Ajay Walia  on 24/05/18.
//  Copyright © 2018 mac min . All rights reserved.
//

import Foundation

protocol WebServiceClient {
    associatedtype DataModel:Decodable
    typealias ResultData = (_ result: Result<DataModel, Error>) -> ()
    
    func callAPI(ofRequestType requestType: ReqestType ,withInputModel inputDataModel: Encodable?, atPath path: ServerURLs, completionHandler: @escaping ResultData)
}
extension WebServiceClient{
    func callAPI(ofRequestType requestType: ReqestType ,withInputModel inputDataModel: Encodable? = nil, atPath path: ServerURLs, completionHandler: @escaping ResultData){
        do{
            var inputData: Data?
            //encode model to data if needed
            if let inputModel = inputDataModel{
                inputData = try inputModel.getData()
            }
            //call network API
            NetworkUtility.shareInstance.callData(requestType: requestType, jsonInputData: inputData, subPath: path.rawValue) { (result) in
                switch result{
                case .success(let data):
                    //decode data to model
                    DataModel.getDataModel(fromData: data, completionHandler: { (result) in
                        completionHandler(result)
                    })
                case .failure(let error):
                    completionHandler(Result.failure(error))
                }
            }
        }
        catch {
            completionHandler(Result.failure(error))
        }
    }
}
