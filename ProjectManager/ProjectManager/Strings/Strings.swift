//
//  Strings.swift
//  ProjectManager
//
//  Created by 리나 on 2021/03/10.
//

import Foundation

enum Strings {
    
    // MARK: - ViewController
    
    static let navigationTitle = "Project Manager"
    static let titlePlaceHolder = "Title"
    static let descriptionPlaceHolder = "이곳에 내용을 입력하세요."
    static let historyButton = "History"
    static let todoTitle = "TODO"
    static let doingTitle = "DOING"
    static let doneTitle = "DONE"
    
    // MARK: - Thing
    
    static let todoState = "todo"
    static let doingState = "doing"
    static let doneState = "done"
    
    // MARK: - CoreData
    
    static let thing = "Thing"
    static let projectManager = "ProjectManager"
    
    // MARK: - HistoryManager
    
    static let historyAddMessage = "Add '%@'"
    static let historyDeleteMessage = "Remove '%@' from %@"
    static let historyStartMoveMessage = "Move '%@' from %@"
    static let historyEndMoveMessage = "%@ to %@"
    
    // MARK: - NetworkManager
    
    static let baseURL = "https://pm-ggoglru.herokuapp.com/things"
    static let absoluteURL = "\(baseURL)/%d"
}
