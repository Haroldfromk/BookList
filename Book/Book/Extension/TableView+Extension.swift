//
//  TableView+Extension.swift
//  Book
//
//  Created by Dongik Song on 5/5/24.
//

import UIKit
import Kingfisher
import Combine



// MARK: - WishlistVC TableView Functions
extension WishlistViewController: UITableViewDelegate {
    
    func setUp() {
        bodyTableView.tableView.delegate = self
    }
    
    // SwipeAction For Delete Specific Cell
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteButton = UIContextualAction(style: .normal, title: "삭제") { (UIContextualAction, UIView, success: @escaping (Bool) -> Void)  in
            
            let alert = self.alertManager.makeAlert(title: "삭제하기", message: "정말 삭제하실 건가요?") { [unowned self] _ in
                wishVM.deleteSelectedData(selectedCell: wishVM.wishDocument[indexPath.row])
                wishVM.wishDocument.remove(at: indexPath.row)
                
            }
            success(true)
            self.present(alert,animated: false)            
        }
        
        deleteButton.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [deleteButton])
    }
    
}
