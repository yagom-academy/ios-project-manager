//
//  TodoModalViewModel.swift
//  ProjectManager
//
//  Created by YongHoon JJo on 2021/11/07.
//

import Foundation

enum TodoModalType {
    case new
    case detail
    case edit
}

class TodoFormViewModel: ObservableObject {
    var id = UUID()
    @Published var title: String
    @Published var dueDate: Date
    @Published var description: String
    @Published var modalType: TodoModalType
    
    var isDisabled: Bool {
        return modalType == .detail
    }
    
    init() {
        self.title = ""
        self.dueDate = Date()
        self.description = ""
        self.modalType = .new
    }
    
    init(_ todoVM: TodoViewModel) {
        self.id = todoVM.id
        self.title = todoVM.title
        self.dueDate = todoVM.dueDate
        self.description = todoVM.description
        self.modalType = .detail
    }
    
    func updateModalType(modalType: TodoModalType) {
        self.modalType = modalType
    }
}
