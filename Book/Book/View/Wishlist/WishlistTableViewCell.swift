//
//  WishlistTableViewCell.swift
//  Book
//
//  Created by Dongik Song on 5/6/24.
//

import UIKit
import SnapKit

class WishlistTableViewCell: UITableViewCell {
    
    let titleLabel = TextLabel().makeLabel(value: "Title")
    let authorLabel = TextLabel().makeCenterLabel(value: "세이노")
    let priceLabel = TextLabel().makeCenterLabel(value: "Price")
    
    private lazy var hStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
        titleLabel,
        authorLabel,
        priceLabel
        ])
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        titleLabel.text = nil
        authorLabel.text = nil
        priceLabel.text = nil
    }
    
    func configure (model: WishListModel) {
        titleLabel.text = model.title
        authorLabel.text = model.author
        priceLabel.text = model.price.stringValue
    }
    
    private func layout () {
        addSubview(hStackView)
        
        hStackView.snp.makeConstraints { make in
            make.leading.bottom.trailing.top.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(hStackView.snp.leading).offset(10)
            make.top.equalTo(hStackView.snp.top)
            make.bottom.equalTo(hStackView.snp.bottom)
            make.width.equalTo(150)
        }
        
        authorLabel.snp.makeConstraints { make in
            make.top.equalTo(hStackView.snp.top)
            make.leading.equalTo(titleLabel.snp.trailing)
            make.trailing.equalTo(priceLabel.snp.leading).offset(-20)
            make.bottom.equalTo(hStackView.snp.bottom)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.trailing.equalTo(hStackView.snp.trailing).offset(-10)
            make.top.equalTo(hStackView.snp.top)
            make.bottom.equalTo(hStackView.snp.bottom)
        }
    }
    
}
