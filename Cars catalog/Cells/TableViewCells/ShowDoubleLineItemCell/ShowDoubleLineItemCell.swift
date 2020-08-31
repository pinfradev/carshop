//
//  ShowDoubleLineItemCell.swift
//  Cars catalog
//
//  Created by Fray Pineda on 8/29/20.
//  Copyright © 2020 New town. All rights reserved.
//

import UIKit

class ShowDoubleLineItemCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
        
        func setupUI(with style: TableCellStyles, vehicle: Vehicle) {
            let texts = Localizables.DetailsForVehicleVC.self
            switch style {
                case .numberOfSeats:
                    titleLabel.text = texts.seatsLabel
                    if let value = vehicle.numberOfSeats {
                        valueLabel.text = String(value)
                    }
                    break
                case .price:
                    titleLabel.text = texts.priceLabel
                    if let value = vehicle.price {
                        valueLabel.text = String(value)
                    }
                    break
                case .model:
                    titleLabel.text = texts.modelLabel
                    if let value = vehicle.model {
                        valueLabel.text = String(value)
                    }
                    break
                case .category:
                    titleLabel.text = texts.categoryLabel
                    if let value = vehicle.category {
                        valueLabel.text = String(value)
                    }
                    break
                case .date:
                    titleLabel.text = texts.releaseDateLabel
                    if let value = vehicle.date {
                        valueLabel.text = String(value)
                    }
                    break
                case .newOld:
                    titleLabel.text = vehicle.newOld ?? ""
                    valueLabel.isHidden = true
                case .space:
                    titleLabel.text = texts.spaceLabel
                    if let value = vehicle.space {
                        valueLabel.text = String(value)
                    }
                    break
                case .batteryCapacity:
                    titleLabel.text = texts.bateryLabel
                    if let value = vehicle.batery {
                        valueLabel.text = String(value)
                    }
                    break
                case .payload:
                    titleLabel.text = texts.payloadLabel
                    if let value = vehicle.payload{
                        valueLabel.text = String(value)
                    }
                    break
                default:
                    break
            }
        }
    
}
