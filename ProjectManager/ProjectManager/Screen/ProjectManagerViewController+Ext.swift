//
//  NewTodoFormDelegate+Ext.swift
//  ProjectManager
//
//  Created by kio on 2021/07/06.
//

import UIKit

extension TodoListCell: ProjectManagerDelegate {
    func dataPassing(text: String) {
        titleLabel.text = text
        descriptionLabel.text = text
    }
}
