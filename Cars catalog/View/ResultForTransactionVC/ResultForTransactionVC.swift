//
//  ResultForTransactionVC.swift
//  Cars catalog
//
//  Created by Fray Pineda on 8/29/20.
//  Copyright © 2020 New town. All rights reserved.
//

import UIKit

class ResultForTransactionVC: UIViewController {

    @IBOutlet weak var button: UIButton!
     override func viewDidLoad() {
           super.viewDidLoad()
           self.button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
       }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
       
       @objc func buttonTapped() {
            if let viewcontrollers = navigationController?.viewControllers {
                for vc in viewcontrollers {
                    if vc.isKind(of: MainVC.self) {
                        navigationController?.popToViewController(vc, animated: true)
                        return
                     }
                }
            }
            
            let vc = ViewsFactory.getViewControllerFromFactory(.mainVC)
            navigationController?.pushViewController(vc, animated: true)
        }

}
