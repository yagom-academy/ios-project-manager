//
//  EditViewModel.swift
//  ProjectManager
//
//  Created by Hamo, Wonbi on 2023/01/19.
//

import Foundation

final class EditViewModel {
    private var isEditing: Bool? {
        didSet {
            editingHandler?()
        }
    }
    
    var editingHandler: (() -> Void)?
    
    func changeEditMode(state: Bool) {
        isEditing = state
    }
}
