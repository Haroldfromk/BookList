//
//  wishVM.swift
//  Book
//
//  Created by Dongik Song on 5/6/24.
//

import Foundation
import Combine
import CoreData
import UIKit

class WishVM {
    
    let context = (UIApplication.shared.delegate as! AppDelegate) .persistentContainer.viewContext
    let request: NSFetchRequest<RecentModel> = RecentModel.fetchRequest()
    
    @Published var wishDocument = [RecentModel]()
    private var cancellables = Set<AnyCancellable>()
    
    func saveDocumentToCoredata (data: Document) {
        
        let newItem = RecentModel(context: context)
        newItem.title = data.title
        newItem.author = data.authors[0]
        newItem.content = data.contents
        newItem.image = data.thumbnail
        newItem.price = Int64(data.price)
        newItem.date = Date().timeIntervalSince1970
        
        do {
            try context.save()
        } catch {
            
        }
        
    }
    
    func getDocumentfromCoreData () {
        
        do {
            try context.fetch(request).publisher
                .flatMap { data in
                    Publishers.Sequence(sequence: [data])}
                .collect()
                .map { data in
                    var sorted = data.sorted { first, second in
                        first.date > second.date
                    }
                    return sorted
                }
                .assign(to: \.wishDocument, on: self)
                .store(in: &cancellables)
        } catch {
            
        }
    }
    
}
