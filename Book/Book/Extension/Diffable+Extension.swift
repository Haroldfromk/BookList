//
//  Diffable+Extension.swift
//  Book
//
//  Created by Dongik Song on 5/11/24.
//

import UIKit

extension MainViewController {
    
    func configureDiffableDataSource () {
        tableDatasource = UITableViewDiffableDataSource(tableView: resultView.tableView, cellProvider: { tableView, indexPath, model in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.tableViewCellIdentifier, for: indexPath) as! ResultTableViewCell
            
            cell.configure(model: model)
            cell.selectionStyle = .none
            
            return cell
        })
        
        collectionDatasource = UICollectionViewDiffableDataSource(collectionView: recentView.collectionView, cellProvider: { collectionView, indexPath, collectionModel in
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.collectionViewCellIdentifier, for: indexPath) as! RecentCollectionViewCell
            
            cell.configure(model: collectionModel)
            
            return cell
        })
        
    }
    
    func configureSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<DiffableSectionModel, Document>()
        snapshot.appendSections([.search])
        snapshot.appendItems(searchVM.document)

        tableDatasource?.apply(snapshot,animatingDifferences: true)
        
    }
    
    func collectionConfigureSnapshot () {
        var collectionSnapshot = NSDiffableDataSourceSnapshot<DiffableSectionModel, RecentModel>()
        collectionSnapshot.appendSections([.recent])
        collectionSnapshot.appendItems(recentVM.recentDocument)
        
        collectionDatasource?.apply(collectionSnapshot, animatingDifferences: true)
    }
    
}
