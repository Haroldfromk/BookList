//
//  ViewController.swift
//  Book
//
//  Created by Dongik Song on 5/4/24.
//

import UIKit
import Combine
import SnapKit

class MainViewController: UIViewController {
    
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
    
    var cancellables = Set<AnyCancellable>()
    
    var test = [RecentModel]()
    
    let searchVM = SearchVM()
    let wishVM = WishVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        layout()
        setUp()
        
        bind()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(true)
//        bind()
//    }
    
    private func bind () {
        searchVM.transform(input: SearchVM.Input(searchPublisher: searchView.valuePublisher))
        searchVM.$document
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.resultView.tableView.reloadData()
            }.store(in: &cancellables)
        
        wishVM.getDocumentfromCoreData()
        wishVM.$wishDocument
            .receive(on: DispatchQueue.main)
            .sink { [weak self] data in
                self?.recentView.collectionView.reloadData()
            }.store(in: &cancellables)
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
