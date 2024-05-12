//
//  ResultView.swift
//  Book
//
//  Created by Dongik Song on 5/4/24.
//

import UIKit
import SnapKit
import Combine

class ResultView: UIView {
    
    
    private let textLabel = TextLabel().makeLabel(textValue: "검색 결과")
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.register(ResultTableViewCell.self, forCellReuseIdentifier: Constants.tableViewCellIdentifier)
        tableView.rowHeight = 80
        tableView.didSelectRowPublisher
            .sink { [weak self] indexPath in
                if let mainVC = self?.childViewController as? MainViewController {
                    let detailVC = DetailViewController()
                    
                    // DetailVC에 전달
                    mainVC.searchVM.$document
                        .map{ document in
                            return document[indexPath.row]
                        }
                        .eraseToAnyPublisher()
                        .receive(on: DispatchQueue.main)
                        .sink { [weak detailVC] document in
                            let imageURL = URL(string: document.thumbnail)
                            detailVC?.titleView.titleLabel.text = document.title
                            detailVC?.titleView.authorLabel.text = document.authors.joined()
                            detailVC?.imageView.imageView.kf.setImage(with: imageURL)
                            detailVC?.imageView.priceLabel.text = document.price.stringValue
                            detailVC?.bodyView.bodyLabel.text = document.contents
                            detailVC?.wishSubject.send(document)
                        }.store(in: &detailVC.cancellables)
                    
                    // CoreData에 등록
                    mainVC.searchVM.$document
                        .map{  document in
                            if !document.isEmpty {
                                return document[indexPath.row]
                            } else {
                                return document[0]
                            }
                        }
                        .eraseToAnyPublisher()
                        .sink(receiveValue: { [unowned self] document in
                            mainVC.recentVM.saveDataToRecent(data: document)
                        }).cancel()
                    
                    detailVC.modalPresentationStyle = .fullScreen
                    mainVC.present(detailVC, animated: true)
                }
            }.store(in: &cancellables)
        
        tableView.willDisplayCellPublisher.sink { [weak self] cell, indexPath in
            if let mainVC = self?.childViewController as? MainViewController {
                if indexPath.section == 0 && indexPath.row == mainVC.searchVM.document.count - 1 { // 마지막에 도달했을때
                    Timer.scheduledTimer(timeInterval: 0.5, target: self!, selector: #selector(self?.loadData), userInfo: nil, repeats: false)
                }
            }
        }.store(in: &cancellables)
        return tableView
    }()
    
    @objc func loadData() {
        if let mainVC = childViewController as? MainViewController {
            mainVC.searchVM.currentPage += 1
            mainVC.searchVM.numberSubject.send(mainVC.searchVM.currentPage)
            mainVC.searchVM.$document
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
                .sink { _ in
                    mainVC.resultView.tableView.reloadData()
                }.store(in: &cancellables)
        }
    }
    
    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            textLabel,
            tableView
        ])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .center
        return stackView
    }()
    
    var cancellables = Set<AnyCancellable>()
    
    init () {
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        addSubview(vStackView)
        
        
        vStackView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        textLabel.snp.makeConstraints { make in
            make.top.equalTo(vStackView.snp.top)
            make.leading.equalTo(vStackView.snp.leading).offset(20)
            make.trailing.equalTo(vStackView.snp.trailing).offset(-20)
            make.bottom.equalTo(tableView.snp.top).offset(-10)
        }
        
        tableView.snp.makeConstraints { make in
            
            make.leading.equalTo(vStackView.snp.leading).offset(20)
            make.trailing.equalTo(vStackView.snp.trailing).offset(-20)
            make.bottom.equalTo(vStackView.snp.bottom)
        }
    }
    
    
}
