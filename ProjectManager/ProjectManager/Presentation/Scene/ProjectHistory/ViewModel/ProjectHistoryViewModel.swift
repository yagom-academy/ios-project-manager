//
//  ProjectHistoryViewModel.swift
//  ProjectManager
//
//  Created by Groot on 2022/09/30.
//

import UIKit

private enum Design {
    static let historySeparatedText = "\n"
}

struct ProjectHistoryViewModel {
    private var history = [String]()
    
    mutating func setHistory(_ history: [String]) {
        self.history = history.reversed()
    }
    
    func numberOfRow() -> Int {
        return history.count
    }
    
    func configureCellItem(cell: ProjectHistroyTableViewCell,
                           indexPath: IndexPath) {
        let texts = history[indexPath.row].components(separatedBy: Design.historySeparatedText)
        
        cell.setItems(history: texts.first,
                      date: texts.last)
    }
}
