//
//  ViewController.swift
//  Book
//
//  Created by Dongik Song on 5/4/24.
//

import UIKit
import Combine
import SnapKit

class ViewController: UIViewController {
    
    let searchView = SearchView()
    let recentView = RecentView()
    let resultView = ResultView()
    
    
    private lazy var vStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            searchView,
            recentView,
            resultView,
            UIView()
        ])
        
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    private var cancellables = Set<AnyCancellable>()
    private let bookVM = BookVM()
    
    var tableViewList = [Document]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        layout()
        setUp()
        bookVM.transform(input: BookVM.Input(searchPublisher: searchView.valuePublisher))
        bookVM.$document
            .receive(on: RunLoop.main)
            .sink { [weak self] document in
                self?.tableViewList = document
                self?.resultView.tableView.reloadData()
            }.store(in: &cancellables)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        resultView.tableView.reloadData()
    }
    
    private func layout() {
        view.addSubview(vStackView)
        
        vStackView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(100)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        searchView.snp.makeConstraints { make in
            make.height.equalTo(65)
        }
        
        recentView.snp.makeConstraints { make in
            make.height.equalTo(180)
        }
        
        resultView.snp.makeConstraints { make in
            make.height.equalTo(356)
        }
    }
    
}

