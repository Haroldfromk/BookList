//
//  Diffable+Extension.swift
//  Book
//
//  Created by Dongik Song on 5/11/24.
//

import UIKit

extension MainViewController {
    
    func configureDiffableDataSource () {
        tableDatasource = UITableViewDiffableDataSource(tableView: resultView.tableView, cellProvider: { tableView, indexPath, itemIdentifier in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.tableViewCellIdentifier, for: indexPath) as! ResultTableViewCell
            
            cell.configure(model: itemIdentifier)
            cell.selectionStyle = .none
            
            return cell
        })
    }
    
    func configureSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<DiffableSectionModel, Document>()
        snapshot.appendSections([.search])
        snapshot.appendItems(searchVM.document)
        
        tableDatasource?.apply(snapshot,animatingDifferences: true)
    }
    
}
