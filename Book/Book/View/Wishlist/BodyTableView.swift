//
//  BodyTableView.swift
//  Book
//
//  Created by Dongik Song on 5/6/24.
//

import UIKit
import SnapKit
import Combine
import CombineCocoa

class BodyTableView: UIView {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.allowsSelection = false
        tableView.register(WishlistTableViewCell.self, forCellReuseIdentifier: Constants.wishlistCellIdentifier)
        tableView.rowHeight = 80
        return tableView
    }()
    
    private lazy var swipePublisher: AnyPublisher<Void, Never> = {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: nil)
        tableView.addGestureRecognizer(swipeGesture)
        
        return swipeGesture.swipePublisher.flatMap { _ in
            Just(())
        }.eraseToAnyPublisher()
    }()
    
    var cancellables = Set<AnyCancellable>()
    
    private func observe () {
        swipePublisher.sink { indexPath in
            print(indexPath)
        }.store(in: &cancellables)
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout () {
        self.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
}
