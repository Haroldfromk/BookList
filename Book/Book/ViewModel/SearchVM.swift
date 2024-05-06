//
//  BookVM.swift
//  Book
//
//  Created by Dongik Song on 5/5/24.
//

import Foundation
import Combine

class SearchVM {
    
    struct Input {
        let searchPublisher: AnyPublisher<String, Never>
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published var document = [Document]()
    
    func transform(input: Input) {
        input.searchPublisher.sink { [weak self] value in
            self?.fetchRequest(queryValue: value)
        }.store(in: &cancellables)
    }
    
    func fetchRequest(queryValue: String) {
        let urlString = "https://dapi.kakao.com/v3/search/book?target=title"
        let headers = ["Authorization" : "KakaoAK \(Secret.apikey)"]
        
        var urlComponent = URLComponents(string: urlString)
        urlComponent?.queryItems?.append(URLQueryItem(name: "query", value: queryValue))
        
        guard let url = urlComponent?.url else {
            return
        }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        
        let session = URLSession(configuration: .default)
        
        return session.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: BookModel.self, decoder: JSONDecoder())
            .map(\.documents)
            .replaceError(with: [])
            .assign(to: \.document, on: self)
            .store(in: &cancellables)
    }
}
