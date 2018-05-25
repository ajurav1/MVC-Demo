//
//  ViewController.swift
//  MachineTest
//
//  Created by Ajay Walia  on 25/04/18.
//  Copyright © 2018 mac min . All rights reserved.
//

import UIKit

class ItemListViewController: UIViewController {
    private var itemListView : ItemListView?
    
    @IBOutlet var service: ItemListViewControllerServiceManger!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemListView = self.view as? ItemListView
        service.delegate = self
        
        let itemData: ItemDataInput = ItemDataInput.init(languageId: "57db712ea202dc0eb1ee0f93", currentLocation: ["30","76"])
        service.getItemListData(itemDataInput: itemData)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
extension ItemListViewController: ItemListViewControllerServiceMangerDelegate{
    func itemListViewControllerServiceMangerDelegate(serviceManger: ItemListViewControllerServiceManger, didFetchingData data: [ItemDataModel]?){
        if let itemArry = data{
            self.itemListView?.updateItemList(itemData: itemArry)
        }
    }
}

