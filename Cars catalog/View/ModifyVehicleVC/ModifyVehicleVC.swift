//
//  ModifyVehicleVC.swift
//  Cars catalog
//
//  Created by Fray Pineda on 8/29/20.
//  Copyright © 2020 New town. All rights reserved.
//

import UIKit

class ModifyVehicleVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    var currentVehicle: Vehicle?
    var currentCategory: VehicleCategory?
    var presenter: SavingPresenter?
    var dict: [String: Any] = [:]
    var categoryCell: AddInfoItemCell?
    var categoryPicker = UIPickerView()
    var allCategories: [VehicleCategory]?
    var pickerData: [String] = []
    var selectedCategory: String?
    
    var cells: [TableCellTypes] = [TableCellTypes.imageCell,
                                    TableCellTypes.addInfoItemCell(.numberOfSeats),
                                   TableCellTypes.addInfoItemCell(.price),
                                   TableCellTypes.addInfoItemCell(.newOld),
                                    TableCellTypes.addInfoItemCell(.model),
                                    TableCellTypes.addInfoItemCell(.date),
                                    TableCellTypes.addInfoItemCell(.category),
                                    TableCellTypes.buttonCell]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        setNavBar(icon: #imageLiteral(resourceName: "back_arrow"), buttonType: .left, target: self, action: #selector(backButtonTapped))
        presenter = SavingPresenter(view: self)
        setupTableView()
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }

    @objc func backButtonTapped() {
           navigationController?.popViewController(animated: true)
       }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        for cell in cells {
            tableView.registerCell(named: TableCells.getCollectionCellIdentifier(cell))
        }
    }

}

extension ModifyVehicleVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        let identifier = TableCells.getCollectionCellIdentifier(cells[index])
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        let cellType = cells[indexPath.row]
        
        if let currentCell = cell as? ButtonCell {
            currentCell.button.setTitle(Localizables.ModifyVehicleVC.buttonTitle, for: .normal)
            currentCell.button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
            cell = currentCell
        }
        switch cellType {
            case .imageCell:
                if let currentCell = cell as? ImageCell {
                       if let url = currentVehicle?.urlPhoto {
                           currentCell.loadImage(with: url)
                            cell = currentCell
                       }
                   }
                break
            case .addInfoItemCell(let style):
                if let currentCell = cell as? AddInfoItemCell, let vehicle = currentVehicle {
                    currentCell.setupUI(with: style, vehicle: vehicle)
                    cell = currentCell
                    if let c = cell as? AddInfoItemCell, style == .category {
                        categoryCell = c
                        setupPicker()
                    }
                }
            break
            
            default:
                break
        }
        return cell
    }
    
    func setupPicker() {
        if let categories = allCategories {
            for cat in categories {
                if let name = cat.name {
                    pickerData.append(name)
                }
            }
        }
        categoryPicker.delegate = self
        categoryPicker.dataSource = self
        categoryCell?.valueTextField.inputView = categoryPicker
        
    }

    @objc func saveButtonTapped() {
        if let c = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? AddInfoItemCell  {
            dict["numberOfSeats"] = Int(c.valueTextField.text ?? "0")
        }
        if let c = tableView.cellForRow(at: IndexPath(row: 2, section: 0)) as? AddInfoItemCell  {
            dict["price"] = Double(c.valueTextField.text ?? "0")
        }
        if let c = tableView.cellForRow(at: IndexPath(row: 3, section: 0)) as? AddInfoItemCell  {
            dict["newOld"] = c.valueTextField.text
        }
        if let c = tableView.cellForRow(at: IndexPath(row: 4, section: 0)) as? AddInfoItemCell  {
            dict["model"] = c.valueTextField.text
        }
        if let c = tableView.cellForRow(at: IndexPath(row: 5, section: 0)) as? AddInfoItemCell  {
            dict["date"] = Int(c.valueTextField.text ?? "0")
        }
        
            let categoryReference = allCategories?.first(where: { category in
                if let name = category.name, let selected = selectedCategory {
                    return name.uppercased() == selected.uppercased()
                } else {
                    return false
                }
            })
            if let foundCategory = categoryReference {
                dict["category"] = foundCategory.documentReference
            } else {
                if let cat = currentVehicle?.categoryReference {
                    dict["category"] = cat
                }
            }
        
        if let photo = currentVehicle?.photo {
            dict["photo"] = photo
        }
        
        if let categoryCell = categoryCell {
            if let category = categoryCell.valueTextField.text {
                if category.uppercased() == InitialCategories.COMMERCIAL.rawValue.uppercased() {
                    let vc = ViewsFactory.getViewControllerFromFactory(.vehicleExtraInfoVC) as! VehicleExtraInfoVC
                    vc.type = InitialCategories.COMMERCIAL
                    vc.dict = dict
                    vc.currentVehicle = self.currentVehicle
                    navigationController?.pushViewController(vc, animated: true)
                    return
                }
            }
        }
        if let categoryCell = categoryCell {
            if let category = categoryCell.valueTextField.text {
                if category.uppercased() == InitialCategories.TRUCK.rawValue.uppercased() {
                    let vc = ViewsFactory.getViewControllerFromFactory(.vehicleExtraInfoVC) as! VehicleExtraInfoVC
                    vc.type = InitialCategories.TRUCK
                    vc.dict = dict
                    vc.currentVehicle = self.currentVehicle
                    navigationController?.pushViewController(vc, animated: true)
                    return
                }
            }
        }
        if let categoryCell = categoryCell {
                   if let category = categoryCell.valueTextField.text {
                       if category.uppercased() == InitialCategories.ELECTRICAL.rawValue.uppercased() {
                           let vc = ViewsFactory.getViewControllerFromFactory(.vehicleExtraInfoVC) as! VehicleExtraInfoVC
                           vc.type = InitialCategories.ELECTRICAL
                           vc.dict = dict
                           vc.currentVehicle = self.currentVehicle
                           navigationController?.pushViewController(vc, animated: true)
                           return
                       }
                   }
               }
        activityIndicator.startAnimating()
        presenter?.updateVehicle(path: currentVehicle?.documentPath ?? "", dict: dict)
      }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TableCells.getHeightForCell(cells[indexPath.row])
    }
    
}

extension ModifyVehicleVC: ModifyView {
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

extension ModifyVehicleVC: UIPickerViewDelegate, UIPickerViewDataSource {
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
        let currentCategory = pickerData[row]
        categoryCell?.valueTextField.text = currentCategory
        selectedCategory = currentCategory
        categoryCell?.valueTextField.resignFirstResponder()
    }
    
    
}
