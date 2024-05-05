//
//  TitleView.swift
//  Book
//
//  Created by Dongik Song on 5/6/24.
//

import UIKit
import SnapKit

class TitleView: UIView {
    
    var titleLabel = TextLabel().makeLabel(textValue: "세이노의 가르침")
    var authorLabel = TextLabel().makeCenterLabel(value: "세이노")
    
    private lazy var vStackView: UIStackView = {
        var stackView = UIStackView(arrangedSubviews: [
        titleLabel,
        authorLabel
        ])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 10
        return stackView
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout () {
        addSubview(vStackView)
        
        vStackView.snp.makeConstraints { make in
            make.leading.trailing.bottom.top.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(vStackView.snp.top).offset(5)
            make.leading.equalTo(vStackView.snp.leading).offset(15)
            make.trailing.equalTo(vStackView.snp.trailing).offset(-15)
        }
        
        authorLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.bottom.equalTo(vStackView.snp.bottom).offset(-10)
            make.leading.equalTo(vStackView.snp.leading).offset(15)
            make.trailing.equalTo(vStackView.snp.trailing).offset(-15)
        }
    }
}
