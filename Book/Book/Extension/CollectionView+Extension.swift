//
//  CollectionView+Extension.swift
//  Book
//
//  Created by Dongik Song on 5/7/24.
//

import UIKit
import Combine
import Kingfisher

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionSetUp () {
        recentView.collectionView.dataSource = self
        recentView.collectionView.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        recentVM.recentDocument.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = recentView.collectionView.dequeueReusableCell(withReuseIdentifier: Constants.collectionViewCellIdentifier, for: indexPath) as? RecentCollectionViewCell else { return UICollectionViewCell() }
        
        recentVM.$recentDocument
            .map { document in
                return document[indexPath.row]
            }
            .eraseToAnyPublisher()
            .sink { model in
                let image = URL(string: model.image!)
                cell.imageView.kf.setImage(with: image)
                cell.titleLabel.text = model.title
            }.store(in: &cancellables)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailVC = DetailViewController()
        
        recentVM.$recentDocument
            .map { document in
                return document[indexPath.row]
            }
            .eraseToAnyPublisher()
            .sink { [weak self] model in
                let imageURL = URL(string: model.image!)
                detailVC.titleView.titleLabel.text = model.title
                detailVC.titleView.authorLabel.text = model.author
                detailVC.imageView.imageView.kf.setImage(with: imageURL)
                detailVC.imageView.priceLabel.text = model.price.stringValue
                detailVC.bodyView.bodyLabel.text = model.content
                detailVC.wishSubject.send((self?.recentVM.convertModel(input: model))!)
            }.store(in: &cancellables)
        
        present(detailVC, animated: true)
    }
    
}
