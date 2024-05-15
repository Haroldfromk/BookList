//
//  WishVM.swift
//  Book
//
//  Created by Dongik Song on 5/7/24.
//

import Foundation
import CoreData
import Combine


class WishVM {
    
    private var cancellables = Set<AnyCancellable>()
    @Published var wishDocument = [WishListModel]()
    
    let coredataManager = CoredataManager()
    var routerSubject = PassthroughSubject<Router, Never>()
    
    func saveDatatoWish (data: Document) {
        coredataManager.saveWishDocumentToCoredata(data: data) { result in
            switch result {
            case .success(_):
                return
            case .failure(let error):
                self.routerSubject.send(Router.alert(title: "예외 발생", message: "\(error.localizedDescription) 이 발생했습니다."))
            }
        }
    }
    

    
    func checkDuplicate (title: String) -> Bool {
        
        var flag = false
        getSpecificDocument(title: title)
        
        if wishDocument.isEmpty {
            flag = false
        } else {
            flag = true
        }
        return flag
    }
    
    func getWholeDocument () {
        coredataManager.getWishDocumentfromCoreData().sink { complete in
            switch complete {
            case .finished:
                return
            case .failure(let error):
                self.routerSubject.send(Router.alert(title: "예외 발생", message: "\(error.localizedDescription) 이 발생했습니다."))
            }
        } receiveValue: { [weak self] model in
            self?.wishDocument = model
        }
        .store(in: &cancellables)
        
    }
    
    func getSpecificDocument (title: String) {
        coredataManager.getSpecificData(title: title).sink { complete in
            switch complete {
            case .finished:
                return
            case .failure(let error):
                self.routerSubject.send(Router.alert(title: "예외 발생", message: "\(error.localizedDescription) 이 발생했습니다."))
            }
        } receiveValue: { [weak self] model in
            self?.wishDocument = model
        }
        .store(in: &cancellables)
        
    }
    
    func deleteSelectedData(selectedCell: NSManagedObject) {
        coredataManager.deleteSpeificData(selectedCell: selectedCell) { result in
            switch result {
            case .success(_):
                return
            case .failure(let error):
                self.routerSubject.send(Router.alert(title: "예외 발생", message: "\(error.localizedDescription) 이 발생했습니다."))
            }
        }
    }
    
    func removeAllData () {
        coredataManager.deleteAllData { result in
            switch result {
            case .success(_):
                return
            case .failure(let error):
                self.routerSubject.send(Router.alert(title: "예외 발생", message: "\(error.localizedDescription) 이 발생했습니다."))
            }
        }
    }

}

