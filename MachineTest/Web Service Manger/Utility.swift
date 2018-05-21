//
//  Utility.swift
//  MachineTest
//
//  Created by Ajay Walia  on 25/04/18.
//  Copyright © 2018 mac min . All rights reserved.
//
import Foundation
import UIKit

class Helper{
    static func showAlert(title:String, subtitle:String){
        DispatchQueue.main.async(execute: {
            let sb = AppStoryboards.main.getController(withIdentifier: "sadas")
            let alert = UIAlertController(title: title, message: subtitle, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil))
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window!.rootViewController?.present(alert, animated: true, completion: nil)
        })
    }
}

enum AppStoryboards : String {
    case main = "Main"
    
    func getController<T:UIViewController>(withIdentifier identifier: String) -> T{
        return UIStoryboard(name: self.rawValue, bundle: nil).instantiateViewController(withIdentifier: identifier) as! T
    }
}
// USAGE :
//﻿let storyboard = AppStoryboard.Main.instance

