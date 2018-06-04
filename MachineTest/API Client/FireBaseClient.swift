//
//  WebServiceClient.swift
//  MachineTest
//
//  Created by Ajay Walia  on 24/05/18.
//  Copyright © 2018 mac min . All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

enum FirebaseObserveType:String{
    case once
    case realtime
}

class SetFireBaseClient{
    typealias ErrorData = (_ error: SAError) -> ()
    static func setData(withInputModel inputDataModel: Encodable, atChild path: String, completionHandler: @escaping ErrorData){
        do{
            let firebaseDataObject = try inputDataModel.getJsonObject()
            Database.database().reference().child(path).setValue(firebaseDataObject, withCompletionBlock: { (error:Error?, ref:DatabaseReference) in
                if let error = error {
                    completionHandler(SAError.init(error))
                }
            })
        }
        catch {
            completionHandler(SAError.init(error))
        }
    }
    static func removeData(fromChild path: String, completionHandler: @escaping ErrorData){
        Database.database().reference().child(path).removeValue { (error:Error?, ref:DatabaseReference) in
            if let error = error {
                completionHandler(SAError.init(error))
            }
        }
    }
}

class GetFireBaseClient<DataModel: Decodable> {
    typealias ResultData = (_ result: Result<DataModel, SAError>) -> ()
    static func getData(for type:FirebaseObserveType, fromChild path: String, completionHandler: @escaping ResultData){
        switch type {
        case .once:
            Database.database().reference().child(path).observeSingleEvent(of: DataEventType.value) { (snapshot) in
                self.parseSnapshot(snapshot, completionHandler: { (result) in
                    completionHandler(result)
                })
            }
            
        case .realtime:
            Database.database().reference().child(path).observe(DataEventType.value) { (snapshot) in
                self.parseSnapshot(snapshot, completionHandler: { (result) in
                    completionHandler(result)
                })
            }
            
        }
    }
    private static func parseSnapshot(_ snapshot: DataSnapshot, completionHandler: @escaping ResultData){
        if snapshot.exists(){
            DataModel.getDataModel(fromJsonObject: snapshot.value ?? [:], completionHandler: { (result) in
                completionHandler(result)
            })
            return
        }
        completionHandler(Result.fail(SAError.init(WebServiceError.invalidResponse, code: 1001, description: "Data not exist.")))
    }
}
