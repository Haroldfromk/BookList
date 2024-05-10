//
//  HeaderView.swift
//  Book
//
//  Created by Dongik Song on 5/6/24.
//

import UIKit
import SnapKit
import Combine

class HeaderView: UIView {
    
    private let title = TextLabel().makeLargeLabel(textValue: "담은 책")
    
    private lazy var deleteAllButton: UIButton = {
        let button = UIButton()
        button.setTitle("전체 삭제", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.backgroundColor = .white
        button.tapPublisher.sink { [unowned self] _ in
            if let vc = childViewController as? WishlistViewController {
                let alert = UIAlertController(title: "삭제하시겠습니까?", message: "삭제하시면 복원은 불가능합니다.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .destructive, handler: { [unowned self] _ in
                    vc.wishVM.deleteAllData()
                    vc.wishVM.getDocumentfromCoreData()
                    vc.bodyTableView.tableView.reloadData()
                }))
                alert.addAction(UIAlertAction(title: "취소", style: .default))
                vc.present(alert, animated: true) }
        }.store(in: &cancellables)
        return button
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.setTitle("추가", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.backgroundColor = .white
        button.tapPublisher.sink { [unowned self] _ in
            if let tabBarController = self.window!.rootViewController as? UITabBarController {
                tabBarController.selectedIndex = 0
                let current = tabBarController.selectedViewController as? MainViewController
                current?.searchView.searchBar.becomeFirstResponder()
            }
        }.store(in: &cancellables)
        return button
    }()
    
    private lazy var hStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            deleteAllButton,
            title,
            addButton
        ])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private var cancellables = Set<AnyCancellable>()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout () {
        self.addSubview(hStackView)
        
        hStackView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
    }
    
}
