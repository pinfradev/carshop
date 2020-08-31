//
//  MainVC.swift
//  Cars catalog
//
//  Created by Fray Pineda on 8/29/20.
//  Copyright © 2020 New town. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    @IBOutlet weak var currentCategoryLabel: UILabel!
    @IBOutlet weak var newCategoryButton: UIButton!
    @IBOutlet weak var categoriesTF: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var selectableTF: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var vehicles: [Vehicle]?
    var filteredVehicles: [Vehicle]?
    var categories: [VehicleCategory]?
    var categoriesPicker = UIPickerView()
    var pickerData: [String] = [InitialCategories.All.rawValue]
    var presenter: MainPresenter?
    var selectedCategory: String?
    var currentCategory: VehicleCategory?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        setupUI()
        presenter = MainPresenter(view: self)
        setupCollectionView()
    }
    
    func setupUI() {
        let strings = Localizables.MainVC.self
        newCategoryButton.setTitle(strings.buttonTitle, for: .normal)
    }
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCell(named: CollectionCells.getCollectionCellIdentifier(.catalogItemCell))
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        currentCategoryLabel.text = ""
        categoriesTF.text = ""
        activityIndicator.startAnimating()
        presenter?.getVehicles()
    }

}

extension MainVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredVehicles?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCells.getCollectionCellIdentifier(.catalogItemCell), for: indexPath) as! CatalogItemCell
        if let car = filteredVehicles?[indexPath.row] {
            cell.setupUI(vehicle: car)
        }
         return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ViewsFactory.getViewControllerFromFactory(.detailsForVehicleVC) as! DetailsForVehicleVC
        vc.currentVehicle = filteredVehicles?[indexPath.row]
        if let cats = categories {
            currentCategory = cats.first(where: { cat in
                return selectedCategory?.uppercased() == cat.name?.uppercased()
            })
            vc.currentCategory = currentCategory
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CollectionCells.getSizeForCell(.catalogItemCell)
    }
    
    
}

extension MainVC: MainVCDelegate {
    func getCategoriesSucceded(categories: [VehicleCategory]) {
        self.categories = categories
        setupPicker()
    }
    
    func getCategoriesFailed(error: String) {
        activityIndicator.stopAnimating()
        showAlert(title: "", message: error)
    }
    
    func getVehiclesSucceded(vehicles: [Vehicle]) {
        self.vehicles = vehicles
        self.filteredVehicles = vehicles
        presenter?.getCategories()
        activityIndicator.stopAnimating()
        self.collectionView.reloadData()
    }
    
    func getVehiclesFailed(error: String) {
        activityIndicator.stopAnimating()
        showAlert(title: "", message: error)
    }
    
    func setupPicker() {
        pickerData = [InitialCategories.All.rawValue]
        if let array = categories {
            for cat in array {
                if let name = cat.name {
                    pickerData.append(name)
                }
            }
        }
        
        categoriesPicker.delegate = self
        categoriesPicker.dataSource = self
        selectableTF.inputView = categoriesPicker
    }

}

extension MainVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        categoriesTF.text = pickerData[row]
        selectableTF.resignFirstResponder()
        selectedCategory = pickerData[row]
        if let currentCat = selectedCategory {
            currentCategoryLabel.text = selectedCategory
            filteredVehicles = vehicles?.filter { vehicle in
                if let cat = vehicle.category {
                    return currentCat.uppercased() == cat.uppercased()
                } else {
                    return false
                }
            }
        }
        if selectedCategory == InitialCategories.All.rawValue {
            currentCategoryLabel.text = ""
            filteredVehicles = vehicles
        }
        collectionView.reloadData()
    }
}

