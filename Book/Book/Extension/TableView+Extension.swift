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
    
    
    func tableSetUp() {
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
            .map{ document in
                return document[indexPath.row]
            }
            .eraseToAnyPublisher()
            .receive(on: DispatchQueue.main)
            .sink { document in
                let imageURL = URL(string: document.thumbnail)
                detailVC.titleView.titleLabel.text = document.title
                detailVC.titleView.authorLabel.text = document.authors.joined()
                detailVC.imageView.imageView.kf.setImage(with: imageURL)
                detailVC.imageView.priceLabel.text = document.price.stringValue
                detailVC.bodyView.bodyLabel.text = document.contents
                detailVC.wishSubject.send(document)
            }.store(in: &cancellables)
        
        // CoreData에 등록
        searchVM.$document
            .map{  document in
                if !document.isEmpty {
                    return document[indexPath.row]
                } else {
                    return document[0]
                }
            }
            .eraseToAnyPublisher()
            .sink(receiveValue: { [weak self] document in
                self?.recentVM.saveDocumentToCoredata(data: document)
            })
            .store(in: &cancellables)
        
        detailVC.modalPresentationStyle = .fullScreen
        present(detailVC, animated: true)
    }

    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == searchVM.document.count - 1 { // 마지막에 도달했을때
            Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(loadData), userInfo: nil, repeats: false)
           
        }
        
    }
    
    @objc func loadData() {
        searchVM.currentPage += 1
        searchVM.numberSubject.send(searchVM.currentPage)
        searchVM.transform(input: SearchVM.Input(searchPublisher: searchView.valuePublisher, numberPublisher: searchVM.valuePublisher))
        searchVM.$document
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
            .sink { [weak self] _ in
                self?.resultView.tableView.reloadData()
            }.store(in: &cancellables)
        print(searchVM.currentPage)
    }
    
}

// MARK: - WishlistVC TableView Functions
extension WishlistViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setUp() {
        bodyTableView.tableView.delegate = self
        bodyTableView.tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        wishVM.wishDocument.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = bodyTableView.tableView.dequeueReusableCell(withIdentifier: Constants.wishlistCellIdentifier) as? WishlistTableViewCell else {
            return UITableViewCell()
        }
        
        let item = wishVM.wishDocument[indexPath.row]
    
        cell.configure(model: item)
        cell.selectionStyle = .none
        
        return cell
    }
    
    // SwipeAction For Delete Specific Cell
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteButton = UIContextualAction(style: .normal, title: "삭제") { (UIContextualAction, UIView, success: @escaping (Bool) -> Void)  in
            let alert = UIAlertController(title: "삭제하기", message: "정말 삭제하실 건가요?", preferredStyle: .alert)
            
            let ok = UIAlertAction(title: "OK", style: .destructive, handler: { [unowned self] _ in
                
                wishVM.deleteSpeificData(selectedCell: wishVM.wishDocument[indexPath.row])
                tableView.beginUpdates()
                wishVM.wishDocument.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.endUpdates()
            })
            
            let cancel = UIAlertAction(title: "취소", style: .default)
            
            alert.addAction(ok)
            alert.addAction(cancel)
            self.present(alert,animated: false)
            
            success(true)
        }
        deleteButton.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [deleteButton])
    }
}
