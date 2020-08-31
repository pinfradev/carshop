//
//  Vehicle.swift
//  Cars catalog
//
//  Created by Fray Pineda on 8/29/20.
//  Copyright © 2020 New town. All rights reserved.
//

import Foundation
import Firebase

class Vehicle {
    var categoryReference: DocumentReference?
    var documentPath: String?
    var numberOfSeats: Int?
    var price: Double?
    var newOld: String?
    var model: String?
    var date: Int?
    var category: String?
    var photo: String?
    var batery: String?
    var payload: Double?
    var space: String?
    
    var urlPhoto: URL? {
        if let picture = photo {
            let url = URL(string: picture)
            return url
        } else {
            return nil
        }
    }
}
