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
        var inputData: Data?
        //encode model to data if needed
        if let inputModel = inputDataModel{
            guard let data = inputModel.getData() else{
                completionHandler(Result.fail(SAError.init(WebServiceError.dataParsingFailed, code: 1001, description: "Data Parsing Error")))
                return
            }
            inputData = data
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
}

extension Encodable{
    func getData() -> Data? {
        return try? JSONEncoder().encode(self)
    }
}

extension Decodable{
    static func getDataModel(fromData jsonData: Data, completionHandler: (_ result: Result<Self, SAError>) -> ()){
        do {
            let apiResponse = try JSONDecoder().decode(Self.self, from: jsonData)
            completionHandler(Result.success(apiResponse))
        } catch {
            if let jsonDict = try? JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? NSDictionary{
                print(jsonDict ?? "unable to parse json object") //To see unexpected json data
            }
            completionHandler(Result.fail(SAError.init(error, code: 1001, description: "Data Model Parsing Error")))
        }
    }
}
