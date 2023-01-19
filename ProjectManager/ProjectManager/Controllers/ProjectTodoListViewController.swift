//
//  ProjectTodoListViewController.swift
//  ProjectManager
//
//  Created by junho lee on 2023/01/13.
//

import UIKit

final class ProjectTodoListViewController: UIViewController {

    // MARK: - Properties

    private var projectTodoListViewModel: ProjectTodoListViewModel
    private var collectionViews: [UICollectionView] = []
    private var dataSources: [DataSource] = []
    private var projectTodoHeaderViews: [ProjectTodoHeaderView] = []
    private var projectTodoStackViews: [UIStackView] = []
    private let stackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.spacing = Constants.defaultSpacing
        return stackView
    }()
    private var projectStateCount: Int {
        return projectTodoListViewModel.projectStateCount()
    }

    // MARK: - Configure

    init(projectTodoListViewModel: ProjectTodoListViewModel) {
        self.projectTodoListViewModel = projectTodoListViewModel
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = ProjectColor.listViewBackground.color
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationItem()
        configureSubviewsArray()
        configureCollectionViews()
        configureLongPressGestureRecognizerOnCollectionView()
        configureDataSources()
        configureHierarchy()
        bindProjectTodoListViewModel()
        updateSnapshot()
        updateProjectTodoHeaderViewText()
    }

    private func configureNavigationItem() {
        navigationItem.title = Constants.programName
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(didPressAddButton))
    }

    private func configureSubviewsArray() {
        (0..<projectStateCount).forEach { _ in
            projectTodoHeaderViews.append(ProjectTodoHeaderView())
            projectTodoStackViews.append({
                let stackView = UIStackView()
                stackView.translatesAutoresizingMaskIntoConstraints = false
                stackView.axis = .vertical
                stackView.spacing = Constants.defaultSpacing
                return stackView
            }())
        }
    }

    private func configureCollectionViews() {
        (0..<projectStateCount).forEach { index in
            let collectionView = UICollectionView(frame: .zero,
                                                  collectionViewLayout: makeCollectionViewLayout(for: index))
            collectionView.delegate = self
            collectionViews.append(collectionView)
        }
    }

    private func makeCollectionViewLayout(for index: Int) -> UICollectionViewCompositionalLayout {
        var configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        configuration.showsSeparators = false
        configuration.backgroundColor = ProjectColor.collectionViewBackground.color
        configuration.trailingSwipeActionsConfigurationProvider = makeSwipeActionsConfigurationProvider(for: index)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }

    private func makeSwipeActionsConfigurationProvider(for index: Int) -> (IndexPath) -> UISwipeActionsConfiguration? {
        return { [weak self] indexPath in
            guard let dataSource = self?.dataSources[index] as? DataSource,
                  let itemIdentifier = dataSource.itemIdentifier(for: indexPath),
                  let projectTodo = self?.projectTodoListViewModel.projectTodo(for: itemIdentifier) else { return nil }
            let deleteActionTitle = NSLocalizedString("Delete", comment: "Delete action title")
            let deleteAction = UIContextualAction(style: .destructive,
                                                  title: deleteActionTitle) { [weak self] _, _, completion in
                self?.projectTodoListViewModel.delete(for: projectTodo.id)
                completion(false)
            }
            return UISwipeActionsConfiguration(actions: [deleteAction])
        }
    }

    private func configureLongPressGestureRecognizerOnCollectionView() {
        collectionViews.forEach { collectionView in
            let gestureRecognizer = UILongPressGestureRecognizer(target: self,
                                                                 action: #selector(didLongPress))
            gestureRecognizer.minimumPressDuration = Constants.collectionViewMinimumPressDuration
            gestureRecognizer.delegate = self
            gestureRecognizer.delaysTouchesBegan = true
            collectionView.addGestureRecognizer(gestureRecognizer)
        }
    }

    private func configureDataSources() {
        collectionViews.forEach { collectionView in
            let cellRegistration = UICollectionView.CellRegistration(handler: makeCellRegistrationHandler)
            let dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
                return collectionView.dequeueConfiguredReusableCell(using: cellRegistration,
                                                                    for: indexPath,
                                                                    item: itemIdentifier)
            }
            dataSources.append(dataSource)
        }
    }

    private func configureHierarchy() {
        (0..<projectStateCount).forEach { index in
            projectTodoStackViews[index].addArrangedSubview(projectTodoHeaderViews[index])
            projectTodoStackViews[index].addArrangedSubview(collectionViews[index])
            stackView.addArrangedSubview(projectTodoStackViews[index])
        }
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func bindProjectTodoListViewModel() {
        projectTodoListViewModel.bind { [weak self] itemIDs in
            DispatchQueue.main.async {
                self?.updateSnapshot(itemIDs)
                self?.updateProjectTodoHeaderViewText()
            }
        }
    }
}

// MARK: - DataSource

extension ProjectTodoListViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, UUID>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, UUID>

    private func makeCellRegistrationHandler(cell: UICollectionViewCell, indexPath: IndexPath, id: UUID) {
        guard let projectTodo = projectTodoListViewModel.projectTodo(for: id) else { return }
        var configuration = ProjectTodoListContentView.Configuration()
        configuration.title = projectTodo.title
        configuration.description = projectTodo.description
        configuration.dueDateAttributedText = projectTodoListViewModel.createDueDateAttributedString(
            projectTodo.dueDate
        )
        cell.contentConfiguration = configuration
    }

    private func updateSnapshot(_ reloadItemIDs: [UUID] = []) {
        dataSources.enumerated().forEach { index, _ in
            updateSnapshot(for: index, reloadItemIDs: reloadItemIDs)
        }
    }

    private func updateSnapshot(for index: Int, reloadItemIDs: [UUID] = []) {
        var snapShot = Snapshot()
        snapShot.appendSections([0])
        let items = projectTodoListViewModel.projectTodoIDs(for: index)
        snapShot.appendItems(items)
        if reloadItemIDs.isEmpty == false {
            let reloadItems = Array(Set(reloadItemIDs).intersection(items))
            snapShot.reloadItems(reloadItems)
        }
        dataSources[index].apply(snapShot)
    }

    private func updateProjectTodoHeaderViewText() {
        projectTodoHeaderViews.enumerated().forEach { index, projectTodoHeaderView in
            guard let projectState = projectTodoListViewModel.projectState(for: index) else { return }
            let title = String(describing: projectState)
            let projectTodosCount = projectTodoListViewModel.projectTodosCount(for: index)
            let maxCount = Constants.itemCountLabelMaxCount
            let itemCountText = projectTodosCount > maxCount ? "\(maxCount)+" : "\(projectTodosCount)"
            projectTodoHeaderView.updateSubviewsText(title: title, itemCountText: itemCountText)
        }
    }
}

// MARK: - AddButton Action

extension ProjectTodoListViewController {
    @objc
    private func didPressAddButton(_ sender: UIBarButtonItem) {
        let newProjectTodoViewModel = ProjectTodoViewModel()
        let navigationTitle = String(describing: newProjectTodoViewModel.projectTodo.state)
        let projectTodoViewController = ProjectTodoViewController(navigationTitle: navigationTitle,
                                                                  projectTodoViewModel: newProjectTodoViewModel,
                                                                  isAdding: true) { [weak self] project in
            guard let project else { return }
            self?.projectTodoListViewModel.add(projectTodo: project)
            self?.dismiss(animated: true)
        }
        let navigationController = UINavigationController(rootViewController: projectTodoViewController)
        present(navigationController, animated: true)
    }
}

// MARK: - CollectionViewDelegate
extension ProjectTodoListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let dataSource = collectionView.dataSource as? DataSource,
              let itemIdentifier = dataSource.itemIdentifier(for: indexPath),
              let projectTodoViewModel = projectTodoListViewModel.projectTodoViewModel(for: itemIdentifier)
        else { return }
        let navigationTitle = String(describing: projectTodoViewModel.projectTodo.state)
        let projectTodoViewController = ProjectTodoViewController(navigationTitle: navigationTitle,
                                                                  projectTodoViewModel: projectTodoViewModel,
                                                                  isAdding: false) { [weak self] project in
            guard let project else { return }
            self?.projectTodoListViewModel.update(projectTodo: project)
            self?.dismiss(animated: true)
        }
        let navigationController = UINavigationController(rootViewController: projectTodoViewController)
        present(navigationController, animated: true)
    }
}

// MARK: - GestureRecognizerDelegate
extension ProjectTodoListViewController: UIGestureRecognizerDelegate {
    @objc
    private func didLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
        guard let collectionView = gestureRecognizer.view as? UICollectionView else { return }
        if gestureRecognizer.state == .began {
            let locationInGestureRecognizer = gestureRecognizer.location(in: gestureRecognizer.view)
            guard let indexPath = collectionView.indexPathForItem(at: locationInGestureRecognizer),
                  let dataSource = collectionView.dataSource as? DataSource,
                  let itemIdentifier = dataSource.itemIdentifier(for: indexPath),
                  let projectTodo = projectTodoListViewModel.projectTodo(for: itemIdentifier) else { return }
            let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            makeAlertActionsToMoveState(for: projectTodo).forEach(alertController.addAction(_:))
            guard let popover = alertController.popoverPresentationController else { return }
            popover.sourceView = view
            let locationInView = gestureRecognizer.location(in: self.view)
            popover.sourceRect = CGRect(x: locationInView.x, y: locationInView.y, width: 75, height: 75)
            present(alertController, animated: true)
        }
    }

    private func makeAlertActionsToMoveState(for projectTodo: ProjectTodo) -> [UIAlertAction] {
        var actions: [UIAlertAction] = []
        switch projectTodo.state {
        case .todo:
            actions.append(makeAlertActionToMoveState(for: projectTodo, toState: .doing))
            actions.append(makeAlertActionToMoveState(for: projectTodo, toState: .done))
        case .doing:
            actions.append(makeAlertActionToMoveState(for: projectTodo, toState: .todo))
            actions.append(makeAlertActionToMoveState(for: projectTodo, toState: .done))
        case .done:
            actions.append(makeAlertActionToMoveState(for: projectTodo, toState: .todo))
            actions.append(makeAlertActionToMoveState(for: projectTodo, toState: .doing))
        }
        return actions
    }

    private func makeAlertActionToMoveState(for projectTodo: ProjectTodo, toState: ProjectState) -> UIAlertAction {
        let actionTitle = "Move to " + String(describing: toState)
        let action = UIAlertAction(title: actionTitle, style: .default) { [weak self] _ in
            var modifiedProject = projectTodo
            modifiedProject.state = toState
            self?.projectTodoListViewModel.update(projectTodo: modifiedProject)
        }
        return action
    }
}
