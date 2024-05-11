//
//  BookVM.swift
//  Book
//
//  Created by Dongik Song on 5/5/24.
//


import Foundation
import Combine

class SearchVM {
    
    struct Input { // searchBar input을 받기위함.
        let searchPublisher: AnyPublisher<String, Never>
        let numberPublisher: AnyPublisher<Int, Never>
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published var document = [Document]()
    
    var currentPage = 1
    
    let numberSubject = PassthroughSubject<Int, Never>()
    var valuePublisher: AnyPublisher<Int, Never> {
        return numberSubject.eraseToAnyPublisher()
    }
    
    
    func transform(input: Input) {
        Publishers.CombineLatest(input.searchPublisher, input.numberPublisher)
            .map { [unowned self] (value, page) in
                if value.isEmpty {
                    currentPage = 1
                    document = []
                }
                return (value, currentPage)
            }
            .eraseToAnyPublisher()
            .sink { [weak self] (value, page) in
                guard !value.isEmpty else { return } // value가 빈 문자열인 경우 fetchTotalRequest 호출하지 않음
                NetworkManager.shared.fetchTotalRequest(queryValue: value, page: page)
                    .sink { completion in
                        switch completion {
                        case .finished:
                            return
                        case .failure(_):
                            return
                        }
                    } receiveValue: { document in
                        document.forEach { doc in
                            self!.document.append(doc)
                        }
                    }.store(in: &self!.cancellables)
            }
            .store(in: &cancellables)
    }
    
}
