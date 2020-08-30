//
//  MainPresenter.swift
//  Cars catalog
//
//  Created by Fray Pineda on 8/29/20.
//  Copyright © 2020 New town. All rights reserved.
//

import Foundation
import UIKit

protocol MainVCDelegate {
    func getVehiclesSucceded(vehicles: [Vehicle])
    func getVehiclesFailed(error: String)
    func getCategoriesSucceded(categories: [VehicleCategory])
    func getCategoriesFailed(error: String)
}

class MainPresenter {
    var view: MainVCDelegate?
    init(view: MainVCDelegate) {
        self.view = view
    }
    
    func getVehicles() {
        MainService.getVehicles (successBlock: {[weak self] vehicles in
            self?.view?.getVehiclesSucceded(vehicles: vehicles)
        }, errorBlock: { [weak self] error in
            self?.view?.getVehiclesFailed(error: error)
        })
    }
    
    func getCategories() {
        MainService.getCategories(successBlock: {[weak self] categories in
            self?.view?.getCategoriesSucceded(categories: categories)
        }, errorBlock: { [weak self] error in
            self?.view?.getCategoriesFailed(error: error)
        })
    }
}
