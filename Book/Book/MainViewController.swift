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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        layout()
        tableSetUp()
        collectionSetUp()
        
        bind()
        checkEmpty()

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        bind()
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
        searchVM.$document
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.resultView.tableView.reloadData()
            }
            .store(in: &cancellables)
        searchVM.numberSubject.send(1)
        
        recentVM.getDocumentfromCoreData()
        recentVM.$recentDocument
            .receive(on: DispatchQueue.main)
            .sink { [weak self] data in
                self?.recentView.collectionView.reloadData()
            }.store(in: &cancellables)
        recentVM.routerSubject
            .receive(on: DispatchQueue.main)
            .sink { router in
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
