//
//  NewCategoryVC.swift
//  Cars catalog
//
//  Created by Fray Pineda on 8/29/20.
//  Copyright © 2020 New town. All rights reserved.
//

import UIKit

class NewCategoryVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar(icon: #imageLiteral(resourceName: "back_arrow"), buttonType: .left, target: self, action: #selector(backButtonTapped))
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    @objc func backButtonTapped() {
           navigationController?.popViewController(animated: true)
       }
}
