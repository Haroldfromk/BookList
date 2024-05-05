//
//  NetworkManager.swift
//  Book
//
//  Created by Dongik Song on 5/5/24.
//

import Foundation
import Combine
import CombineCocoa

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchRequest(queryValue: String) -> AnyPublisher<[Document], Error> {
        
        let urlString = "https://dapi.kakao.com/v3/search/book?target=title"
        let headers = ["Authorization" : "KakaoAK \(Secret.apikey)"]
        
        var urlComponent = URLComponents(string: urlString)
        urlComponent?.queryItems?.append(URLQueryItem(name: "query", value: queryValue))
        
        guard let url = urlComponent?.url else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher() // Error 리턴
        }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        let session = URLSession(configuration: .default)
        return session.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: BookModel.self, decoder: JSONDecoder())
            .map(\.documents)
            .eraseToAnyPublisher()
    }
}
