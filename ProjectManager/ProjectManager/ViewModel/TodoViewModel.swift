//
//  TodoViewModel.swift
//  ProjectManager
//
//  Created by 리지 on 2023/05/17.
//

protocol TodoViewDelegate: AnyObject {
    func dismiss()
}

final class TodoViewModel {
    weak var delegate: TodoViewDelegate?
    
    func dismiss() {
        delegate?.dismiss()
    }
}
