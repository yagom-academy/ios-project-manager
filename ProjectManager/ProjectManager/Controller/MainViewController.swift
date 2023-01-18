//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class MainViewController: UIViewController {
    let sectionHeaderIdentifier: String = "sectionHeaderIdentifier"

    // 왜 lazy로 선언해야하며, target: self를 쓸때 경고가 발생하는가
    private lazy var navigationBar: UINavigationBar = {
        let navigationBar = UINavigationBar()
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        let navigationItem = UINavigationItem(title: "Project Manager")
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewTodo))
        navigationBar.items = [navigationItem]
        navigationBar.barTintColor = UIColor.systemGray6
        return navigationBar
    }()

    private let todoTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.text = "TODO"
        return label
    }()

    private let todoCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.text = "0"
        label.widthAnchor.constraint(equalTo: label.heightAnchor).isActive = true
        label.layer.masksToBounds = true
        label.backgroundColor = .black
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()

    private let todoEmptyView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let todoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.backgroundColor = .systemGray5
        stackView.spacing = 8
        return stackView
    }()

    private let doingTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.text = "DOING"
        return label
    }()

    private let doingCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.text = "0"
        label.widthAnchor.constraint(equalTo: label.heightAnchor).isActive = true
        label.layer.masksToBounds = true
        label.backgroundColor = .black
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()

    private let doingEmptyView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let doingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.backgroundColor = .systemGray5
        stackView.spacing = 8
        return stackView
    }()

    private let doneTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.text = "DONE"
        return label
    }()

    private let doneCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.text = "0"
        label.widthAnchor.constraint(equalTo: label.heightAnchor).isActive = true
        label.layer.masksToBounds = true
        label.backgroundColor = .black
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()

    private let doneEmptyView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let doneStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.backgroundColor = .systemGray5
        stackView.spacing = 8
        return stackView
    }()

    private let firstDividingLineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.frame.size.width = 8
        view.backgroundColor = .systemGray3
        return view
    }()

    private let secondDividingLineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.frame.size.width = 8
        view.backgroundColor = .systemGray3
        return view
    }()

    private lazy var todoCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout(kind: .todoCollectionView))
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemGray5
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: sectionHeaderIdentifier)
        return collectionView
    }()

    private lazy var doingCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout(kind: .doingCollectionView))
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemGray5
        collectionView.allowsSelection = false
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: sectionHeaderIdentifier)
        return collectionView
    }()

    private lazy var doneCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout(kind: .doneCollectionView))
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemGray5
        collectionView.allowsSelection = false
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: sectionHeaderIdentifier)
        return collectionView
    }()

    private var todoLists: [TodoModel] = [
        TodoModel(title: "hi", body: "bodyasldjaksdjfl;aksdfkadskflasdklfasldkfadkakdakfakfalkdakdfakdfakdlkjfakdjf;lakjfkldajsfkjadkfjakdjflaasdfasfasdfasdasdfasdfasfdasdfaf", date: "2023. 01. 17"),
        TodoModel(title: "bye", body: "dd", date: "2023. 01. 17"),
        TodoModel(title: "asdf", body: "ffff", date: "2023. 01. 18"),
        TodoModel(title: "ffff", body: "ffff", date: "2023. 01. 19")
    ]

    private var doingLists: [TodoModel] = [
        TodoModel(title: "doing", body: "bodyasldjaksdjfl;aksdfkadskflasdklfasldkfadkakdakfakfalkdakdfakdfakdlkjfakdjf;lakjfkldajsfkjadkfjakdjflaasdfasfasdfasdasdfasdfasfdasdfaf", date: "2023. 02. 19"),
        TodoModel(title: "dodo", body: "dd", date: "2022. 01. 19")
    ]

    private var doneLists: [TodoModel] = [
        TodoModel(title: "done", body: "bodyasldjaksdjfl;aksdfkadskflasdklfasldkfadkakdakfakfalkdakdfakdfakd", date: "2023. 01. 11"),
        TodoModel(title: "done", body: "ddne", date: "2022. 12. 19"),
        TodoModel(title: "done", body: "ddne", date: "2023. 01. 19"),
        TodoModel(title: "done", body: "ddne", date: "2023. 01. 19")
    ]

    private var todoDataSource: UICollectionViewDiffableDataSource<Int, TodoModel.ID>?
    private var doingDataSource: UICollectionViewDiffableDataSource<Int, TodoModel.ID>?
    private var doneDataSource: UICollectionViewDiffableDataSource<Int, TodoModel.ID>?
    private var currentLongPressedCell: UICollectionViewCell?

    init() {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .systemGray3
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(navigationBar)
        view.addSubview(todoCollectionView)
        view.addSubview(doingCollectionView)
        view.addSubview(doneCollectionView)
        view.addSubview(todoStackView)
        view.addSubview(doingStackView)
        view.addSubview(doneStackView)
        view.addSubview(firstDividingLineView)
        view.addSubview(secondDividingLineView)

        todoCollectionView.delegate = self
        setUpLongGestureRecognizerOnCollection()
        configureTodoDataSource()
        configureDoingDataSource()
        configureDoneDataSource()
        configureSectionHeader()
        updateTodoSnapshot()
        updateDoingSnapshot()
        updateDoneSnapshot()
        updateListCounts()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        todoCountLabel.layer.cornerRadius = todoCountLabel.frame.width / 2
        doingCountLabel.layer.cornerRadius = doingCountLabel.frame.width / 2
        doneCountLabel.layer.cornerRadius = doneCountLabel.frame.width / 2
        let stackViewWidthSize = (UIScreen.main.bounds.size.width - 16) / 3
        todoStackView.widthAnchor.constraint(equalToConstant: stackViewWidthSize).isActive = true
        doingStackView.widthAnchor.constraint(equalToConstant: stackViewWidthSize).isActive = true
        firstDividingLineView.widthAnchor.constraint(equalToConstant: 8).isActive = true
        secondDividingLineView.widthAnchor.constraint(equalToConstant: 8).isActive = true
        todoEmptyView.setContentCompressionResistancePriority(.defaultHigh + 1, for: .horizontal)
        doingEmptyView.setContentCompressionResistancePriority(.defaultHigh + 1, for: .horizontal)
        doneEmptyView.setContentCompressionResistancePriority(.defaultHigh + 1, for: .horizontal)
        configureSubViews()
    }
    private func configureSubViews() {
        todoStackView.addArrangedSubview(todoTitleLabel)
        todoStackView.addArrangedSubview(todoCountLabel)
        todoStackView.addArrangedSubview(todoEmptyView)
        doingStackView.addArrangedSubview(doingTitleLabel)
        doingStackView.addArrangedSubview(doingCountLabel)
        doingStackView.addArrangedSubview(doingEmptyView)
        doneStackView.addArrangedSubview(doneTitleLabel)
        doneStackView.addArrangedSubview(doneCountLabel)
        doneStackView.addArrangedSubview(doneEmptyView)

        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            todoStackView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            todoStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),

            todoCollectionView.topAnchor.constraint(equalTo: todoStackView.bottomAnchor),
            todoCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            todoCollectionView.trailingAnchor.constraint(equalTo: todoStackView.trailingAnchor),
            todoCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            firstDividingLineView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            firstDividingLineView.leadingAnchor.constraint(equalTo: todoStackView.trailingAnchor),
            firstDividingLineView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            doingStackView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            doingStackView.leadingAnchor.constraint(equalTo: firstDividingLineView.trailingAnchor),

            doingCollectionView.topAnchor.constraint(equalTo: doingStackView.bottomAnchor),
            doingCollectionView.leadingAnchor.constraint(equalTo: firstDividingLineView.trailingAnchor),
            doingCollectionView.trailingAnchor.constraint(equalTo: doingStackView.trailingAnchor),
            doingCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            secondDividingLineView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            secondDividingLineView.leadingAnchor.constraint(equalTo: doingStackView.trailingAnchor),
            secondDividingLineView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            doneStackView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            doneStackView.leadingAnchor.constraint(equalTo: secondDividingLineView.trailingAnchor),
            doneStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            doneCollectionView.topAnchor.constraint(equalTo: doneStackView.bottomAnchor),
            doneCollectionView.leadingAnchor.constraint(equalTo: secondDividingLineView.trailingAnchor),
            doneCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            doneCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func createCollectionViewLayout(kind: KindOfCollectionView) -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { [weak self] _, layoutEnviroment in
            var configuration = UICollectionLayoutListConfiguration(appearance: .grouped)
            configuration.headerMode = .supplementary
            switch kind {
            case .todoCollectionView:
                configuration.trailingSwipeActionsConfigurationProvider = self?.todoMakeSwipeActions(for:)
            case .doingCollectionView:
                configuration.trailingSwipeActionsConfigurationProvider = self?.doingMakeSwipeActions(for:)
            case .doneCollectionView:
                configuration.trailingSwipeActionsConfigurationProvider = self?.doneMakeSwipeActions(for:)
            }
            let section = NSCollectionLayoutSection.list(using: configuration, layoutEnvironment: layoutEnviroment)
            section.interGroupSpacing = 8
            return section
        }
        return layout
    }

    private func todoMakeSwipeActions(for indexPath: IndexPath?) -> UISwipeActionsConfiguration? {
        guard let indexPath = indexPath,
              let id = todoDataSource?.itemIdentifier(for: indexPath) else { return nil }
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] _, _, completion in
            self?.deleteTodoList(with: id)
            self?.updateTodoSnapshot()
            completion(false)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }

    private func doingMakeSwipeActions(for indexPath: IndexPath?) -> UISwipeActionsConfiguration? {
        guard let indexPath = indexPath,
              let id = doingDataSource?.itemIdentifier(for: indexPath) else { return nil }
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] _, _, completion in
            self?.deleteDoingList(with: id)
            self?.updateDoingSnapshot()
            completion(false)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }

    private func doneMakeSwipeActions(for indexPath: IndexPath?) -> UISwipeActionsConfiguration? {
        guard let indexPath = indexPath,
              let id = doneDataSource?.itemIdentifier(for: indexPath) else { return nil }
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] _, _, completion in
            self?.deleteDoneList(with: id)
            self?.updateDoneSnapshot()
            completion(false)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }

    private func deleteTodoList(with id: TodoModel.ID) {
        guard let index = todoLists.firstIndex(where: { todoModel in
            todoModel.id == id
        }) else { return }
        todoLists.remove(at: index)
    }

    private func deleteDoingList(with id: TodoModel.ID) {
        guard let index = doingLists.firstIndex(where: { todoModel in
            todoModel.id == id
        }) else { return }
        doingLists.remove(at: index)
    }

    private func deleteDoneList(with id: TodoModel.ID) {
        guard let index = doneLists.firstIndex(where: { todoModel in
            todoModel.id == id
        }) else { return }
        doneLists.remove(at: index)
    }

    private func configureSectionHeader() {
        let dataSources = [todoDataSource, doingDataSource, doneDataSource]

        for dataSource in dataSources {
            dataSource?.supplementaryViewProvider = { (collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? in
                if kind == UICollectionView.elementKindSectionHeader {
                    let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: self.sectionHeaderIdentifier, for: indexPath)
                    headerView.frame.size.height = 8
                    return headerView
                }
                return nil
            }
        }
    }

    private func configureTodoDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, TodoModel.ID> { [weak self] cell, _, itemIdentifier in
            var contentConfiguration = TodoContentView.Configutation()
            guard let todoModel = self?.todoLists.first(where: { todoModel in
                todoModel.id == itemIdentifier
            }) else {
                cell.contentConfiguration = contentConfiguration
                return
            }

            contentConfiguration.title = todoModel.title
            contentConfiguration.body = todoModel.body
            contentConfiguration.date = todoModel.date
            cell.contentConfiguration = contentConfiguration
        }

        todoDataSource = UICollectionViewDiffableDataSource<Int, TodoModel.ID>(collectionView: todoCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        })
    }

    private func configureDoingDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, TodoModel.ID> { [weak self] cell, _, itemIdentifier in
            var contentConfiguration = TodoContentView.Configutation()
            guard let todoModel = self?.doingLists.first(where: { todoModel in
                todoModel.id == itemIdentifier
            }) else {
                cell.contentConfiguration = contentConfiguration
                return
            }

            contentConfiguration.title = todoModel.title
            contentConfiguration.body = todoModel.body
            contentConfiguration.date = todoModel.date
            cell.contentConfiguration = contentConfiguration
        }

        doingDataSource = UICollectionViewDiffableDataSource<Int, TodoModel.ID>(collectionView: doingCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        })
    }

    private func configureDoneDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, TodoModel.ID> { [weak self] cell, _, itemIdentifier in
            var contentConfiguration = TodoContentView.Configutation()
            guard let todoModel = self?.doneLists.first(where: { todoModel in
                todoModel.id == itemIdentifier
            }) else {
                cell.contentConfiguration = contentConfiguration
                return
            }

            contentConfiguration.title = todoModel.title
            contentConfiguration.body = todoModel.body
            contentConfiguration.date = todoModel.date
            cell.contentConfiguration = contentConfiguration
        }

        doneDataSource = UICollectionViewDiffableDataSource<Int, TodoModel.ID>(collectionView: doneCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        })
    }

    private func updateTodoSnapshot() {
        var todoSnapshot = NSDiffableDataSourceSnapshot<Int, TodoModel.ID>()
        todoSnapshot.appendSections([0])
        todoSnapshot.appendItems(todoLists.map { $0.id }, toSection: 0)
        todoDataSource?.apply(todoSnapshot)
    }

    private func updateDoingSnapshot() {
        var doingSnapshot = NSDiffableDataSourceSnapshot<Int, TodoModel.ID>()
        doingSnapshot.appendSections([0])
        doingSnapshot.appendItems(doingLists.map { $0.id }, toSection: 0)
        doingDataSource?.apply(doingSnapshot)
    }

    private func updateDoneSnapshot() {
        var doneSnapshot = NSDiffableDataSourceSnapshot<Int, TodoModel.ID>()
        doneSnapshot.appendSections([0])
        doneSnapshot.appendItems(doneLists.map { $0.id }, toSection: 0)
        doneDataSource?.apply(doneSnapshot)
    }

    private func setUpLongGestureRecognizerOnCollection() {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gestureRecognizer:)))
        let longPressGesture2 = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gestureRecognizer:)))
        let longPressGesture3 = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gestureRecognizer:)))
        longPressGesture.minimumPressDuration = 0.5
        longPressGesture.delaysTouchesBegan = true
        longPressGesture2.minimumPressDuration = 0.5
        longPressGesture2.delaysTouchesBegan = true
        longPressGesture3.minimumPressDuration = 0.5
        longPressGesture3.delaysTouchesBegan = true
        todoCollectionView.addGestureRecognizer(longPressGesture)
        doingCollectionView.addGestureRecognizer(longPressGesture2)
        doneCollectionView.addGestureRecognizer(longPressGesture3)

    }

    private func showPopoverMenu(collectionView: UICollectionView, indexPath: IndexPath) {
        guard let cell = currentLongPressedCell else { return }
        UIView.animate(withDuration: 0.2) {
            cell.transform = .init(scaleX: 1, y: 1)
        }

        let cellPopOverViewController = CellPopoverViewController()
        cellPopOverViewController.modalPresentationStyle = .popover
        cellPopOverViewController.preferredContentSize = CGSize(width: view.bounds.width/5, height: view.bounds.height/8)
        cellPopOverViewController.cellPopoverViewDelegate = self
        switch collectionView {
        case todoCollectionView:
            cellPopOverViewController.cellToChange = .todo
        case doingCollectionView:
            cellPopOverViewController.cellToChange = .doing
        case doneCollectionView:
            cellPopOverViewController.cellToChange = .done
        default:
            break
        }
        cellPopOverViewController.cellIndex = indexPath.item
        guard let popover: UIPopoverPresentationController = cellPopOverViewController.popoverPresentationController else { return }
        popover.sourceView = cell
        popover.sourceRect = CGRect(x: ((cell.bounds.maxX)/2), y: (cell.bounds.maxY)/2, width: 0, height: 0)
        present(cellPopOverViewController, animated: true, completion: nil)
    }

    private func updateListCounts() {
        todoCountLabel.text = String(todoLists.count)
        doingCountLabel.text = String(doingLists.count)
        doneCountLabel.text = String(doneLists.count)
    }
}

// MARK: - Objc
extension MainViewController {
    @objc private func addNewTodo() {
        let detailViewController = DetailViewController()
        detailViewController.modalPresentationStyle = .formSheet
        detailViewController.detailViewDelegate = self
        present(detailViewController, animated: true)
    }

    @objc private func handleLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
        guard let collectionView = gestureRecognizer.view as? UICollectionView else { return }
        let location = gestureRecognizer.location(in: collectionView)
        guard let indexPath = collectionView.indexPathForItem(at: location) else { return }

        if gestureRecognizer.state == .began {
            UIView.animate(withDuration: 0.2) { [weak self] in
                guard let cell = collectionView.cellForItem(at: indexPath) else { return }
                self?.currentLongPressedCell = cell
                cell.transform = .init(scaleX: 0.95, y: 0.95)
            }
        }

        if gestureRecognizer.state == .ended {
            showPopoverMenu(collectionView: collectionView, indexPath: indexPath)
        }
    }
}

// MARK: - DetailViewControllerDelegate
extension MainViewController: DetailViewDelegate {
    func addTodo(todoModel: TodoModel) {
        todoLists.append(todoModel)
        updateTodoSnapshot()
    }

    func editTodo(todoModel: TodoModel, selectedItem: Int) {
        todoLists[selectedItem] = todoModel
        updateTodoSnapshot()
    }
}

// MARK: - CellPopoverViewControllerDelegate
extension MainViewController: CellPopoverViewDelegate {
    func moveToTodo(from: CellPopoverViewMode, cellIndex: Int) {
        switch from {
        case .todo:
            break
        case .doing:
            let data = doingLists[cellIndex]
            doingLists.remove(at: cellIndex)
            todoLists.append(data)
            updateDoingSnapshot()
            updateTodoSnapshot()
        case .done:
            let data = doneLists[cellIndex]
            doneLists.remove(at: cellIndex)
            todoLists.append(data)
            updateDoneSnapshot()
            updateTodoSnapshot()
        }
        updateListCounts()
    }

    func moveToDoing(from: CellPopoverViewMode, cellIndex: Int) {
        switch from {
        case .todo:
            let data = todoLists[cellIndex]
            todoLists.remove(at: cellIndex)
            doingLists.append(data)
            updateTodoSnapshot()
            updateDoingSnapshot()
        case .doing:
            return
        case .done:
            let data = doneLists[cellIndex]
            doneLists.remove(at: cellIndex)
            doingLists.append(data)
            updateDoneSnapshot()
            updateDoingSnapshot()
        }
        updateListCounts()
    }

    func moveToDone(from: CellPopoverViewMode, cellIndex: Int) {
        switch from {
        case .todo:
            let data = todoLists[cellIndex]
            todoLists.remove(at: cellIndex)
            doneLists.append(data)
            updateTodoSnapshot()
            updateDoneSnapshot()
        case .doing:
            let data = doingLists[cellIndex]
            doingLists.remove(at: cellIndex)
            doneLists.append(data)
            updateDoingSnapshot()
            updateDoneSnapshot()
        case .done:
            break
        }
        updateListCounts()
    }
}

// MARK: - UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView != todoCollectionView { return }
        let detailViewController = DetailViewController()
        detailViewController.modalPresentationStyle = .formSheet
        detailViewController.detailViewDelegate = self
        detailViewController.mode = .modify
        detailViewController.todo = todoLists[indexPath.item]
        detailViewController.selectedItem = indexPath.item
        present(detailViewController, animated: true)
    }
}
