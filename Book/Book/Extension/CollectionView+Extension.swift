//
//  CollectionView+Extension.swift
//  Book
//
//  Created by Dongik Song on 5/7/24.
//

import UIKit
import Combine
import Kingfisher

extension MainViewController: UICollectionViewDelegate {
    
//    func collectionSetUp () {
//        recentView.collectionView.delegate = self
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        
//        let detailVC = DetailViewController()
//        
//        recentVM.$recentDocument
//            .map { document in
//                return document[indexPath.row]
//            }
//            .eraseToAnyPublisher()
//            .sink { [weak self] model in
//                let imageURL = URL(string: model.image!)
//                detailVC.titleView.titleLabel.text = model.title
//                detailVC.titleView.authorLabel.text = model.author
//                detailVC.imageView.imageView.kf.setImage(with: imageURL)
//                detailVC.imageView.priceLabel.text = model.price.stringValue
//                detailVC.bodyView.bodyLabel.text = model.content
//                detailVC.wishSubject.send((self?.recentVM.convertModel(input: model))!)
//            }.store(in: &cancellables)
//        
//        present(detailVC, animated: true)
//    }
    
}
