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
    
    enum Router {
        case alert(title: String, message: String)
    }
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate) .persistentContainer.viewContext
    let recentRequest: NSFetchRequest<RecentModel> = RecentModel.fetchRequest()
    let wishRequest: NSFetchRequest<WishListModel> = WishListModel.fetchRequest()
    
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - recent
    func saveRecentDocumentToCoredata (data: Document, completion: @escaping ((Result<Void, Error>) -> Void)) {
        
        let newItem = RecentModel(context: context)
        newItem.title = data.title
        newItem.author = data.authors[0]
        newItem.content = data.contents
        newItem.image = data.thumbnail
        newItem.price = Int64(data.price)
        newItem.date = Date().timeIntervalSince1970
        print("저장완료")
        
        do {
            completion(.success(
                try context.save()
            ))
        } catch {
            completion(.failure(error))
        }
        
    }
    
    
    func getRecentDocumentfromCoreData () -> Future<[RecentModel], Error> {
        
        return Future<[RecentModel], Error> { [unowned self] complete in
            do {
                try context.fetch(recentRequest).publisher
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
                complete(.failure(error))
            }
        }
    }
    
    // MARK: - wish
    func saveWishDocumentToCoredata (data: Document, completion: @escaping ((Result<Void, Error>) -> Void)) {
        
        let newItem = WishListModel(context: context)
        newItem.title = data.title
        newItem.author = data.authors[0]
        newItem.content = data.contents
        newItem.image = data.thumbnail
        newItem.price = Int64(data.price)
        
        do {
            completion(.success(
                try context.save()
            ))
        } catch {
            completion(.failure(error))
        }
        
    }
    
    func getWishDocumentfromCoreData () -> Future<[WishListModel] ,Error>{
        
        return Future<[WishListModel], Error> { [unowned self] complete in
            do {
                try context.fetch(wishRequest).publisher.flatMap { data in
                    Publishers.Sequence(sequence: [data])
                }
                .collect()
                .eraseToAnyPublisher()
                .sink(receiveValue: { model in
                    complete(.success(model))
                })
                .store(in: &cancellables)
            } catch {
                complete(.failure(error))
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
                .collect()
                .eraseToAnyPublisher()
                .sink(receiveValue: { model in
                    complete(.success(model))
                })
                .store(in: &cancellables)
            } catch {
                complete(.failure(error))
            }
        }
    }
    
    func deleteAllData (completion: @escaping ((Result<Void, Error>) -> Void)) {
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "WishListModel")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try context.execute(deleteRequest)
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
        
        
        
    }
    
    func deleteSpeificData (selectedCell: NSManagedObject, completion: @escaping ((Result<Void, Error>) -> Void)) {
        do {
            context.delete(selectedCell)
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
        
    }
}
