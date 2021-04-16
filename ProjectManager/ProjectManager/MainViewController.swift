import UIKit

class MainViewController: UIViewController {
    private var todoCollectionView: UICollectionView!
    private var doingCollectionView: UICollectionView!
    private var doneCollectionView: UICollectionView!
    
    private var todoDataSource: UICollectionViewDiffableDataSource<HeaderItem, Item>!
    private var doingDataSource: UICollectionViewDiffableDataSource<HeaderItem, Item>!
    private var doneDataSource: UICollectionViewDiffableDataSource<HeaderItem, Item>!
    
    private var todoSnapshot = NSDiffableDataSourceSnapshot<HeaderItem, Item>()
    
    private var todoHeaderItem = [
        HeaderItem(title: "todo", items: [
            Item(title: "나는 최고다.", description: "정말 최고다.", date: "2021-01-01"),
            Item(title: "너는 최고다.", description: "너무 최고다.", date: "2021-01-01"),
            Item(title: "우리는 최고다.", description: "진짜 최고다.", date: "2021-01-01"),
        ])
    ]
    
    private var doingHeaderItem = [
        HeaderItem(title: "doing", items: [
            Item(title: "나는 최고다.", description: "정말 최고다.", date: "2021-01-01"),
            Item(title: "너는 최고다.", description: "너무 최고다.", date: "2021-01-01"),
            Item(title: "우리는 최고다.", description: "진짜 최고다.", date: "2021-01-01"),
            Item(title: "전설의 시작.", description: "CollectionView List Configuration 많이 사랑해주세요~", date: "2021-01-01"),
        ])
    ]

    private var doneHeaderItem = [
        HeaderItem(title: "done", items: [
            Item(title: "나는 최고다.", description: "정말 최고다.", date: "2021-01-01"),
            Item(title: "너는 최고다.", description: "너무 최고다.", date: "2021-01-01"),
            Item(title: "우리는 최고다.", description: "진짜 최고다.", date: "2021-01-01"),
            Item(title: "Let's get it!.", description: "zdo", date: "2021-01-01"),
            Item(title: "Lin step1이 많이 늦었습니다.😅", description: "😎", date: "2021-01-01"),
        ])
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        configureNavigationBar()
        configureCollectionView()
        configureDataSource()
        configureGesture()
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "Project Manager"
        
        let barButtonItem = UIBarButtonItem(systemItem: .add)
        barButtonItem.target = self
        barButtonItem.action = #selector(showMemoInsertView)
        navigationItem.setRightBarButton(barButtonItem, animated: true)
    }
    
    @objc private func showMemoInsertView() {
        let memoInsertViewController = MemoInsertViewController()
        memoInsertViewController.delegate = self
        let navigationController = UINavigationController(rootViewController: memoInsertViewController)
        present(navigationController, animated: true)
    }
    
    private func configureGesture() {
        let todoGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleTodoCollectionViewLongPressGesture))
        todoCollectionView.addGestureRecognizer(todoGesture)
        
        let doingGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleDoingCollectionViewLongPressGesture))
        doingCollectionView.addGestureRecognizer(doingGesture)
        
        let doneGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleDoneCollectionViewLongPressGesture))
        doneCollectionView.addGestureRecognizer(doneGesture)
    }
    
    @objc private func handleTodoCollectionViewLongPressGesture(_ gesture: UILongPressGestureRecognizer) {
        switch gesture.state {
        case .began:
            guard let targetIndexPath = todoCollectionView.indexPathForItem(at: gesture.location(in: todoCollectionView)) else {
                return
            }
            todoCollectionView.beginInteractiveMovementForItem(at: targetIndexPath)
        case .changed:
            todoCollectionView.updateInteractiveMovementTargetPosition(gesture.location(in: todoCollectionView))
        case .ended:
            todoCollectionView.endInteractiveMovement()
        default:
            todoCollectionView.cancelInteractiveMovement()
        }
    }
    
    @objc private func handleDoingCollectionViewLongPressGesture(_ gesture: UILongPressGestureRecognizer) {
        switch gesture.state {
        case .began:
            guard let targetIndexPath = doingCollectionView.indexPathForItem(at: gesture.location(in: doingCollectionView)) else {
                return
            }
            doingCollectionView.beginInteractiveMovementForItem(at: targetIndexPath)
        case .changed:
            doingCollectionView.updateInteractiveMovementTargetPosition(gesture.location(in: doingCollectionView))
        case .ended:
            doingCollectionView.endInteractiveMovement()
        default:
            doingCollectionView.cancelInteractiveMovement()
        }
    }
    
    @objc private func handleDoneCollectionViewLongPressGesture(_ gesture: UILongPressGestureRecognizer) {
        switch gesture.state {
        case .began:
            guard let targetIndexPath = doneCollectionView.indexPathForItem(at: gesture.location(in: doneCollectionView)) else {
                return
            }
            doneCollectionView.beginInteractiveMovementForItem(at: targetIndexPath)
        case .changed:
            doneCollectionView.updateInteractiveMovementTargetPosition(gesture.location(in: doneCollectionView))
        case .ended:
            doneCollectionView.endInteractiveMovement()
        default:
            doneCollectionView.cancelInteractiveMovement()
        }
    }
}

extension MainViewController {
    private func createLayout() -> UICollectionViewLayout {
        var config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        config.headerMode = .supplementary
        return UICollectionViewCompositionalLayout.list(using: config)
    }
    
    private func configureCollectionView() {
        todoCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        view.addSubview(todoCollectionView)
        
        todoCollectionView.translatesAutoresizingMaskIntoConstraints = false
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            todoCollectionView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            todoCollectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            todoCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            todoCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1 / 3),
        ])
        
        doingCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        view.addSubview(doingCollectionView)
        doingCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            doingCollectionView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            doingCollectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            doingCollectionView.leadingAnchor.constraint(equalTo: todoCollectionView.trailingAnchor),
            doingCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1 / 3),
        ])
        
        doneCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        view.addSubview(doneCollectionView)
        doneCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            doneCollectionView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            doneCollectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            doneCollectionView.leadingAnchor.constraint(equalTo: doingCollectionView.trailingAnchor),
            doneCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension MainViewController {
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<MemoCell, Item> { (cell, indexPath, item) in
            cell.updateWithItem(item)
        }
        
        let todoHeaderCellRegistration = UICollectionView.SupplementaryRegistration<MemoHeaderCell>(elementKind: "TODO") { [unowned self] (supplementaryView, string, indexPath) in
            supplementaryView.updateWithHeaderItem("TODO", todoHeaderItem.first?.items.count ?? 0)
        }
        
        let doingHeaderCellRegistration = UICollectionView.SupplementaryRegistration<MemoHeaderCell>(elementKind: "DOING") { [unowned self] (supplementaryView, string, indexPath) in
            supplementaryView.updateWithHeaderItem("DOING", doingHeaderItem.first?.items.count ?? 0)
        }
        
        let doneHeaderCellRegistration = UICollectionView.SupplementaryRegistration<MemoHeaderCell>(elementKind: "DONE") { [unowned self] (supplementaryView, string, indexPath) in
            supplementaryView.updateWithHeaderItem("DONE", doneHeaderItem.first?.items.count ?? 0)
        }
        
        todoDataSource = UICollectionViewDiffableDataSource<HeaderItem, Item>(collectionView: todoCollectionView) {
            (collectionView, indexPath, item) -> UICollectionViewCell? in
            collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        }
        
        todoDataSource.supplementaryViewProvider = { (supplementaryView, elementKind, indexPath) in
            self.todoCollectionView.dequeueConfiguredReusableSupplementary(using: todoHeaderCellRegistration, for: indexPath)
        }
        todoDataSource.reorderingHandlers.canReorderItem = { item in
            true
        }
        
        doingDataSource = UICollectionViewDiffableDataSource<HeaderItem, Item>(collectionView: doingCollectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
            collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        })
        
        doingDataSource.supplementaryViewProvider = { (supplementaryView, elementKind, indexPath) in
            self.todoCollectionView.dequeueConfiguredReusableSupplementary(using: doingHeaderCellRegistration, for: indexPath)
        }
        doingDataSource.reorderingHandlers.canReorderItem = { item in
            true
        }
        
        doneDataSource = UICollectionViewDiffableDataSource<HeaderItem, Item>(collectionView: doneCollectionView, cellProvider: { (collectioView, indexPath, item) -> UICollectionViewCell? in
            collectioView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        })
        
        doneDataSource.supplementaryViewProvider = { (supplementaryView, elementKind, indexPath) in
            self.todoCollectionView.dequeueConfiguredReusableSupplementary(using: doneHeaderCellRegistration, for: indexPath)
        }
        doneDataSource.reorderingHandlers.canReorderItem = { item in
            true
        }
        
        todoSnapshot.appendSections(todoHeaderItem)
        for headerItem in todoHeaderItem {
            todoSnapshot.appendItems(headerItem.items, toSection: headerItem)
        }
        todoDataSource.apply(todoSnapshot)
        
        var doingSnapshot = NSDiffableDataSourceSnapshot<HeaderItem, Item>()
        doingSnapshot.appendSections(doingHeaderItem)
        for headerItem in doingHeaderItem {
            doingSnapshot.appendItems(headerItem.items, toSection: headerItem)
        }
        doingDataSource.apply(doingSnapshot)
        
        var doneSnapshot = NSDiffableDataSourceSnapshot<HeaderItem, Item>()
        doneSnapshot.appendSections(doneHeaderItem)
        for headerItem in doneHeaderItem {
            doneSnapshot.appendItems(headerItem.items, toSection: headerItem)
        }
        doneDataSource.apply(doneSnapshot)
    }
}

extension MainViewController: MemoItemDelegate {
    func addMemo(_ item: Item) {
        todoSnapshot.deleteSections(todoHeaderItem)
        
        todoHeaderItem[0].items.append(item)
        
        todoSnapshot.appendSections(todoHeaderItem)
        for headerItem in todoHeaderItem {
            todoSnapshot.appendItems(headerItem.items, toSection: headerItem)
        }
        todoDataSource.apply(todoSnapshot)
    }
}

