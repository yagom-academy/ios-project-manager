//
//  Model.swift
//  ProjectManager
//
//  Created by Do Yi Lee on 2021/10/31.
//

import Foundation
import SwiftUI

protocol ViewModelAble {
    associatedtype Input
    associatedtype Output
    associatedtype Dependency
    
    var input: Input { get }
    var output: Output { get }
    var dependency: Dependency { get }
}

//MARK: -Model
struct ListsManager {
    private(set) var lists: [List]
    
    mutating func append(list: List) {
        self.lists.append(list)
    }
    
    init() {
        self.lists = [List(title: "제목을 써주세요",
                           description: "해야하는 목록을 작성 해 볼까요?",
                           date: Date(),
                           state: .ToDo)]
    }
    
    struct List {
        var title: String
        var description: String
        var date: Date
        var state: ListState
        
        enum ListState {
            case ToDo
            case Doing
            case Done
        }
    }
}
