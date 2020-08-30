//
//  CatalogItemCell.swift
//  Cars catalog
//
//  Created by Fray Pineda on 8/29/20.
//  Copyright © 2020 New town. All rights reserved.
//

import UIKit

class CatalogItemCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupUI(vehicle: Vehicle) {
        if let photo = vehicle.photo {
            
        }
        
        if let title = vehicle.model{
            titleLabel.text = title
        }
    }

}
