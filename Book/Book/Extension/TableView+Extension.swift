//
//  TableView+Extension.swift
//  Book
//
//  Created by Dongik Song on 5/5/24.
//

import UIKit
import Kingfisher
import Combine

// MARK: - MainVC TableView Functions
extension MainViewController: UITableViewDelegate {
    
    func tableSetUp() {
        resultView.tableView.delegate = self
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
        searchVM.$document
            .map{  document in
                if !document.isEmpty {
                    return document[indexPath.row]
                } else {
                    return document[0]
                }
            }
            .eraseToAnyPublisher()
            .sink(receiveValue: { [unowned self] document in
                recentVM.saveDataToRecent(data: document)
            }).cancel()
        
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
        searchVM.$document
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
            .sink { [weak self] _ in
                self?.resultView.tableView.reloadData()
            }.store(in: &cancellables)
    }
    
}

// MARK: - WishlistVC TableView Functions
extension WishlistViewController: UITableViewDelegate {
    
    func setUp() {
        bodyTableView.tableView.delegate = self
    }
    
    // SwipeAction For Delete Specific Cell
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteButton = UIContextualAction(style: .normal, title: "삭제") { (UIContextualAction, UIView, success: @escaping (Bool) -> Void)  in
            let alert = UIAlertController(title: "삭제하기", message: "정말 삭제하실 건가요?", preferredStyle: .alert)
            
            let ok = UIAlertAction(title: "OK", style: .destructive, handler: { [unowned self] _ in
                
                wishVM.deleteSelectedData(selectedCell: wishVM.wishDocument[indexPath.row])
                wishVM.wishDocument.remove(at: indexPath.row)

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
