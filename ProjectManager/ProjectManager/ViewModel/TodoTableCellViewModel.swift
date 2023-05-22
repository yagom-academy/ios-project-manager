//
//  TodoTableCellViewModel.swift
//  ProjectManager
//
//  Created by 리지 on 2023/05/22.
//

import UIKit
import Combine

final class TodoTableCellViewModel: ObservableObject {
    @Published private(set) var item: TodoItem
    
    init(item: TodoItem) {
        self.item = item
    }
    
    func convertDate(of date: Date) -> String {
        return DateFormatManager.shared.convertToFormattedDate(of: date)
    }
    
    func selectColor(_ date: Date) -> UIColor {
        let result = DateFormatManager.shared.compareDate(from: date)
        
        switch result {
        case .past:
            return UIColor.red
        default:
            return UIColor.black
        }
    }
}
