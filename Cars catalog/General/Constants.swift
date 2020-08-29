//
//  Constants.swift
//  Cars catalog
//
//  Created by Fray Pineda on 8/29/20.
//  Copyright © 2020 New town. All rights reserved.
//

import Foundation
import UIKit

struct ViewControllersForApp {
    static let mainVC = "MainVC"
    static let detailsForVehicleVC = "DetailsForVehicleVC"
    static let newCategoryVC = "NewCategoryVC"
    static let resultForTransactionVC = "ResultForTransactionVC"
    static let modifyVehicleVC = "ModifyVehicleVC"
}

enum CollectionCellTypes {
    case catalogItemCell
}

struct CollectionCells {
    static func getCollectionCellIdentifier(_ type: CollectionCellTypes) -> String {
        switch type {
        case .catalogItemCell:
            return "CatalogItemCell"
        }
    }
        
    static func getSizeForCell(_ type: CollectionCellTypes) -> CGSize {
        switch type {
        case .catalogItemCell:
            return CGSize(width: 122.0, height: 129.0)
        }
    }
}

enum TableCellTypes {
    case addInfoItemCell(TableCellStyles)
    case showDoubleLineItemCell(TableCellStyles)
    case buttonCell
    case imageCell
}

enum InitialCategories: String {
    case Electrical
    case Commercial
    case Truck
}
enum TableCellStyles {
    case newCategory
    case numberOfSeats
    case price
    case newOld
    case model
    case date
    case category
    case batteryCapacity
}

struct TableCells {
    static func getCollectionCellIdentifier(_ type: TableCellTypes) -> String {
        switch type {
            case .addInfoItemCell(_):
                return "AddInfoItemCell"
            case .showDoubleLineItemCell(_):
                return "ShowDoubleLineItemCell"
            case .buttonCell:
                return "ButtonCell"
            case .imageCell:
                return "ImageCell"
        }
    }
        
    static func getHeightForCell(_ type: TableCellTypes) -> CGFloat {
        switch type {
            case .addInfoItemCell(_):
                return 91.0
            case .buttonCell:
                return 71.0
           case .showDoubleLineItemCell(_):
                return 75.0
            case .imageCell:
                return 165.0
        }
    }
}
