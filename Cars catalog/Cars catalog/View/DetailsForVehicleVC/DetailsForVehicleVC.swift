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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        setNavBar(icon: #imageLiteral(resourceName: "back_arrow"), buttonType: .left, target: self, action: #selector(backButtonTapped))
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

extension DetailsForVehicleVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        let identifier = TableCells.getCollectionCellIdentifier(cells[index])
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        if let currentCell = cell as? ButtonCell {
            currentCell.button.addTarget(self, action: #selector(modifyButtonTapped), for: .touchUpInside)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TableCells.getHeightForCell(cells[indexPath.row])
    }

    @objc func modifyButtonTapped() {
        let vc = ViewsFactory.getViewControllerFromFactory(.modifyVehicleVC)
        navigationController?.pushViewController(vc, animated: true)
    }
}
