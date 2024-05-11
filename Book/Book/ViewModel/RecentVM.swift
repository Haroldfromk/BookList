//
//  wishVM.swift
//  Book
//
//  Created by Dongik Song on 5/6/24.
//

import Foundation
import Combine
import CoreData

class RecentVM {
    
    
    @Published var recentDocument = [RecentModel]()
    private var cancellables = Set<AnyCancellable>()
    
    
    func saveDataToRecent (data: Document) {
        CoredataManager.shared.saveRecentDocumentToCoredata(data: data)
    }
    
    func convertModel(input: RecentModel) -> Document {
        
        var model = Document(authors: [], contents: "", price: 0, title: "", thumbnail: "")
        model.authors.append(input.author ?? "")
        model.contents = input.content ?? ""
        model.price = Int(input.price)
        model.title = input.title ?? ""
        model.thumbnail = input.image ?? ""
        
        return model
    }
    
    func getDocument () {
        CoredataManager.shared.getRecentDocumentfromCoreData().sink { complete in
            switch complete {
            case .finished:
                return
            case .failure(_):
                return
            }
        } receiveValue: {[weak self] model in
            self?.recentDocument = model
        }
        .store(in: &cancellables)
    }
    
    
}
