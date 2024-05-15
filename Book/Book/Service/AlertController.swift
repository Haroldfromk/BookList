//
//  AlertManager.swift
//  Book
//
//  Created by Dongik Song on 5/14/24.
//

import UIKit

class AlertController {
    
    func makeAlert (title: String, message: String, style: UIAlertController.Style = .alert, completionHandler: @escaping ((UIAlertAction) -> Void)) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        alert.addAction(UIAlertAction(title: "취소", style: .default))
        alert.addAction(UIAlertAction(title: "확인", style: .destructive, handler: completionHandler))
        
        return alert
    }
}
