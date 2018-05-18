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
    private let serviceManger = ItemListViewControllerServiceManger()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        serviceManger.delegate = self
        itemListView = self.view as? ItemListView
        serviceManger.getItemListData()
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

