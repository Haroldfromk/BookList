//
//  WishlistViewController.swift
//  Book
//
//  Created by Dongik Song on 5/6/24.
//

import UIKit
import SnapKit

class WishlistViewController: UIViewController {
    
    private let headerView = HeaderView()
    let bodyTableView = BodyTableView()
    
    private lazy var vStackView: UIStackView = {
        var stackView = UIStackView(arrangedSubviews: [
            headerView,
            bodyTableView,
            UIView()
        ])
        stackView.axis = .vertical
        stackView.spacing = 20
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setUp()
        layout()
    }
    
    private func layout () {
        view.addSubview(vStackView)
        
        vStackView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(100)
            make.bottom.trailing.leading.equalToSuperview()
        }
        
        headerView.snp.makeConstraints { make in
            make.height.equalTo(100)
        }
        
        bodyTableView.snp.makeConstraints { make in
            make.height.equalTo(500)
        }
    }
    
    
}
