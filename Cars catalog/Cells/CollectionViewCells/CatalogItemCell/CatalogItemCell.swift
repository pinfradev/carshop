//
//  CatalogItemCell.swift
//  Cars catalog
//
//  Created by Fray Pineda on 8/29/20.
//  Copyright © 2020 New town. All rights reserved.
//

import UIKit
import SDWebImage

class CatalogItemCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupUI(vehicle: Vehicle) {
        if let photo = vehicle.urlPhoto {
            imageView.sd_setImage(with: photo, completed: nil)
        }
        
        if let title = vehicle.model{
            titleLabel.text = title
        }
    }

}
