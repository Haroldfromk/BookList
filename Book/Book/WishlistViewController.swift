//
//  WishlistViewController.swift
//  Book
//
//  Created by Dongik Song on 5/6/24.
//

import UIKit
import SnapKit
import Combine

class WishlistViewController: UIViewController {
    
    
    private let headerView = HeaderView()
    let bodyTableView = BodyTableView()
    
    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            headerView,
            bodyTableView,
            UIView()
        ])
        stackView.axis = .vertical
        stackView.spacing = 20
        return stackView
    }()
    
    private var cancellables = Set<AnyCancellable>()
    let wishVM = WishVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setUp()
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bind()
    }
    
    private func bind () {
        wishVM.getWholeDocument()
        wishVM.$wishDocument
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] _ in
                self.bodyTableView.tableView.reloadData()
            }.store(in: &cancellables)
        
        CoredataManager.shared.routerSubject
            .receive(on: DispatchQueue.main)
            .sink { alert in
            switch alert {
            case .alert(let title, let message):
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .default))
                self.present(alert, animated: true)
            }
        }.store(in: &cancellables)
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
