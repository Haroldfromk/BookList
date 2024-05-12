//
//  UIResponder+Extension.swift
//  Book
//
//  Created by Dongik Song on 5/5/24.
//

import UIKit

extension UIResponder {
    var childViewController: UIViewController? {
        return next as? UIViewController ?? next?.childViewController
    }
}

