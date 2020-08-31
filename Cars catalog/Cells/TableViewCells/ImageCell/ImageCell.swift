//
//  ImageCell.swift
//  Cars catalog
//
//  Created by Fray Pineda on 8/29/20.
//  Copyright © 2020 New town. All rights reserved.
//

import UIKit
import SDWebImage

class ImageCell: UITableViewCell {

    
    @IBOutlet weak var carImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    func loadImage(with url: URL) {
        carImage.sd_setImage(with: url, completed: nil)
    }
    
}
