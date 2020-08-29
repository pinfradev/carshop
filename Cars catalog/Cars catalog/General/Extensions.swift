//
//  Extensions.swift
//  Cars catalog
//
//  Created by Fray Pineda on 8/29/20.
//  Copyright © 2020 New town. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
}

extension UICollectionView {
    func registerCell(named: String) {
        let identifier = named
        let nib =  UINib(nibName: identifier, bundle: nil)
        self.register(nib, forCellWithReuseIdentifier: identifier)
    }
}

extension UITableView {
    func registerCell(named: String) {
        let identifier = named
        let nib = UINib(nibName: identifier, bundle: nil)
        register(nib, forCellReuseIdentifier: identifier)
    }
}

enum ButtonDirection {
    case right
    case left
}
extension UIViewController {
    func setNavBar(icon: UIImage?, buttonType: ButtonDirection,target: Any?,
                   action: Selector?, Color: UIColor = .white,
                   and title: String = "") {
        let button = UIBarButtonItem(image: icon, style: .plain, target: target, action: action)
        switch buttonType {
         case .left:
            navigationItem.leftBarButtonItem = button
            navigationItem.leftBarButtonItem?.tintColor = Color
            navigationItem.leftBarButtonItem?.title = title
        default:
            navigationItem.rightBarButtonItem = button
            navigationItem.rightBarButtonItem?.tintColor = Color
            navigationItem.rightBarButtonItem?.title = title
        }
    }
}
