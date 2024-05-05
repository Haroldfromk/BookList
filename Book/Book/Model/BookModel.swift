//
//  BookModel.swift
//  Book
//
//  Created by Dongik Song on 5/5/24.
//

import Foundation

struct BookModel: Codable {
    
    let documents: [Document]
    
}

struct Document: Codable {
    
    let authors: [String]
    let contents: String
    let price: Int
    let title: String
    let thumbnail: String
    let salePrice: Int?
    
    enum Codingkeys: String, CodingKey {
        case salePrice = "sale_price"
    }
    
}
