//
//  BookVM.swift
//  Book
//
//  Created by Dongik Song on 5/5/24.
//

import Foundation
import Combine
import UIKit

class BookVM {
    
    struct Input {
        let searchPublisher: AnyPublisher<String, Never>
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published var document = [Document]()
    
    func transform(input: Input) {

        input.searchPublisher.sink { [weak self] value in
            self?.callRequest(query: value)
        }.store(in: &cancellables)
        
    }
    
    
    func callRequest(query: String) {
        
        NetworkManager.shared.fetchRequest(queryValue: query).sink { completion in
            switch completion {
            case .finished:
                print("success")
            case .failure(let error):
                print(error)
            }
        } receiveValue: { [weak self] documents in
            self?.document = documents
        }.store(in: &cancellables)
    }
}
