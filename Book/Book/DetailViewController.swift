//
//  DetailViewController.swift
//  Book
//
//  Created by Dongik Song on 5/6/24.
//

import UIKit
import SnapKit

class DetailViewController: UIViewController {

    var titleView = TitleView()
    var imageView = ImageView()
    var bodyView = BodyView()
    var buttonView = ButtonView()
    
    private lazy var vStackView: UIStackView = {
        var stackView = UIStackView(arrangedSubviews: [
        titleView,
        imageView,
        bodyView,
        buttonView,
        UIView()
        ])
        stackView.axis = .vertical
        stackView.spacing = 20
        
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        layout()
    }
    
    private func layout() {
        view.addSubview(vStackView)
        
        vStackView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        titleView.snp.makeConstraints { make in
            make.height.equalTo(90)
        }
        
        imageView.snp.makeConstraints { make in
            make.height.equalTo(350)
        }
        
        bodyView.snp.makeConstraints { make in
            make.height.equalTo(180)
        }
        
        buttonView.snp.makeConstraints { make in
            make.height.equalTo(90)
        }
    }
    
}
