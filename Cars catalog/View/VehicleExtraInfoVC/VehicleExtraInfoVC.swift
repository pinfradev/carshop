//
//  VehicleExtraInfoVC.swift
//  Cars catalog
//
//  Created by Fray Pineda on 8/31/20.
//  Copyright © 2020 New town. All rights reserved.
//

import UIKit

class VehicleExtraInfoVC: UIViewController {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var valueTextField: UITextField!
    @IBOutlet weak var mainButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var presenter: SavingPresenter?
    var currentVehicle: Vehicle?
    var type: InitialCategories?
    var dict: [String: Any]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter = SavingPresenter(view: self)
        setNavBar(icon: #imageLiteral(resourceName: "back_arrow"), buttonType: .left, target: self, action: #selector(backButtonTapped))
        mainButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    @objc func backButtonTapped() {
           navigationController?.popViewController(animated: true)
       }
    
    func setupUI() {
        mainButton.setTitle(Localizables.VehicleExtraInfoVC.mainButtonTitle, for: .normal)
        if let type = type {
            switch type {
                case .COMMERCIAL:
                    descriptionLabel.text = Localizables.ModifyVehicleVC.spaceLabel
                    break
                case .TRUCK:
                    descriptionLabel.text = Localizables.ModifyVehicleVC.payloadLabel
                    break
                case .ELECTRICAL:
                    descriptionLabel.text = Localizables.ModifyVehicleVC.bateryLabel
                    break
                default:
                    break
            }
        }
    }

    @objc func saveButtonTapped() {
        if var dict = dict {
            if let text = valueTextField.text, let currentVehicle = currentVehicle {
                if !text.isEmpty {
                    if type == .COMMERCIAL {
                        dict["space"] = text
                    }
                    if type == .TRUCK {
                        dict["payload"] = text
                    }
                    if type == .ELECTRICAL {
                        dict["batery"] = text
                    }
                    activityIndicator.startAnimating()
                    presenter?.updateVehicle(path: currentVehicle.documentPath ?? "", dict: dict)
                } else {
                    showAlert(title: "", message: "the \(descriptionLabel.text ?? "") field is empty")
                }
            }
        }
    }
}

extension VehicleExtraInfoVC: ModifyView {
    func modifyVehicleSucceded(message: String) {
        activityIndicator.stopAnimating()
        let vc = ViewsFactory.getViewControllerFromFactory(.resultForTransactionVC)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func modifyVehicleFailed(error: String) {
        activityIndicator.stopAnimating()
        showAlert(title: "", message: error)
    }
    
    
}
