//
//  NetworkManager.swift
//  Book
//
//  Created by Dongik Song on 5/10/24.
//

import Foundation
import Combine

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init () {}
    
    let searchVM = SearchVM()
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchTotalRequest(queryValue: String, page: Int) -> Future<[Document], Error> {
        
        return Future<[Document], Error> { [weak self] complete in
            
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
                .map { model in
                    if model.meta.isEnd == false {
                        return model.documents
                    } else {
                        return []
                    }
                }
                .replaceError(with: [])
                .sink(receiveValue: { document in
                    complete(.success(document))
                })
                .store(in: &self!.cancellables)
        }
    }
    
    

    
}
