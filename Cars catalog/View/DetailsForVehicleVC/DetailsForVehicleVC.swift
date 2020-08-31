//
//  DetailsForVehicleVC.swift
//  Cars catalog
//
//  Created by Fray Pineda on 8/29/20.
//  Copyright © 2020 New town. All rights reserved.
//

import UIKit

class DetailsForVehicleVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var cells: [TableCellTypes] = [TableCellTypes.imageCell,
                                   TableCellTypes.buttonCell,
                                    TableCellTypes.showDoubleLineItemCell(.numberOfSeats),
                                   TableCellTypes.showDoubleLineItemCell(.price),
                                   TableCellTypes.showDoubleLineItemCell(.newOld),
                                    TableCellTypes.showDoubleLineItemCell(.model),
                                    TableCellTypes.showDoubleLineItemCell(.date),
                                    TableCellTypes.showDoubleLineItemCell(.category)]
    
    var currentVehicle: Vehicle?
    var currentCategory: VehicleCategory?
    var allCategories: [VehicleCategory]?
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        setNavBar(icon: #imageLiteral(resourceName: "back_arrow"), buttonType: .left, target: self, action: #selector(backButtonTapped))
        setupCells()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    func setupCells() {
        if let category = currentVehicle?.category {
            let cat1 = InitialCategories.ELECTRICAL.rawValue
            let cat2 = InitialCategories.COMMERCIAL.rawValue
            let cat3 = InitialCategories.TRUCK.rawValue
            switch category.uppercased() {
                case cat1:
                    cells.append(.showDoubleLineItemCell(.batteryCapacity))
                    cells.remove(at: 1)
                    break
                case cat2:
                    cells.append(.showDoubleLineItemCell(.space))
                    break
                case cat3:
                    cells.append(.showDoubleLineItemCell(.payload))
                    break
                default:
                    break
            }
        }
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

extension DetailsForVehicleVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        let identifier = TableCells.getCollectionCellIdentifier(cells[index])
        let cellType = cells[indexPath.row]
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        if let currentCell = cell as? ButtonCell {
            currentCell.button.setTitle(Localizables.DetailsForVehicleVC.buttonTitle, for: .normal)
            currentCell.button.addTarget(self, action: #selector(modifyButtonTapped), for: .touchUpInside)
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
            case .showDoubleLineItemCell(let style):
                if let currentCell = cell as? ShowDoubleLineItemCell, let vehicle = currentVehicle {
                    currentCell.setupUI(with: style, vehicle: vehicle)
                    cell = currentCell
                }
            break
            
            default:
                break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TableCells.getHeightForCell(cells[indexPath.row])
    }

    @objc func modifyButtonTapped() {
        let vc = ViewsFactory.getViewControllerFromFactory(.modifyVehicleVC) as! ModifyVehicleVC
        if let cat = currentCategory {
            vc.currentCategory = cat
        }
        vc.currentVehicle = currentVehicle
        vc.allCategories = self.allCategories
        navigationController?.pushViewController(vc, animated: true)
    }
}
