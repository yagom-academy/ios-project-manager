//
//  CellViewIO.swift
//  ProjectManager
//
//  Created by Finnn on 2022/09/18.
//

import RxSwift
import UIKit

// MARK: - CollectionCell ViewModels <-> CollectionCell Views (1 : 1)

struct CellViewInput {
    var doneAction: Observable<(Todo?, IndexPath)>?
    var deleteAction: Observable<Int>?
    var moveToAction: Observable<(UITableView, UIGestureRecognizer)>?
}

struct CellViewOutput {
    var categorizedTodoList: Observable<[Todo]>?
    var moveToAlertController: Observable<UIAlertController>?
}
