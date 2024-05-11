//
//  BookModel.swift
//  Book
//
//  Created by Dongik Song on 5/5/24.
//

import Foundation

struct BookModel: Codable, Hashable {
    
    var meta: Meta
    var documents: [Document]
    
}

struct Meta: Codable, Hashable {
    
    var isEnd: Bool
    var pageableCount: Int
    var totalCount: Int
    
    enum CodingKeys: String, CodingKey {
        case isEnd = "is_end"
        case pageableCount = "pageable_count"
        case totalCount = "total_count"
    }
    
    init(isEnd: Bool, pageableCount: Int, totalCount: Int) {
        self.isEnd = isEnd
        self.pageableCount = pageableCount
        self.totalCount = totalCount
    }
}

struct Document: Codable,Hashable {
    
    var authors: [String]
    var contents: String
    var price: Int
    var title: String
    var thumbnail: String
    
    
    init(authors: [String], contents: String, price: Int, title: String, thumbnail: String) {
        self.authors = authors
        self.contents = contents
        self.price = price
        self.title = title
        self.thumbnail = thumbnail
    }
}
