//
//  StoreService.swift
//  Cars catalog
//
//  Created by Fray Pineda on 8/30/20.
//  Copyright © 2020 New town. All rights reserved.
//

import Foundation
import Firebase

class StoreService {
    
    class func updateDocument(path: String, dict: [String: Any], successBlock: @escaping (_ message: String) -> (), errorBlock: @escaping (_ error: String) -> ()) {
         let db = Firestore.firestore()
        db.document(path).setData(dict, completion: { error in
            if let err = error {
                errorBlock(err.localizedDescription)
            } else {
                successBlock("Successfully updated")
            }
        })
    }
    
    class func saveNewCategory(dict: [String: Any], successBlock: @escaping (_ message: String) -> (), errorBlock: @escaping (_ error: String) -> ()) {
        let db = Firestore.firestore()
        db.collection("categories").addDocument(data: dict, completion: { error in
            if let err = error {
                errorBlock(err.localizedDescription)
            } else {
                successBlock("Successfully updated")
            }
        })
    }
}
