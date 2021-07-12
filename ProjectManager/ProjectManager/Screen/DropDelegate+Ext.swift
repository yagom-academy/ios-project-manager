//
//  DropDelegate+Ext.swift
//  ProjectManager
//
//  Created by kio on 2021/07/08.
//

import UIKit
import MobileCoreServices

extension ProjectManagerViewController: UITableViewDropDelegate {
    
    /**
     view가 처리할 수 있는 Dragitem의 형식을 DropSession이 포함하고 있다는것을 보증
     */
    
    func tableView(_ tableView: UITableView, canHandle session: UIDropSession) -> Bool {
        return canHandle(session)
    }
    
    func canHandle(_ session: UIDropSession) -> Bool {
        print("Hi")
        return session.canLoadObjects(ofClass: CellData.self)
    }
    
    /**
     Drop이 이루어질때 어떤 반응을 할지랑 Tableview가 item을 받아 들였을때 어떤 행동을 할지 결정
     */
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        
        var dropProposal = UITableViewDropProposal(operation: .cancel)
        print(dropProposal)
        guard session.items.count == 1 else { return dropProposal }
        
        if tableView.hasActiveDrag {
            print("\(tableView) View has ActiveDrag")
            dropProposal = UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        } else {
            print("is Moving222")
            dropProposal = UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        }
        
        return dropProposal
    }
    /**
     dragitem에 포함되어 있는 데이터형식을 받아들이고 표현할 수 있는 유일한 기회. drop coordinator
     는 drop된 아이템을 받아들이게 하고, 받는 테이블뷰를 갱신시키고 optional animations결정한다.
     하나의 테이블 뷰 내에서의 이동은 DataSource의
     `tableView(_:moveRowAt:to:)` 메서드로 이루어진다.
     */
    
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        let destinationIndexPath: IndexPath
        
        let currentTableView = distinguishedTableView(currentTableView: tableView)
        
        if let indexPath = coordinator.destinationIndexPath {
            destinationIndexPath = indexPath
            print(destinationIndexPath)
        } else {
            print("else")
            let section = tableView.numberOfSections - 1
            let row = tableView.numberOfRows(inSection: section)
            destinationIndexPath = IndexPath(row: row , section: section)
        }
        
        coordinator.session.loadObjects(ofClass: CellData.self) { items in
            // Consume drag items.
            let stringItems = items as! [CellData]
            
            var indexPaths = [IndexPath]()
            for (index, item) in stringItems.enumerated() {
                let indexPath = IndexPath(row: destinationIndexPath.row + index, section: destinationIndexPath.section)
                
                self.addItem(currentTableView: tableView, item, at: indexPath.row)
                
                switch item.superViewType {
                case .todoTableView:
                    if self.todoTableViewData.contains(item) {
                        self.todoTableViewData.remove(at: item.sourceTableViewIndexPath!.row)
                        item.superViewType = currentTableView
                        item.sourceTableViewIndexPath = indexPath
                        
                        tableView.reloadData()
                    }
                case .doingTableView:
                    return
                case .doneTableView:
                    return
                }
                
                indexPaths.append(indexPath)
            }
            
            tableView.insertRows(at: indexPaths, with: .automatic)
            tableView.reloadData()
        }
    }
    
    func distinguishedTableView(currentTableView: UITableView) -> TableViewType {
        
        switch currentTableView {
        case toDoTableView:
            return .todoTableView
        case doingTableView:
            return .doingTableView
        default:
            return .doneTableView
        }
    }
    
    func addItem(currentTableView: UITableView, _ place: CellData, at index: Int) {
        switch currentTableView {
        case toDoTableView:
            todoTableViewData.insert(place, at: index)
        case doingTableView:
            doingTableViewData.insert(place, at: index)
        default:
            doneTableViewData.insert(place, at: index)
        }
    }
}
