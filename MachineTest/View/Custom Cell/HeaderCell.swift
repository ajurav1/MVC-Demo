//
//  HeaderCell.swift
//  MachineTest
//
//  Created by Ajay Walia on 25/04/18.
//  Copyright © 2018 mac min . All rights reserved.
//

import UIKit

class HeaderCell: UICollectionReusableView {
    
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    func updateCell(_ dataModel:ItemDataModel) {
        if let imageString = dataModel.pic?.thumbnail, let imageUrl = URL(string: imageString){
            categoryImage.kf.setImage(with: imageUrl, placeholder: #imageLiteral(resourceName: "placeholder"))
        }
        if let titleText = dataModel.categoryName{
            titleLabel.text = titleText
            subTitleLabel.text = "Discover neraby " + titleText
        }
    }
}
