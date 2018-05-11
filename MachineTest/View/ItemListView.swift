//
//  ItemListView.swift
//  MachineTest
//
//  Created by Ajay Walia  on 25/04/18.
//  Copyright © 2018 mac min . All rights reserved.
//

import UIKit

class ItemListView: UIView {
    @IBOutlet weak var itemCollectionView: UICollectionView!
    internal var itemArry = [ItemDataModel]()
    
    override func awakeFromNib() {
        self.registerCell()
    }
    
    func updateItemList(itemData:[ItemDataModel]) {
        itemArry = itemData.filter{$0.businessList?.count != 0}
        DispatchQueue.main.sync {
            self.itemCollectionView.reloadData()
        }
    }
    
    private func registerCell(){
        let nibHeader:UINib = UINib(nibName: "HeaderCell", bundle: nil)
        let nibFooter:UINib = UINib(nibName: "FooterCell", bundle: nil)
        self.itemCollectionView.register(nibHeader, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerCell")
        self.itemCollectionView.register(nibFooter, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footerCell")
    }
}
