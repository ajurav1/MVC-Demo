//
//  Result.swift
//  MachineTest
//
//  Created by Ajay Walia on 23/05/18.
//  Copyright © 2018 mac min . All rights reserved.
//

import Foundation

enum Result<T,U: SAError>{
    case success(T)
    case fail(U)
}

class SAError {
    var error: Error
    var code: Int?
    var description: String?
    
    init(_ error: Error) {
        self.error = error
    }
    
    init(_ error: Error, code: Int? = nil, description: String? = nil) {
        self.error = error
        self.code = code
        self.description = description
    }
}
enum WebServiceError: Error{
    case dataModelParsingFailed
    case invalidResponse
    case resultValidationFailed
    case networkNotReachable
    case invalidUrl
    case jsonParsingFailed
}
