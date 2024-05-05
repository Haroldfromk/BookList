//
//  TextLabel.swift
//  Book
//
//  Created by Dongik Song on 5/4/24.
//

import UIKit

class TextLabel: UILabel {
    
    func makeLabel (textValue: String) -> UILabel {
        let label = UILabel()
        let text = NSMutableAttributedString(string: textValue, attributes: [.font: UIFont.systemFont(ofSize: 24)])
        label.attributedText = text
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    func makeLabel (value: String) -> UILabel {
        let label = UILabel()
        let text = value
        label.text = text
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font.withSize(8)
        label.numberOfLines = 0
        return label
    }
    
    
    func makeCenterLabel (value: String) -> UILabel {
        let label = UILabel()
        let text = value
        label.text = text
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font.withSize(8)
        label.numberOfLines = 0
        return label
    }
}
