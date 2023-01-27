//
//  Constants.swift
//  ProjectManager
//
//  Created by junho lee on 2023/01/14.
//

import Foundation

enum Constants {

    // MARK: View

    static let programName = "Project Manager"
    static let defaultSpacing = CGFloat(10)
    static let smallSpacing = CGFloat(5)
    static let numberOfDescriptionLines = 3
    static let borderWidth = CGFloat(0.1)
    static let descriptionTextViewMaxTextLength = 1000
    static let itemCountLabelMaxCount = 99
    static let collectionViewMinimumPressDuration = 0.5
    static let historyItemMaxCount = 7
    static let bottomViewHeight = CGFloat(50)

    // MARK: Database

    static let databaseCollection = "projectTodos"
    static let databaseStateField = "state"
    static let databaseTitleField = "title"
    static let databaseDescriptionField = "description"
    static let databaseDueDateField = "dueDate"
}
