//
//  TableView+Extension.swift
//  Book
//
//  Created by Dongik Song on 5/5/24.
//

import Foundation
import UIKit

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setUp() {
        resultView.tableView.delegate = self
        resultView.tableView.dataSource = self
        resultView.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tableViewList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = resultView.tableView.dequeueReusableCell(withIdentifier: Constants.tableViewCellIdentifier) as? ResultTableViewCell else {
            return UITableViewCell()
        }
        
        let item = tableViewList[indexPath.row]
        cell.titleLabel.text = item.title
        cell.priceLabel.text = String(item.price)
        
        return cell
    }

}
