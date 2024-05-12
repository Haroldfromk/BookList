//
//  RecentCollectionViewCell.swift
//  Book
//
//  Created by Dongik Song on 5/4/24.
//

import UIKit
import SnapKit
import Kingfisher

class RecentCollectionViewCell: UICollectionViewCell {
    
    let imageView: UIImageView = {
       let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(systemName: "book")
        view.tintColor = .white
        view.clipsToBounds = true
        return view
    }()
    
    let titleLabel = TextLabel().makeSmallCenterLabel(value: "텍스트")
    
    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            imageView,
            titleLabel
        ])
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout() {
        self.backgroundColor = .white
        self.addSubview(vStackView)
        
        vStackView.snp.makeConstraints { make in
            make.leading.bottom.trailing.top.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.height.equalTo(vStackView.snp.height).multipliedBy(0.6)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom)
            make.leading.bottom.trailing.equalToSuperview()
            make.height.equalTo(vStackView.snp.height).multipliedBy(0.4)
        }
    }
    
    func configure (model: RecentModel) {
        guard let image = model.image else {return}
        imageView.kf.setImage(with: URL(string: image))
        titleLabel.text = model.title
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        titleLabel.text = nil
    }
}
