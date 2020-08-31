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

struct Localizables {
    struct MainVC {
        static let buttonTitle = NSLocalizedString("main_vc.button_title", comment: "")
    }
    
    struct DetailsForVehicleVC {
        static let buttonTitle = NSLocalizedString("details_for_vehicle_vc.button_title", comment: "")
        static let seatsLabel = NSLocalizedString("details_for_vehicle_vc.seats_label", comment: "")
        static let priceLabel = NSLocalizedString("details_for_vehicle_vc.price_label", comment: "")
        static let newOldLabel = NSLocalizedString("details_for_vehicle_vc.new_old_label", comment: "")
        static let modelLabel = NSLocalizedString("details_for_vehicle_vc.model_label", comment: "")
        static let releaseDateLabel = NSLocalizedString("details_for_vehicle_vc.release_date_label", comment: "")
        static let categoryLabel = NSLocalizedString("details_for_vehicle_vc.category_label", comment: "")
        static let spaceLabel = NSLocalizedString("details_for_vehicle_vc.space_label", comment: "")
        static let payloadLabel = NSLocalizedString("details_for_vehicle_vc.payload_label", comment: "")
        static let bateryLabel = NSLocalizedString("details_for_vehicle_vc.batery_label", comment: "")
    }
    
    struct ModifyVehicleVC {
         static let buttonTitle = NSLocalizedString("modify_vehicle_vc.button_title", comment: "")
         static let seatsLabel = NSLocalizedString("modify_vehicle_vc.seats_label", comment: "")
         static let priceLabel = NSLocalizedString("modify_vehicle_vc.price_label", comment: "")
         static let newOldLabel = NSLocalizedString("modify_vehicle_vc.new_old_label", comment: "")
         static let modelLabel = NSLocalizedString("modify_vehicle_vc.model_label", comment: "")
         static let releaseDateLabel = NSLocalizedString("modify_vehicle_vc.release_date_label", comment: "")
         static let categoryLabel = NSLocalizedString("modify_vehicle_vc.category_label", comment: "")
         static let spaceLabel = NSLocalizedString("modify_vehicle_vc.space_label", comment: "")
         static let payloadLabel = NSLocalizedString("modify_vehicle_vc.payload_label", comment: "")
         static let bateryLabel = NSLocalizedString("modify_vehicle_vc.batery_label", comment: "")
     }
    
    struct resultForTransactionVC {
        static let buttonTitle = NSLocalizedString("result_for_transaction.button_title", comment: "")
        static let descriptionLabel = NSLocalizedString("result_for_transaction.description_label", comment: "")
    }
    
    struct NewCategoryVC {
        static let mainTitleLabelText = NSLocalizedString("new_category_vc.main_title_label_text", comment: "")
        static let descriptionLabelText = NSLocalizedString("new_category_vc.description_label_text", comment: "")
        static let mainButtonTitle = NSLocalizedString("new_category_vc.main_button_title", comment: "")
    }
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
    case ELECTRICAL
    case COMMERCIAL
    case TRUCK
    case All
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
    case space
    case payload
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
