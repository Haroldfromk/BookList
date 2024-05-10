//
//  BookVM.swift
//  Book
//
//  Created by Dongik Song on 5/5/24.
//


import UIKit
import Combine

class SearchVM {
    
    struct Input { // searchBar input을 받기위함.
        let searchPublisher: AnyPublisher<String, Never>
        let numberPublisher: AnyPublisher<Int, Never>
    }
   
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published var document = [Document]()
    var totalDocumnet: BookModel = .init(meta: .init(isEnd: false, pageableCount: 0, totalCount: 0), documents: [.init(authors: [], contents: "", price: 0, title: "", thumbnail: "")])
    
    var currentPage = 1
    
   
    let numberSubject = PassthroughSubject<Int, Never>()
    var valuePublisher: AnyPublisher<Int, Never> {
        return numberSubject.eraseToAnyPublisher()
    }
    
    func transform(input: Input) {
            
            Publishers.CombineLatest(input.searchPublisher, input.numberPublisher).flatMap { value, page in
                let tuple = (value, page)
                return Just(tuple)
            }
            .eraseToAnyPublisher()
            .sink { [weak self] data in
                self?.fetchTotalRequest(queryValue: data.0, page: data.1)
            }.store(in: &cancellables)
            
        }
    
    func fetchTotalRequest(queryValue: String, page: Int) {
        let urlString = "https://dapi.kakao.com/v3/search/book?target=title"
        let headers = ["Authorization" : "KakaoAK \(Secret.apikey)"]
        
        var urlComponent = URLComponents(string: urlString)
        urlComponent?.queryItems?.append(URLQueryItem(name: "query", value: queryValue))
        urlComponent?.queryItems?.append(URLQueryItem(name: "page", value: page.stringValue))
        
        guard let url = urlComponent?.url else {
            return
        }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        request.httpMethod = "GET"
        
        let session = URLSession(configuration: .default)
        session.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: BookModel.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
            .replaceError(with: totalDocumnet)
            .sink(receiveValue: { [weak self] model in
                if model.meta.isEnd == false {
                    self?.document.append(contentsOf: model.documents)
                } else {
                    return
                }
            })
            .store(in: &cancellables)
    }
    
}
