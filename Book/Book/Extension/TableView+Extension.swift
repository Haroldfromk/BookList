//
//  TableView+Extension.swift
//  Book
//
//  Created by Dongik Song on 5/5/24.
//

import Foundation
import UIKit
import Kingfisher
import Combine

// MARK: - MainVC TableView Functions
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func setUp() {
        resultView.tableView.delegate = self
        resultView.tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchVM.document.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = resultView.tableView.dequeueReusableCell(withIdentifier: Constants.tableViewCellIdentifier) as? ResultTableViewCell else {
            return UITableViewCell()
        }
        
        let item = searchVM.document[indexPath.row]
        
        cell.configure(model: item)
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        
        // DetailVC에 전달
        searchVM.$document
            .receive(on: DispatchQueue.main)
            .map{ document -> Document in
                return document[indexPath.row]
            }
            .sink { document in
                let imageURL = URL(string: document.thumbnail)
                detailVC.titleView.titleLabel.text = document.title
                detailVC.titleView.authorLabel.text = document.authors[0]
                detailVC.imageView.imageView.kf.setImage(with: imageURL)
                detailVC.imageView.priceLabel.text = document.price.stringValue
                detailVC.bodyView.bodyLabel.text = document.contents
            }.store(in: &cancellables)
        
        // CoreData에 등록
        searchVM.$document
            .map{  document -> Document in
            return document[indexPath.row]
            }.sink(receiveValue: { [weak self] document in
                self?.wishVM.saveDocumentToCoredata(data: document)
            })
            .store(in: &cancellables)
        
        present(detailVC, animated: true)
    }
}

// MARK: - WishlistVC TableView Functions
extension WishlistViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setUp() {
        bodyTableView.tableView.delegate = self
        bodyTableView.tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = bodyTableView.tableView.dequeueReusableCell(withIdentifier: Constants.wishlistCellIdentifier) as? WishlistTableViewCell else {
            return UITableViewCell()
        }
        
        return cell
    }
}
