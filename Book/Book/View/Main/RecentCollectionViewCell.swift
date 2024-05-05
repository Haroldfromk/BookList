//
//  RecentCollectionViewCell.swift
//  Book
//
//  Created by Dongik Song on 5/4/24.
//

import UIKit
import SnapKit

class RecentCollectionViewCell: UICollectionViewCell {
    
    private var imageView: UIImageView = {
       let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.image = UIImage(systemName: "book")
        view.tintColor = .white
        view.clipsToBounds = true
        return view
    }()
    
    func configure(image: UIImage) {
        self.imageView.image = image
        self.layout()
    }
    
    func layout() {
        self.backgroundColor = .white
        self.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.leading.bottom.trailing.top.equalToSuperview()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil
    }
}
