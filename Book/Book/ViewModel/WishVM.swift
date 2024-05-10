//
//  WishVM.swift
//  Book
//
//  Created by Dongik Song on 5/7/24.
//

import UIKit
import CoreData
import Combine


class WishVM {

    enum Router {
            case alert(title: String, message: String)
        }
    
    let context = (UIApplication.shared.delegate as! AppDelegate) .persistentContainer.viewContext
    let request: NSFetchRequest<WishListModel> = WishListModel.fetchRequest()
    
    private var cancellables = Set<AnyCancellable>()
    
    var routerSubject = PassthroughSubject<Router, Never>()
    @Published var wishDocument = [WishListModel]()
    
    func saveDocumentToCoredata (data: Document) {
        
        let newItem = WishListModel(context: context)
        newItem.title = data.title
        newItem.author = data.authors[0]
        newItem.content = data.contents
        newItem.image = data.thumbnail
        newItem.price = Int64(data.price)
        
        do {
            try context.save()
            print("담기 완료")
        } catch {
            routerSubject.send(Router.alert(title: "예외 발생", message: "\(error.localizedDescription) 이 발생했습니다."))
        }
        
    }
    
    func getDocumentfromCoreData () {
        do {
            try context.fetch(request).publisher.flatMap { data in
                Publishers.Sequence(sequence: [data])
            }
            .collect()
            .eraseToAnyPublisher()
            .assign(to: \.wishDocument, on: self)
            .store(in: &cancellables)
        } catch {
            routerSubject.send(Router.alert(title: "예외 발생", message: "\(error.localizedDescription) 이 발생했습니다."))
        }
        
    }
    
    func getSpecificData (title: String) {
        let predicateRequest: NSFetchRequest<WishListModel> = WishListModel.fetchRequest()
        let predicate = NSPredicate(format: "title == %@", title)
        predicateRequest.predicate = predicate
        
        do {
            try context.fetch(predicateRequest).publisher.flatMap { data in
                Publishers.Sequence(sequence: [data])
            }
            .collect()
            .eraseToAnyPublisher()
            .assign(to: \.wishDocument, on: self)
            .store(in: &cancellables)
        } catch {
            routerSubject.send(Router.alert(title: "예외 발생", message: "\(error.localizedDescription) 이 발생했습니다."))
        }
    }
    
    func checkDuplicate (title: String) -> Bool {
        
        var flag = false
        getSpecificData(title: title)
        
        if wishDocument.isEmpty {
            flag = false
        } else {
            flag = true
        }
        return flag
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
            try context.delete(selectedCell)
            try context.save()
        } catch {
            routerSubject.send(Router.alert(title: "예외 발생", message: "\(error.localizedDescription) 이 발생했습니다."))
        }
        
    }
}

