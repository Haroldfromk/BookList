//
//  ResultTableViewCell.swift
//  Book
//
//  Created by Dongik Song on 5/4/24.
//

import UIKit
import SnapKit

class ResultTableViewCell: UITableViewCell {
    
    let titleLabel = TextLabel().makeLabel(value: "Title")
    let priceLabel = TextLabel().makeCenterLabel(value: "Price")
    
    private lazy var hStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            titleLabel,
            priceLabel
        ])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 20
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
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    private func layout () {
        addSubview(hStackView)
        
        hStackView.snp.makeConstraints { make in
            make.leading.bottom.trailing.top.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(hStackView.snp.leading)
            make.top.equalTo(hStackView.snp.top)
            make.bottom.equalTo(hStackView.snp.bottom)
            make.trailing.equalTo(priceLabel.snp.leading).offset(-20)
            make.width.equalTo(250)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.trailing.equalTo(hStackView.snp.trailing)
            make.top.equalTo(hStackView.snp.top)
            make.bottom.equalTo(hStackView.snp.bottom)
        }
    }

}
