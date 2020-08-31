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
    var numberOfSeatsCell: AddInfoItemCell?
    var priceCell: AddInfoItemCell?
    var newOldCell: AddInfoItemCell?
    var modelCell: AddInfoItemCell?
    var dateCell: AddInfoItemCell?
    var categoryCell: AddInfoItemCell?
    
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
                }
            break
            
            default:
                break
        }
        return cell
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
        if let cat = currentVehicle?.categoryReference {
            dict["category"] = cat
        }
        
        if let photo = currentVehicle?.photo {
            dict["photo"] = photo
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

