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
        button.setTitle("닫기", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .gray
        button.tapPublisher.sink { [unowned self] _ in
            goToMainVC()
        }.store(in: &cancellables)
        return button
    }()
    
    private lazy var getButton: UIButton = {
        let button = UIButton ()
        button.setTitle("담기", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .green
        button.tapPublisher.sink { [unowned self] _ in
            let vc = childViewController as? DetailViewController
            vc?.wishSubject.sink(receiveValue: { [unowned self] document in
                if vc?.wishVM.checkDuplicate(title: document.title) == false {
                    vc?.wishVM.saveDatatoWish(data: document)
                    let alert = UIAlertController(title: "담기 완료", message: "책이 담겼습니다.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { [unowned self] _ in
                        goToMainVC()
                    }))
                    vc?.present(alert, animated: true)
                } else {
                    let alert = UIAlertController(title: "중복 확인", message: "이미 리스트에 등록된 책입니다.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "확인", style: .default))
                    vc?.present(alert, animated: true)
                }
                
            }).cancel()
        }.store(in: &cancellables)
        return button
    }()
    
    private lazy var hStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            closeButton,
            getButton
        ])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
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
        
    }
    
}
