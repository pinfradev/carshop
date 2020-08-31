//
//  AddInfoItemCell.swift
//  Cars catalog
//
//  Created by Fray Pineda on 8/29/20.
//  Copyright © 2020 New town. All rights reserved.
//

import UIKit

class AddInfoItemCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueTextField: UITextField!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       self.selectionStyle = .none
    }
    
    func setupUI(with style: TableCellStyles, vehicle: Vehicle) {
        let texts = Localizables.ModifyVehicleVC.self
        switch style {
            case .numberOfSeats:
                titleLabel.text = texts.seatsLabel
                if let value = vehicle.numberOfSeats {
                    valueTextField.text = String(value)
                }
                break
            case .price:
                titleLabel.text = texts.priceLabel
                if let value = vehicle.price {
                    valueTextField.text = String(value)
                }
                break
            case .model:
                titleLabel.text = texts.modelLabel
                if let value = vehicle.model {
                    valueTextField.text = String(value)
                }
                break
            case .category:
                titleLabel.text = texts.categoryLabel
                if let value = vehicle.category {
                    valueTextField.text = String(value)
                }
                break
            case .date:
                titleLabel.text = texts.releaseDateLabel
                if let value = vehicle.date {
                    valueTextField.text = String(value)
                }
                break
            case .newOld:
                titleLabel.text = texts.newOldLabel
                if let value = vehicle.newOld {
                    valueTextField.text = value
                }
            case .space:
                titleLabel.text = texts.spaceLabel
                if let value = vehicle.space {
                    valueTextField.text = String(value)
                }
                break
            case .batteryCapacity:
                titleLabel.text = texts.bateryLabel
                if let value = vehicle.batery {
                    valueTextField.text = String(value)
                }
                break
            case .payload:
                titleLabel.text = texts.payloadLabel
                if let value = vehicle.payload{
                    valueTextField.text = String(value)
                }
                break
            default:
                break
        }
    }
    
}
