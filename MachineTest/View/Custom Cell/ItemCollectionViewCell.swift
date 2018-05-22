//
//  ItemCollectionViewCell.swift
//  MachineTest
//
//  Created by Ajay Walia on 25/04/18.
//  Copyright © 2018 mac min . All rights reserved.
//

import UIKit
import Kingfisher

class ItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    func updateCell(_ dataModel:BusinessDataModel) {
        if let imageString = dataModel.profilePic?.thumbnail, let imageUrl = URL(string: imageString){
            itemImageView.kf.setImage(with: imageUrl, placeholder: #imageLiteral(resourceName: "placeholder"))
        }else{
            itemImageView.image = #imageLiteral(resourceName: "placeholder")
        }
        if let titleText = dataModel.name{
            titleLabel.text = titleText
        }
        if let ratingText = dataModel.ratings{
            ratingLabel.text = ratingText + "/5.0"
        }
        if let businessAddress = dataModel.business_address, businessAddress.count > 0, let cityText = businessAddress.first?.city{
            subTitleLabel.text = cityText
        }
    }
}
