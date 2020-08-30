//
//  MainVC.swift
//  Cars catalog
//
//  Created by Fray Pineda on 8/29/20.
//  Copyright © 2020 New town. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    @IBOutlet weak var currentCategory: UILabel!
    @IBOutlet weak var NewCategoryButton: UIButton!
    @IBOutlet weak var categoriesTF: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    var vehicles: [Vehicle]?
    var presenter: MainPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        presenter = MainPresenter(view: self)
        presenter?.getVehicles()
        setupCollectionView()
    }
    
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCell(named: CollectionCells.getCollectionCellIdentifier(.catalogItemCell))
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        collectionView.reloadData()
    }

}

extension MainVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vehicles?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCells.getCollectionCellIdentifier(.catalogItemCell), for: indexPath) as! CatalogItemCell
        if let car = vehicles?[indexPath.row] {
            cell.setupUI(vehicle: car)
        }
         return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ViewsFactory.getViewControllerFromFactory(.detailsForVehicleVC)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CollectionCells.getSizeForCell(.catalogItemCell)
    }
    
    
}

extension MainVC: MainVCDelegate {
    func getVehiclesSucceded(vehicles: [Vehicle]) {
        self.vehicles = vehicles
        self.collectionView.reloadData()
    }
    
    func getVehiclesFailed(error: String) {
        let alert = UIAlertController(title: "", message: error, preferredStyle: .alert)
        navigationController?.present(alert, animated: true, completion: nil)
    }
    
    
}

