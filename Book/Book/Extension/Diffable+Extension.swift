//
//  Diffable+Extension.swift
//  Book
//
//  Created by Dongik Song on 5/11/24.
//

import UIKit

extension MainViewController {
    
    func configureDiffableDataSource () {
        recentTableDatasource = UITableViewDiffableDataSource(tableView: resultView.tableView, cellProvider: { tableView, indexPath, model in
            
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
        tableSnapshot = NSDiffableDataSourceSnapshot<DiffableSectionModel, Document>()
        tableSnapshot?.deleteAllItems()
        tableSnapshot?.appendSections([.search])
        tableSnapshot?.appendItems(searchVM.document)

        recentTableDatasource?.apply(tableSnapshot!,animatingDifferences: true)
        
    }
    
    func collectionConfigureSnapshot () {
        collectionSnapshot = NSDiffableDataSourceSnapshot<DiffableSectionModel, RecentModel>()
        collectionSnapshot?.deleteAllItems()
        collectionSnapshot?.appendSections([.recent])
        collectionSnapshot?.appendItems(recentVM.recentDocument)
        
        collectionDatasource?.apply(collectionSnapshot!, animatingDifferences: true)
    }
    
}

extension WishlistViewController {
        
    func configureDiffableDataSource () {
        wishTableDatasource = UITableViewDiffableDataSource(tableView: bodyTableView.tableView, cellProvider: { tableView, indexPath, model in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.wishlistCellIdentifier, for: indexPath) as! WishlistTableViewCell
            
            cell.configure(model: model)
            cell.selectionStyle = .none
            
            return cell
        })
    
    }
    
    func configureSnapshot() {
        
        snapshot = NSDiffableDataSourceSnapshot<DiffableSectionModel, WishListModel>()
        snapshot?.deleteAllItems()
        snapshot?.appendSections([.wish])
        snapshot?.appendItems(wishVM.wishDocument)

        wishTableDatasource?.apply(snapshot!,animatingDifferences: true)
        
    }
    
}
