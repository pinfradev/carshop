//
//  NewCategoryVC.swift
//  Cars catalog
//
//  Created by Fray Pineda on 8/29/20.
//  Copyright © 2020 New town. All rights reserved.
//

import UIKit

class NewCategoryVC: UIViewController {

    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var mainTitleLabel: UILabel!
    @IBOutlet weak var descriptionTitle: UILabel!
    @IBOutlet weak var mainTextField: UITextField!
    @IBOutlet weak var mainButton: UIButton!
    var presenter: SavingPresenter?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar(icon: #imageLiteral(resourceName: "back_arrow"), buttonType: .left, target: self, action: #selector(backButtonTapped))
        presenter = SavingPresenter(view: self)
        setupUI()
    }
    
    func setupUI() {
        let texts = Localizables.NewCategoryVC.self
        mainTitleLabel.text = texts.mainTitleLabelText
        descriptionTitle.text = texts.descriptionLabelText
        mainButton.setTitle(texts.mainButtonTitle, for: .normal)
        mainButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    @objc func saveButtonTapped() {
        if let name = mainTextField.text {
            if !name.isEmpty {
                let dict : [String: Any] = ["name": name]
                activityIndicator.startAnimating()
                presenter?.saveNewCategory(dict: dict)
            } else {
                showAlert(title: "", message: "The category field is empty")
            }
        } else {
            showAlert(title: "", message: "The category field is empty")
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    @objc func backButtonTapped() {
           navigationController?.popViewController(animated: true)
       }
    
    
}

extension NewCategoryVC: CategoryView {
    func saveCategorySucceded(message: String) {
        activityIndicator.stopAnimating()
        let vc = ViewsFactory.getViewControllerFromFactory(.resultForTransactionVC)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func saveCategoryFailed(error: String) {
        activityIndicator.stopAnimating()
        showAlert(title: "", message: error)
    }
    
    
}
