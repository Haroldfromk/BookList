//
//  BodyView.swift
//  Book
//
//  Created by Dongik Song on 5/6/24.
//

import UIKit
import SnapKit

class BodyView: UIView {
    
    private var scrollView: UIScrollView = {
        var view = UIScrollView()
        view.isScrollEnabled = true
        view.showsVerticalScrollIndicator = true
        return view
    }()
    
    var bodyLabel = TextLabel().makeLabel(value: "body")
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout () {
        addSubview(scrollView)
        scrollView.addSubview(bodyLabel)
        
        scrollView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        bodyLabel.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.top)
            make.leading.equalTo(scrollView.snp.leading)
            make.trailing.equalTo(scrollView.snp.trailing)
            make.bottom.equalTo(scrollView.snp.bottom)
            make.width.equalTo(scrollView)
        }
    }
    
}
