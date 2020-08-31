//
//  MainService.swift
//  Cars catalog
//
//  Created by Fray Pineda on 8/29/20.
//  Copyright © 2020 New town. All rights reserved.
//

import Foundation
import Firebase

class MainService {
   class func getVehicles(successBlock: @escaping (_ vehicles: [Vehicle]) -> (), errorBlock: @escaping (_ error: String) -> ()) {
        let db = Firestore.firestore()
        var vehiclesArray: [Vehicle] = []
        db.collection("vehicles").getDocuments() { (result, err) in
            if let err = err {
                errorBlock("An error \(err) has ocurred")
                return
            } else {
                for document in result!.documents {
                    let currentVehicle = Vehicle()
                    let currentDocument = document.data()
                    
                    currentVehicle.documentPath = document.reference.path
                    if let seats = currentDocument["numberOfSeats"] as? Int {
                        currentVehicle.numberOfSeats = seats
                    }
                    if let price = currentDocument["price"] as? Double {
                        currentVehicle.price = price
                    }
                    if let newOld = currentDocument["newOld"] as? String {
                        currentVehicle.newOld = newOld
                    }
                    if let photo = currentDocument["photo"] as? String {
                        currentVehicle.photo = photo
                    }
                    if let model = currentDocument["model"] as? String {
                        currentVehicle.model = model
                    }
                    if let date = currentDocument["date"] as? Int {
                        currentVehicle.date = date
                    }
                    if let payload = currentDocument["payload"] as? Double {
                        currentVehicle.payload = payload
                    }
                    if let batery = currentDocument["batery"] as? String {
                        currentVehicle.batery = batery
                    }
                    if let space = currentDocument["space"] as? String {
                        currentVehicle.space = space
                    }
                    if let category = currentDocument["category"] as? DocumentReference{
                        currentVehicle.categoryReference = category
                        category.getDocument(completion: { res,e in
                            if let e = e {
                                print("el error es: \(e)")
                            } else {
                                if let data = res?.data() {
                                    if let cat = data["name"] as? String {
                                        currentVehicle.category = cat
                                    }
                                }
                            }
                        })
                    }
                    
                    vehiclesArray.append(currentVehicle)
                    
                }
                successBlock(vehiclesArray)
            }
            
        }
        
    }
    
    class func getCategories(successBlock: @escaping (_ category: [VehicleCategory]) -> (), errorBlock: @escaping (_ error: String) -> ()) {
         let db = Firestore.firestore()
        var categoriesArray: [VehicleCategory] = []
        db.collection("categories").getDocuments() { (result, err) in
            if let err = err {
                errorBlock("An error \(err) has ocurred")
                return
            } else {
                for document in result!.documents {
                    let currentCategory = VehicleCategory()
                    let currentDocument = document.data()
                    if let name = currentDocument["name"] as? String {
                        currentCategory.name = name
                    }
                    categoriesArray.append(currentCategory)
                }
                successBlock(categoriesArray)
            }
        }
    }
}
