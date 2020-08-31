//
//  SavingPresenter.swift
//  Cars catalog
//
//  Created by Fray Pineda on 8/30/20.
//  Copyright © 2020 New town. All rights reserved.
//


import Foundation
import UIKit

protocol ModifyView {
    func modifyVehicleSucceded(message: String)
    func modifyVehicleFailed(error: String)
}

protocol CategoryView {
    func saveCategorySucceded(message: String)
    func saveCategoryFailed(error: String)
}
class SavingPresenter {
    
    var vehicleView: ModifyView?
    var categoryView: CategoryView?
    
    init(view: ModifyView) {
        self.vehicleView = view
    }
    
    init(view: CategoryView) {
        self.categoryView = view
    }
    
    func updateVehicle(path: String, dict: [String: Any]) {
        StoreService.updateDocument(path: path, dict: dict, successBlock: { [weak self] message in
            self?.vehicleView?.modifyVehicleSucceded(message: message)
        }, errorBlock: { [weak self] error in
            self?.vehicleView?.modifyVehicleFailed(error: error)
        })
    }
    
    func saveNewCategory(dict: [String: Any]) {
        StoreService.saveNewCategory(dict: dict, successBlock: {[weak self] message in
            self?.categoryView?.saveCategorySucceded(message: message)
        }, errorBlock: {[weak self] error in
            self?.categoryView?.saveCategoryFailed(error: error)
        })
    }
}
