//
//  wishVM.swift
//  Book
//
//  Created by Dongik Song on 5/6/24.
//

import UIKit
import Combine
import CoreData

class RecentVM {
    
    enum Router {
            case alert(title: String, message: String)
        }
    
    let context = (UIApplication.shared.delegate as! AppDelegate) .persistentContainer.viewContext
    let request: NSFetchRequest<RecentModel> = RecentModel.fetchRequest()
    
    @Published var recentDocument = [RecentModel]()
    @Published var isError: Bool = false
    
    var routerSubject = PassthroughSubject<Router, Never>()
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
            routerSubject.send(Router.alert(title: "예외 발생", message: "\(error.localizedDescription) 이 발생했습니다."))
        }
        
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
                    if sorted.count > 10 {
                        sorted = Array(sorted.prefix(10))
                    }
                    return sorted
                }
                .eraseToAnyPublisher()
                .assign(to: \.recentDocument, on: self)
                .store(in: &cancellables)
        } catch {
          
        }
     
    }
    
}
