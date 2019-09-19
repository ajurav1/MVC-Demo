//
//  Utility.swift
//  MachineTest
//
//  Created by Ajay Walia  on 25/04/18.
//  Copyright © 2018 mac min . All rights reserved.
//
import Foundation
import UIKit

class AppHelper{
    static func showAlert(title: String, subtitle: String){
        DispatchQueue.main.async(execute: {
            let alert = UIAlertController(title: title, message: subtitle, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil))
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window!.rootViewController?.present(alert, animated: true, completion: nil)
        })
    }
    static func showAlert(_ error: Error){
        self.showAlert(title: "Error", subtitle: error.localizedDescription)
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//Usage>>//let controller = AppController<ItemListViewController>.getInstance(withStoryboard: .main, withIdentifier: "ItemListViewController")

class AppController<T:UIViewController>{
    static func getInstance(withStoryboard storyboardType: AppStoryboardType, withIdentifier identifier: String) -> T{
        return UIStoryboard(name: storyboardType.rawValue, bundle: nil).instantiateViewController(withIdentifier: identifier) as! T
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
extension UIView{
    class func loadFromNib(named name: String, bundle: Bundle? = nil) -> UIView? {
        return UINib(nibName: name, bundle: bundle).instantiate(withOwner: nil, options: nil)[0] as? UIView
    }
}
