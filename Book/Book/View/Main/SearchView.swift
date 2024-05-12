//
//  SearchView.swift
//  Book
//
//  Created by Dongik Song on 5/4/24.
//

import UIKit
import Combine
import CombineCocoa
import SnapKit

class SearchView: UIView {
    
    let searchVM = SearchVM()
    
    lazy var searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.placeholder = "검색어를 입력하세요."
        bar.returnKeyType = .done
        bar.showsCancelButton = true
        bar.searchButtonClickedPublisher.sink { [unowned self] _ in
            observe()
        }.store(in: &cancellables)
        bar.cancelButtonClickedPublisher.sink { [unowned self] _ in
            endEditing(true)
        }.store(in: &cancellables)
        return bar
    }()
    
    private let searchBarSubject = PassthroughSubject<String, Never>()
    
    var valuePublisher: AnyPublisher<String, Never> {
        return searchBarSubject.eraseToAnyPublisher()
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    init () {
        super.init(frame: .zero)
        layout()
        observe()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func observe() {
        searchBar.searchTextField.textPublisher
            .debounce(for: 1, scheduler: RunLoop.main) // 1초의 시간을 기다렸다가 전달.
            .sink { [weak self] value in
                    self?.searchBarSubject.send(value)
                    self?.endEditing(true)
        }.store(in: &cancellables)
    }
    
    private func layout() {
        addSubview(searchBar)
        
        searchBar.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
    }
}
