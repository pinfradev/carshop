//
//  ViewsFactory.swift
//  Cars catalog
//
//  Created by Fray Pineda on 8/29/20.
//  Copyright © 2020 New town. All rights reserved.
//

import Foundation
import UIKit

enum ViewType {
    case mainVC
    case detailsForVehicleVC
    case newCategoryVC
    case resultForTransactionVC
    case modifyVehicleVC
    case vehicleExtraInfoVC
}

class ViewsFactory {
    
    
    class func getViewControllerFromFactory(_ type: ViewType) -> UIViewController {
        var viewController = UIViewController()
        switch type {
            case .mainVC:
                let vc = MainVC(nibName: ViewControllersForApp.mainVC, bundle: nil)
                let nav = UINavigationController(rootViewController: vc)
                viewController = nav
                break
            case .detailsForVehicleVC:
                let vc = DetailsForVehicleVC(nibName: ViewControllersForApp.detailsForVehicleVC, bundle: nil)
                viewController = vc
                break
            case .newCategoryVC:
                let vc = NewCategoryVC(nibName: ViewControllersForApp.newCategoryVC, bundle: nil)
                viewController = vc
                break
            case .resultForTransactionVC:
                let vc = ResultForTransactionVC(nibName: ViewControllersForApp.resultForTransactionVC, bundle: nil)
                viewController = vc
                break
            case .modifyVehicleVC:
                let vc = ModifyVehicleVC(nibName: ViewControllersForApp.modifyVehicleVC, bundle: nil)
                viewController = vc
                break
            case .vehicleExtraInfoVC:
                let vc = VehicleExtraInfoVC(nibName: ViewControllersForApp.vehicleExtraInfoVC, bundle: nil)
                viewController = vc
        }
        
        return viewController
        
    }
}
