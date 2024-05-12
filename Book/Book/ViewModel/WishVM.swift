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
    
    func saveDatatoWish (data: Document) {
        CoredataManager.shared.saveWishDocumentToCoredata(data: data)
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
        CoredataManager.shared.getWishDocumentfromCoreData().sink { complete in
            switch complete {
            case .finished:
                return
            case .failure(_):
                return
            }
        } receiveValue: { [weak self] model in
            self?.wishDocument = model
        }
        .store(in: &cancellables)
        
    }
    
    func getSpecificDocument (title: String) {
        CoredataManager.shared.getSpecificData(title: title).sink { complete in
            switch complete {
            case .finished:
                return
            case .failure(_):
                return
            }
        } receiveValue: { [weak self] model in
            self?.wishDocument = model
        }
        .store(in: &cancellables)
        
    }
    
    func deleteSelectedData(selectedCell: NSManagedObject) {
        CoredataManager.shared.deleteSpeificData(selectedCell: selectedCell)
    }
    
    func removeAllData () {
        CoredataManager.shared.deleteAllData()
    }
    
}

