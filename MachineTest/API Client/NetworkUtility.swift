//
//  NetworkUtility.swift
//  MachineTest
//
//  Created by Ajay Walia  on 25/04/18.
//  Copyright © 2018 mac min . All rights reserved.
//

import Foundation
import SystemConfiguration

enum ReqestType:String{
    case post = "POST"
    case get = "GET"
}

enum JsonError: String, Error {
    case dataParsingFailed
    case dataModelParsingFailed
    case invalidResponse
    case resultValidationFailed
    case networkNotReachable
    case invalidUrl
    case jsonParsingFailed
}

class NetworkUtility {    
    typealias ResultData = (_ result: Result<Data, Error>) -> ()
    static let shareInstance = NetworkUtility()
    private init(){}

    func callData(requestType: ReqestType , jsonInputData: Data?, query: [String : String]?, subPath:String, completion: @escaping ResultData){
        if isInternetAvailable() {
            let urlPath = BaseUrl + subPath
            guard var urlComp = URLComponents(string: urlPath) else {
                completion(Result.failure(JsonError.invalidUrl))
                return
            }
            if requestType == .get, let query = query{
                urlComp.setQueryItems(with: query)
            }
            guard let url = urlComp.url else {
                completion(Result.failure(JsonError.invalidUrl))
                return
            }
            var request = URLRequest(url: url)
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = requestType.rawValue
            if requestType == .post , jsonInputData != nil{
                request.httpBody = jsonInputData!
            }
            URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
                do{
                    guard let data = data else{
                        throw JsonError.dataParsingFailed
                    }
                    completion(Result.success(data))
                }
                catch {
                    completion(Result.failure(error))
                }
                }.resume()
        }else{
            completion(Result.failure(JsonError.networkNotReachable))
        }
    }
    private func isInternetAvailable() -> Bool{
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
}
