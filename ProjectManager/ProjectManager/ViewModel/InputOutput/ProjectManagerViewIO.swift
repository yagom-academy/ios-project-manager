//
//  ProjectManagerViewOutput.swift
//  ProjectManager
//
//  Created by Finnn on 2022/09/18.
//

import RxSwift
import UIKit

// MARK: - ProjectManager View <-> ProjectManager ViewModel (1 : 1)

struct ProjectManagerViewInput {
    var doneAction: Observable<Todo?>?
}

struct ProjectManagerViewOutput {
    var allTodoList: Observable<[Todo]>?
    var errorAlertContoller: Observable<UIAlertController>?
}
