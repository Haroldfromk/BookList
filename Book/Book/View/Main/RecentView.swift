//
//  RecentView.swift
//  Book
//
//  Created by Dongik Song on 5/4/24.
//

import UIKit
import Combine
import CombineCocoa
import SnapKit

class RecentView: UIView {

    
    private let textLabel = TextLabel().makeLabel(textValue: "최근 본 책")
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        var view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .blue
        view.register(RecentCollectionViewCell.self, forCellWithReuseIdentifier: Constants.collectionViewCellIdentifier)
        return view
    }()
    
    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
        textLabel,
        collectionView,
        UIView()
        ])
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .center
        return stackView
    }()
    
    init () {
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    private func layout() {
        addSubview(vStackView)
        
        vStackView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        textLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(vStackView.snp.leading).offset(20)
            make.trailing.equalTo(vStackView.snp.trailing).offset(-20)

        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(textLabel.snp.bottom).offset(5)
            make.leading.equalTo(vStackView.snp.leading).offset(20)
            make.trailing.equalTo(vStackView.snp.trailing).offset(-20)
            make.bottom.equalTo(vStackView.snp.bottom).offset(-15)
        }
    }
    
    
}
