//
//  ProjectManager - ProjectListViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class ProjectListViewController: UIViewController {
    // MARK: Properties
    private var projectList: [Project] = []
    private var todoList: [Project] {
        return projectList.filter{ $0.status == .todo }
    }

    private var doingList: [Project] {
        return projectList.filter{ $0.status == .doing }
    }

    private var doneList: [Project] {
        return projectList.filter{ $0.status == .done }
    }

    private let projectManager = ProjectManager()
    private lazy var projectListView: ProjectListView = {
        let view = ProjectListView(frame: view.bounds)
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}
