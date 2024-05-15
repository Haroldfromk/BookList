//
//  wishVM.swift
//  Book
//
//  Created by Dongik Song on 5/6/24.
//

import Foundation
import Combine

class RecentVM {
    
    
    @Published var recentDocument = [RecentModel]()
    
    private var cancellables = Set<AnyCancellable>()
    
    let coredataManager = CoredataManager()
    
    func saveDataToRecent (data: Document) {
        coredataManager.saveRecentDocumentToCoredata(data: data) { result in
            switch result {
            case .success(_):
                return
            case .failure(let error):
                self.routerSubject.send(Router.alert(title: "예외 발생", message: "\(error.localizedDescription) 이 발생했습니다."))
            }
        }
    }
    
    var routerSubject = PassthroughSubject<Router, Never>()
    
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
        coredataManager.getRecentDocumentfromCoreData().sink { complete in
            switch complete {
            case .finished:
                return
            case .failure(let error):
                self.routerSubject.send(Router.alert(title: "예외 발생", message: "\(error.localizedDescription) 이 발생했습니다."))
            }
        } receiveValue: {[weak self] model in
            self?.recentDocument = model
        }
        .store(in: &cancellables)
    }
    
    
}
