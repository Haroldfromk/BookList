//
//  ButtonView.swift
//  Book
//
//  Created by Dongik Song on 5/6/24.
//

import UIKit
import Combine
import SnapKit

class ButtonView: UIView {
    
    private var cancellables = Set<AnyCancellable>()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton ()
        button.backgroundColor = .gray
        button.setImage(UIImage(systemName: "x.circle"), for: .normal)
        button.tapPublisher.sink { [unowned self] _ in
            goToMainVC()
        }.store(in: &cancellables)
        return button
    }()
    
    private lazy var getButton: UIButton = {
        let button = UIButton ()
        button.backgroundColor = .green
        button.setImage(UIImage(systemName: "bookmark.square"), for: .normal)
        button.tapPublisher.sink { _ in
            
        }.store(in: &cancellables)
        return button
    }()
    
    private lazy var hStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
        closeButton,
        getButton,
        UIView()
        ])
        stackView.axis = .horizontal
        stackView.spacing = 25
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func goToMainVC() {
        childViewController?.dismiss(animated: true)
    }
    
    func layout () {
        addSubview(hStackView)
        
        hStackView.snp.makeConstraints { make in
            make.leading.trailing.bottom.top.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(hStackView.snp.top).offset(10)
            make.leading.equalTo(hStackView.snp.leading).offset(10)
            make.bottom.equalTo(hStackView.snp.bottom).offset(-10)
            make.width.equalTo(90)
        }
        
        getButton.snp.makeConstraints { make in
            make.top.equalTo(hStackView.snp.top).offset(10)
            make.leading.equalTo(closeButton.snp.trailing).offset(25)
            make.trailing.equalTo(hStackView.snp.trailing).offset(-10)
            make.bottom.equalTo(hStackView.snp.bottom).offset(-10)
            make.width.equalTo(250)
        }
        
    }
    
}
