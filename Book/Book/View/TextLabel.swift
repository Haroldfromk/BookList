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
        return label
    }
    
    func makeLabel(value: String) -> UILabel {
        let label = UILabel()
        let text = value
        label.text = text
        return label
    }
}
