//
//  TableView+Extension.swift
//  Book
//
//  Created by Dongik Song on 5/5/24.
//

import Foundation
import UIKit
import Kingfisher

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setUp() {
        resultView.tableView.delegate = self
        resultView.tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return bookVM.document.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = resultView.tableView.dequeueReusableCell(withIdentifier: Constants.tableViewCellIdentifier) as? ResultTableViewCell else {
            return UITableViewCell()
        }
        
        let item = bookVM.document[indexPath.row]
        cell.isUserInteractionEnabled = true
        cell.selectionStyle = .none
        cell.titleLabel.text = item.title
        cell.priceLabel.text = String(item.price)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        
        let detailVC = DetailViewController()
        let item = bookVM.document[indexPath.row]
        let imageURL = URL(string: item.thumbnail)
        
        detailVC.titleView.titleLabel.text = item.title
        detailVC.titleView.authorLabel.text = item.authors[0]
        detailVC.imageView.imageView.kf.setImage(with: imageURL)
        detailVC.imageView.priceLabel.text = item.price.stringValue
        detailVC.bodyView.bodyLabel.text = item.contents
        
        present(detailVC, animated: true)
    }
}
