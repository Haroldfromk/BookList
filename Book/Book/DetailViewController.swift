//
//  DetailViewController.swift
//  Book
//
//  Created by Dongik Song on 5/6/24.
//

import UIKit
import SnapKit
import Combine

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
    
    private var cancellables = Set<AnyCancellable>()
    var wishSubject = CurrentValueSubject<Document, Never>(.init(authors: [], contents: "", price: 0, title: "", thumbnail: ""))

    let wishVM = WishVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        layout()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
    }
    
    private func layout() {
        view.addSubview(vStackView)
        
        vStackView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(80)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        titleView.snp.makeConstraints { make in
            make.height.equalTo(90)
        }
        
        imageView.snp.makeConstraints { make in
            make.height.equalTo(300)
        }
        
        bodyView.snp.makeConstraints { make in
            make.height.equalTo(180)
        }
        
        buttonView.snp.makeConstraints { make in
            make.height.equalTo(90)
        }
    }
    
}
