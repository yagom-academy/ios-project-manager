//
//  ProjectsManageView.swift
//  ProjectManager
//
//  Created by jin on 1/12/23.
//

import UIKit

class ProjectsManageView: UIView {

    enum Constant {
        static let stackViewSpacing = 10.0
    }

    // MARK: - Properties

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.spacing = Constant.stackViewSpacing
        stackView.backgroundColor = .systemGray4
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let todoView: ProjectListView = {
        let view = ProjectListView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let doingView: ProjectListView = {
        let view = ProjectListView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let doneView: ProjectListView = {
        let view = ProjectListView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    weak var todoViewDelegate: UITableViewDelegate? {
        get {
            return todoView.delegate
        }
        set {
            todoView.delegate = newValue
        }
    }

    weak var todoViewDataSource: UITableViewDataSource? {
        get {
            return todoView.dataSource
        }
        set {
            todoView.dataSource = newValue
        }
    }

    weak var doingViewDelegate: UITableViewDelegate? {
        get {
            return doingView.delegate
        }
        set {
            doingView.delegate = newValue
        }
    }

    weak var doingViewDataSource: UITableViewDataSource? {
        get {
            return doingView.dataSource
        }
        set {
            doingView.dataSource = newValue
        }
    }

    weak var doneViewDelegate: UITableViewDelegate? {
        get {
            return doneView.delegate
        }
        set {
            doneView.delegate = newValue
        }
    }

    weak var doneViewDataSource: UITableViewDataSource? {
        get {
            return doneView.dataSource
        }
        set {
            doneView.dataSource = newValue
        }
    }

    // MARK: - LifeCycles

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI settings

    private func configureUI() {
        self.backgroundColor = .white
        addSubview(stackView)
        stackView.addArrangedSubview(todoView)
        stackView.addArrangedSubview(doingView)
        stackView.addArrangedSubview(doneView)
        configureConstraints()
        todoView.setHeaderText(text: "TODO")
        doingView.setHeaderText(text: "DOING")
        doneView.setHeaderText(text: "DONE")
    }

    private func configureConstraints() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    func registerAllTableViews(cellClass: AnyClass?, forCellReuseIdentifier identifier: String) {
        todoView.register(cellClass: cellClass, forCellReuseIdentifier: identifier)
        doingView.register(cellClass: cellClass, forCellReuseIdentifier: identifier)
        doneView.register(cellClass: cellClass, forCellReuseIdentifier: identifier)
    }

    func dequeueReusableToDoCellWith(identifier: String) -> UITableViewCell? {
        return todoView.dequeueReusableCellWith(identifier: identifier)
    }

    func dequeueReusableDoingCellWith(identifier: String) -> UITableViewCell? {
        return doingView.dequeueReusableCellWith(identifier: identifier)
    }

    func dequeueToDoReusableDoneCellWith(identifier: String) -> UITableViewCell? {
        return doneView.dequeueReusableCellWith(identifier: identifier)
    }

    func fetchTodoTableView() -> UITableView {
        return todoView.fetchTableView()
    }

    func fetchDoingTableView() -> UITableView {
        return doingView.fetchTableView()
    }

    func fetchDoneTableView() -> UITableView {
        return doneView.fetchTableView()
    }
}
