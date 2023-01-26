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
    private lazy var projectListHeaderStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [toDoHeaderView, doingHeaderView, doneHeaderView])
        stackView.backgroundColor = Color.listBackground
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    private lazy var projectListStackView: UIStackView  = {
        let stackView = UIStackView(arrangedSubviews: [projectListHeaderStackView, projectCollectionView])
        stackView.backgroundColor = Color.listViewSpacing
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private lazy var projectCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: createLayout())
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
        collectionView.register(ListCollectionViewCell.self,
                                forCellWithReuseIdentifier: ListCollectionViewCell.reuseIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    private var dataSource: UICollectionViewDiffableDataSource<State, Project>?
    
    private let toDoHeaderView = ListHeaderView(title: Text.toDoTitle,
                                                padding: 4,
                                                frame: .zero)
    private let doingHeaderView = ListHeaderView(title: Text.doingTitle,
                                                 padding: 4,
                                                 frame: .zero)
    private let doneHeaderView = ListHeaderView(title: Text.doneTitle,
                                                padding: 4,
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
        configureHandler()
        configureLongPressGestureRecognizer()
        configureDataSource()
    }
    
    private func configureUIComponent() {
        configureNavigationBar()
        configureViewHierarchy()
        configureLayoutConstraint()
        configureHeaderView()
    }
    
    private func configureNavigationBar() {
        navigationItem.title = Text.navigationTitle
        navigationItem.rightBarButtonItem = addProjectButton()
    }
    
    private func configureViewHierarchy() {
        view.addSubview(projectListStackView)
    }
    
    private func configureLayoutConstraint() {
        NSLayoutConstraint.activate([
            projectListStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            projectListStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            projectListStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                                         constant: Style.stackViewBottomInset),
            projectListStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    private func presentDetailView(viewModel: DetailViewModel) {
        let projectViewController = DetailViewController()
        projectViewController.viewModel = viewModel
        projectViewController.delegate = self
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
    
    private func configureLongPressGestureRecognizer() {
        [toDoListView, doingListView, doneListView].forEach { listView in
            let gestureRecognizer = UILongPressGestureRecognizer(target: self,
                                                                 action: #selector(tappedLongPress))
            gestureRecognizer.minimumPressDuration = 1
            gestureRecognizer.delegate = self
            gestureRecognizer.delaysTouchesBegan = true
            listView.addGestureRecognizer(gestureRecognizer)
        }
    }
    
    private func addPlanAction() -> UIAction {
        let action = UIAction { _ in
            let useCase = DefaultDetailUseCase(project: Project())
            self.presentDetailView(viewModel: DetailViewModel(detailUseCase: useCase, isNewProject: true))
        }
        
        return action
    }
    
    private func addProjectButton() -> UIBarButtonItem {
        let button = UIBarButtonItem(systemItem: .add,
                                     primaryAction: addPlanAction())
        
        return button
    }
    
    private func fetchProject(_ tableView: UITableView, index: Int) -> Project? {
        guard let listView = tableView as? ListView,
              let list = viewModel?.fetchList(of: listView.state) else {
            return nil
        }
        
        return list[index]
    }
    
    private func fetchProject(for indexPath: IndexPath) -> Project? {
        guard let list = fatchList(for: indexPath.section) else {
            return nil
        }
        
        return list[indexPath.item]
    }
    
    private func fatchList(for section: Int) -> [Project]? {
        switch section {
        case 0:
            return viewModel?.fetchList(of: .toDo)
        case 1:
            return viewModel?.fetchList(of: .doing)
        case 2:
            return viewModel?.fetchList(of: .done)
        default:
            return nil
        }
    }
    
    func createLayout() -> UICollectionViewLayout {
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.scrollDirection = .horizontal
        
        let layout = UICollectionViewCompositionalLayout(sectionProvider: {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(50)))
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 4)
            
            let containerGroupFractionalWidth = CGFloat(1.0/3.0)
            let containerGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(containerGroupFractionalWidth),
                                                   heightDimension: .estimated(50)),
                subitems: [item])
            let section = NSCollectionLayoutSection(group: containerGroup)
            section.orthogonalScrollingBehavior = .continuous
            
            return section
            
        }, configuration: config)
        return layout
    }
    
    func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<ListCollectionViewCell, Project> { (cell, indexPath, project) in
            cell.configure(title: project.title, description: project.description, deadline: project.deadline.localeFormattedText)
        }
        dataSource = UICollectionViewDiffableDataSource<State, Project>(collectionView: projectCollectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, project: Project) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: project)
        }
        
        configureSnapshot()
    }
    
    private func configureSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<State, Project>()
        snapshot.appendSections([.toDo, .doing, .done])
        snapshot.appendItems(viewModel?.fetchList(of: .toDo) ?? [],
                             toSection: .toDo)
        snapshot.appendItems(viewModel?.fetchList(of: .doing) ?? [],
                             toSection: .doing)
        snapshot.appendItems(viewModel?.fetchList(of: .done) ?? [],
                             toSection: .done)
        dataSource?.apply(snapshot)
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
        guard let project = fetchProject(tableView, index: indexPath.row),
              let texts = viewModel?.convertToText(from: project) else {
            return cell
        }
        
        switch project.state {
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

extension ListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let project = fetchProject(tableView, index: indexPath.row) else {
            return
        }
        
        let detailViewModel = DetailViewModel(detailUseCase: DefaultDetailUseCase(project: project))
        
        presentDetailView(viewModel: detailViewModel)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let project = fetchProject(tableView, index: indexPath.row) else {
            return nil
        }
        
        let deleteAction = UIContextualAction(style: .destructive,
                                              title: Text.deleteSwipeTitle) { (_, _, success) in
            self.viewModel?.removeProject(project)
            success(true)
        }
        
        deleteAction.image = UIImage(systemName: "trash")
        let swipeActionConfiguration = UISwipeActionsConfiguration(actions: [deleteAction])
        
        return swipeActionConfiguration
    }
}

extension ListViewController: UIGestureRecognizerDelegate {
    
    @objc func tappedLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
        guard let listView = gestureRecognizer.view as? ListView else {
            return
        }
        
        let tappedPoint = gestureRecognizer.location(in: listView)
        guard let indexPath = listView.indexPathForRow(at: tappedPoint) else {
            return
        }
        
        switch gestureRecognizer.state {
        case .began:
            presentPopoverMenu(listView: listView, indexPath: indexPath)
        default:
            return
        }
    }
    
    private func presentPopoverMenu(listView: ListView, indexPath: IndexPath) {
        guard let tappedCell = listView.cellForRow(at: indexPath),
              let project = viewModel?.fetchList(of: listView.state)[indexPath.row] else {
            return
        }
        
        let alertController = UIAlertController(title: nil,
                                                message: nil,
                                                preferredStyle: .actionSheet)
        
        
        let popoverController = alertController.popoverPresentationController
        popoverController?.sourceView = tappedCell
        popoverController?.sourceRect = tappedCell.bounds
        makeMoveActions(project: project).forEach {
            alertController.addAction($0)
        }
        
        present(alertController, animated: true)
    }
    
    private func makeMoveActions(project: Project) -> [UIAlertAction] {
        switch project.state {
        case .toDo:
            return [makeMoveAction(project: project, to: .doing),
                    makeMoveAction(project: project, to: .done)]
        case .doing:
            return [makeMoveAction(project: project, to: .toDo),
                    makeMoveAction(project: project, to: .done)]
        case .done:
            return [makeMoveAction(project: project, to: .toDo),
                    makeMoveAction(project: project, to: .doing)]
        }
    }
    
    private func makeMoveAction(project: Project, to state: State) -> UIAlertAction {
        var project = project
        let title: String
        switch state {
        case .toDo:
            project.state = .toDo
            title = Text.moveToToDo
        case .doing:
            project.state = .doing
            title = Text.moveToDoing
        case .done:
            project.state = .done
            title = Text.moveToDone
        }
        
        return UIAlertAction(title: title, style: .default) { [weak self] _ in
            self?.viewModel?.saveProject(project)
        }
    }
}

extension ListViewController: DetailProjectDelegate {
    
    func detailProject(willSave project: Project) {
        viewModel?.saveProject(project)
        projectCollectionView.reloadData()
    }
}

extension ListViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return viewModel?.fetchCount(of: .toDo) ?? .zero
        case 1:
            return viewModel?.fetchCount(of: .doing) ?? .zero
        case 2:
            return viewModel?.fetchCount(of: .done) ?? .zero
        default:
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCollectionViewCell.reuseIdentifier,
                                                            for: indexPath) as? ListCollectionViewCell,
              let project = fetchProject(for: indexPath),
              let texts = viewModel?.convertToText(from: project) else {
            return ListCollectionViewCell()
        }
        
        switch project.state {
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
