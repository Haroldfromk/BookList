//
//  ResultView.swift
//  Book
//
//  Created by Dongik Song on 5/4/24.
//

import UIKit
import SnapKit
import Combine

class ResultView: UIView {
    
    private let textLabel = TextLabel().makeLabel(textValue: "검색 결과")
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.register(ResultTableViewCell.self, forCellReuseIdentifier: Constants.tableViewCellIdentifier)
        //tableView.allowsSelection = true // 셀을 선택할수있게 한다.
        tableView.rowHeight = 80
        return tableView
    }()
    
    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            textLabel,
            tableView
        ])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .center
        return stackView
    }()
    
    init () {
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        addSubview(vStackView)
        
        
        vStackView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        textLabel.snp.makeConstraints { make in
            make.top.equalTo(vStackView.snp.top)
            make.leading.equalTo(vStackView.snp.leading).offset(20)
            make.trailing.equalTo(vStackView.snp.trailing).offset(-20)
            make.bottom.equalTo(tableView.snp.top).offset(-10)
        }
        
        tableView.snp.makeConstraints { make in
            
            make.leading.equalTo(vStackView.snp.leading).offset(20)
            make.trailing.equalTo(vStackView.snp.trailing).offset(-20)
            make.bottom.equalTo(vStackView.snp.bottom)
        }
    }
    
    
}
