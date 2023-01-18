//
//  ProjectManager - ListViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class ListViewController: UIViewController {
    
    typealias Text = Constant.Text
    typealias Style = Constant.Style
    typealias Color = Constant.Color

    var viewModel: ListViewModel?
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = Color.listViewSpacing
        stackView.axis = .horizontal
        stackView.spacing = Style.stackViewSpacing
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()
    
    private let toDoHeaderView = ListHeaderView(title: Text.toDoTitle,
                                                frame: .zero)
    private let doingHeaderView = ListHeaderView(title: Text.doingTitle,
                                                frame: .zero)
    private let doneHeaderView = ListHeaderView(title: Text.doneTitle,
                                                frame: .zero)
    private lazy var toDoListView: ListView = {
        let listView = ListView(state: .toDo, frame: .zero, style: .plain)
        listView.delegate = self
        listView.dataSource = self
        listView.register(ListCell.self,
                           forCellReuseIdentifier: ListCell.reuseIdentifier)
        listView.separatorStyle = .none
        
        return listView
    }()
    private lazy var doingListView: ListView = {
        let listView = ListView(state: .doing, frame: .zero, style: .plain)
        listView.delegate = self
        listView.dataSource = self
        listView.register(ListCell.self,
                           forCellReuseIdentifier: ListCell.reuseIdentifier)
        listView.separatorStyle = .none
        
        return listView
    }()
    private lazy var doneListView: ListView = {
        let listView = ListView(state: .done, frame: .zero, style: .plain)
        listView.delegate = self
        listView.dataSource = self
        listView.register(ListCell.self,
                           forCellReuseIdentifier: ListCell.reuseIdentifier)
        listView.separatorStyle = .none
        
        return listView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUIComponent()
    }

    private func configureUIComponent() {
        configureNavigationBar()
        configureViewHierarchy()
        configureLayoutConstraint()
        configureHeaderView()
        configureHandler()
    }

    private func configureNavigationBar() {
        navigationItem.title = Text.navigationTitle
        navigationItem.rightBarButtonItem = addPlanButton()
    }

    private func configureViewHierarchy() {
        for (header, listView) in zip([toDoHeaderView, doingHeaderView, doneHeaderView],
                                      [toDoListView, doingListView, doneListView]) {
            let stackView = UIStackView(arrangedSubviews: [header, listView])
            stackView.backgroundColor = Color.listBackground
            stackView.axis = .vertical
            stackView.alignment = .fill
            stackView.distribution = .fill
            self.stackView.addArrangedSubview(stackView)
        }
        view.addSubview(stackView)
    }

    private func configureLayoutConstraint() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                              constant: Style.stackViewBottomInset),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }

    private func presentDetailView(viewModel: DetailViewModel) {
        let projectViewController = PlanViewController()
        projectViewController.viewModel = viewModel
        let navigationController = UINavigationController(rootViewController: projectViewController)
        navigationController.modalPresentationStyle = .formSheet
        present(navigationController, animated: true)
    }
    
    private func configureHeaderView() {
        toDoHeaderView.setCount(number: viewModel?.fetchCount(of: .toDo))
        doingHeaderView.setCount(number: viewModel?.fetchCount(of: .doing))
        doneHeaderView.setCount(number: viewModel?.fetchCount(of: .done))
    }
    
    private func configureHandler() {
        viewModel?.bindToDoList() { list in
            self.toDoListView.reloadData()
            self.toDoHeaderView.setCount(number: list.count)
        }
        viewModel?.bindDoingList() { list in
            self.doingListView.reloadData()
            self.doingHeaderView.setCount(number: list.count)
        }
        viewModel?.bindDoneList() { list in
            self.doneListView.reloadData()
            self.doneHeaderView.setCount(number: list.count)
        }
    }

    private func addPlanAction() -> UIAction {
        let action = UIAction { _ in
            let useCase = DefaultDetailUseCase(project: Project())
            self.presentDetailView(viewModel: DetailViewModel(detailUseCase: useCase))
        }

        return action
    }

    private func addPlanButton() -> UIBarButtonItem {
        let button = UIBarButtonItem(systemItem: .add, primaryAction: addPlanAction())

        return button
    }
}

extension ListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let listView = tableView as? ListView,
              let count = viewModel?.fetchCount(of: listView.state) else {
            return .zero
        }

        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cellType: ListCell.self, for: indexPath)
        guard let listView = tableView as? ListView,
              let list = viewModel?.fetchList(of: listView.state) else {
                  return cell
              }
        let project = list[indexPath.item]
        guard let texts = viewModel?.convertToText(from: project) else {
            return cell
        }
        switch listView.state {
        case .done:
            cell.configure(title: texts.title,
                           description: texts.description,
                           deadline: texts.deadline)
        default:
            cell.configure(title: texts.title,
                           description: texts.description,
                           deadline: texts.deadline,
                           isOverDue: project.deadline.isOverdue)
        }

        return cell
    }
}

extension ListViewController: UITableViewDelegate { }
