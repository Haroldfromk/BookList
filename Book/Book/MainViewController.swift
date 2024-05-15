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
    
    let searchVM = SearchVM()
    let recentVM = RecentVM()
    let wishVM = WishVM()
    
    var recentTableDatasource: UITableViewDiffableDataSource<DiffableSectionModel, Document>?
    var collectionDatasource: UICollectionViewDiffableDataSource<DiffableSectionModel, RecentModel>?
    var tableSnapshot: NSDiffableDataSourceSnapshot<DiffableSectionModel, Document>?
    var collectionSnapshot: NSDiffableDataSourceSnapshot<DiffableSectionModel, RecentModel>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        layout()
        // tableSetUp()
        
        bind()
        configureDiffableDataSource()
        checkEmpty()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        recentVM.getDocument()
        recentVM.$recentDocument
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.collectionConfigureSnapshot()
            }.store(in: &cancellables)
        checkEmpty()
    }
    
    private func checkEmpty() {
        if recentVM.recentDocument.isEmpty {
            recentView.collectionView.isHidden = true
        } else {
            recentView.collectionView.isHidden = false
        }
    }
    
    private func bind () {
        
        searchVM.transform(input: SearchVM.Input(searchPublisher: searchView.valuePublisher, numberPublisher: searchVM.valuePublisher))
        searchVM.numberSubject.send(1)
        searchVM.$document
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.configureSnapshot()
            }
            .store(in: &cancellables)
        
        recentVM.getDocument()
        recentVM.$recentDocument
            .receive(on: DispatchQueue.main)
            .sink { [weak self] data in
                self?.collectionConfigureSnapshot()
            }.store(in: &cancellables)
        
        
        recentVM.routerSubject.sink { router in
            switch router {
            case .alert(let title, let message):
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .default))
                self.present(alert, animated: true)
            }
        }.store(in: &cancellables)
        
    }
    
    private func layout() {
        view.addSubview(vStackView)
        
        vStackView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(80)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        searchView.snp.makeConstraints { make in
            make.height.equalTo(65)
        }
        
        recentView.snp.makeConstraints { make in
            make.height.equalTo(240)
        }
        
        resultView.snp.makeConstraints { make in
            make.height.equalTo(356)
        }
    }
    
}
