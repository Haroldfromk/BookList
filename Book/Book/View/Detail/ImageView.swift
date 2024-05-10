//
//  ImageView.swift
//  Book
//
//  Created by Dongik Song on 5/6/24.
//

import UIKit
import SnapKit

class ImageView: UIView {
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "book")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let priceLabel = TextLabel().makeCenterLabel(value: "가격")
    
    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            imageView,
            priceLabel
        ])
        stackView.axis = .vertical
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
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(vStackView.snp.top).offset(10)
            make.leading.equalTo(vStackView.snp.leading).offset(10)
            make.trailing.equalTo(vStackView.snp.trailing).offset(-10)
            make.height.equalToSuperview().multipliedBy(0.7)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.leading.equalTo(vStackView.snp.leading).offset(10)
            make.trailing.equalTo(vStackView.snp.trailing).offset(-10)
            make.height.equalToSuperview().multipliedBy(0.3)
        }
    }
    
}
