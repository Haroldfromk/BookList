//
//  CoredataManager.swift
//  Book
//
//  Created by Dongik Song on 5/10/24.
//

import UIKit
import CoreData
import Combine

class CoredataManager {
    
    static let shared = CoredataManager()
    
    let context = (UIApplication.shared.delegate as! AppDelegate) .persistentContainer.viewContext
    
    let recentRequest: NSFetchRequest<RecentModel> = RecentModel.fetchRequest()
    let wishRequest: NSFetchRequest<WishListModel> = WishListModel.fetchRequest()
    
    private init () { }
    
    enum Router {
        case alert(title: String, message: String)
    }
    
    var routerSubject = PassthroughSubject<Router, Never>()
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - recent
    func saveRecentDocumentToCoredata (data: Document) {
        
        let newItem = RecentModel(context: context)
        newItem.title = data.title
        newItem.author = data.authors[0]
        newItem.content = data.contents
        newItem.image = data.thumbnail
        newItem.price = Int64(data.price)
        newItem.date = Date().timeIntervalSince1970
        print("저장완료")
        
        do {
            try context.save()
        } catch {
            routerSubject.send(Router.alert(title: "예외 발생", message: "\(error.localizedDescription) 이 발생했습니다."))
        }
        
    }
    
    
    func getRecentDocumentfromCoreData () -> Future<[RecentModel], Error> {
        
        return Future<[RecentModel], Error> { [unowned self] complete in
            do {
                try context.fetch(recentRequest).publisher
                    .receive(on: DispatchQueue.main)
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
                    .sink(receiveValue: { data in
                        complete(.success(data))
                    })
                    .store(in: &cancellables)
            } catch {
                routerSubject.send(Router.alert(title: "예외 발생", message: "\(error.localizedDescription) 이 발생했습니다."))
            }
        }
    }
    
    // MARK: - wish
    func saveWishDocumentToCoredata (data: Document) {
        
        let newItem = WishListModel(context: context)
        newItem.title = data.title
        newItem.author = data.authors[0]
        newItem.content = data.contents
        newItem.image = data.thumbnail
        newItem.price = Int64(data.price)
        
        do {
            try context.save()
        } catch {
            routerSubject.send(Router.alert(title: "예외 발생", message: "\(error.localizedDescription) 이 발생했습니다."))
        }
        
    }
    
    func getWishDocumentfromCoreData () -> Future<[WishListModel] ,Error>{
        
        return Future<[WishListModel], Error> { [unowned self] complete in
            do {
                try context.fetch(wishRequest).publisher.flatMap { data in
                    Publishers.Sequence(sequence: [data])
                }
                .receive(on: DispatchQueue.main
                )
                .collect()
                .eraseToAnyPublisher()
                .sink(receiveValue: { model in
                    complete(.success(model))
                })
                .store(in: &cancellables)
            } catch {
                routerSubject.send(Router.alert(title: "예외 발생", message: "\(error.localizedDescription) 이 발생했습니다."))
            }
        }
    }
    
    func getSpecificData (title: String) -> Future<[WishListModel] ,Error> {
        
        return Future<[WishListModel], Error> { [unowned self] complete in
            
            let predicateRequest: NSFetchRequest<WishListModel> = WishListModel.fetchRequest()
            let predicate = NSPredicate(format: "title == %@", title)
            predicateRequest.predicate = predicate
            
            do {
                try context.fetch(predicateRequest).publisher.flatMap { data in
                    Publishers.Sequence(sequence: [data])
                }
                .receive(on: DispatchQueue.main)
                .collect()
                .eraseToAnyPublisher()
                .sink(receiveValue: { model in
                    complete(.success(model))
                })
                .store(in: &cancellables)
            } catch {
                routerSubject.send(Router.alert(title: "예외 발생", message: "\(error.localizedDescription) 이 발생했습니다."))
            }
        }
    }
    
    func deleteAllData () {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "WishListModel")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            routerSubject.send(Router.alert(title: "예외 발생", message: "\(error.localizedDescription) 이 발생했습니다."))
        }
    }
    
    func deleteSpeificData (selectedCell: NSManagedObject) {
        do {
            context.delete(selectedCell)
            try context.save()
        } catch {
            routerSubject.send(Router.alert(title: "예외 발생", message: "\(error.localizedDescription) 이 발생했습니다."))
        }
        
    }
}
