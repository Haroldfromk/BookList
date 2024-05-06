//
//  HeaderView.swift
//  Book
//
//  Created by Dongik Song on 5/6/24.
//

import UIKit
import SnapKit

class HeaderView: UIView {
    
    private let title = TextLabel().makeLabel(textValue: "담은 책")
    
    private let deleteAllButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.text = "전체 삭제"
        button.backgroundColor = .white
        return button
    }()
    
    private let addButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.text = "추가"
        button.backgroundColor = .white
        return button
    }()
    
    private lazy var hStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
        deleteAllButton,
        title,
        addButton
        ])
        
        stackView.axis = .horizontal
        stackView.alignment = .center
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout () {
        self.addSubview(hStackView)
        
        hStackView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        deleteAllButton.snp.makeConstraints { make in
       
        }
        
        title.snp.makeConstraints { make in
            
        }
        
        addButton.snp.makeConstraints { make in
            
        }
    }
    
}
