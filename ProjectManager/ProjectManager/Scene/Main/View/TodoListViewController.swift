//
//  BaseViewController.swift
//  ProjectManager
//
//  Created by LIMGAUI on 2022/07/07
//

import UIKit
import SwipeCellKit
import Combine

fileprivate enum Const {
  static let delete = "삭제"
  static let deleteImage = "delete"
}

final class TodoListViewController: UIViewController {
  typealias DataSource = UICollectionViewDiffableDataSource<Int, Todo>
  typealias SnapShot = NSDiffableDataSourceSnapshot<Int, Todo>
  
  private var todoDataSource: DataSource!
  private var doingDataSource: DataSource!
  private var doneDataSource: DataSource!
  
  private var bag = Set<AnyCancellable>()
  
  private let todoView = TodoListView(headerName: HeaderName.todo)
  private let doingView = TodoListView(headerName: HeaderName.doing)
  private let doneView = TodoListView(headerName: HeaderName.done)
  
  private let viewModel = TodoViewModel(storage: MemoryStorage.shared)
  
  private let mainStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.backgroundColor = .systemGray
    stackView.axis = .horizontal
    stackView.distribution = .fillEqually
    stackView.spacing = 10
    return stackView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpDelegate()
    configureUI()
    setDataSource()
    bind()
  }
  
  private func bind() {
    viewModel.toList
      .sink { [weak self] items in
        self?.applySnapShot(items, dataSource: self!.todoDataSource)
        self?.todoView.updateListCount(items.count)
      }
      .store(in: &bag)
    
    viewModel.doingList
      .sink { [weak self] items in
        self?.applySnapShot(items, dataSource: self!.doingDataSource)
        self?.doingView.updateListCount(items.count)
      }
      .store(in: &bag)
    
    viewModel.doneList
      .sink { [weak self] items in
        self?.applySnapShot(items, dataSource: self!.doneDataSource)
        self?.doneView.updateListCount(items.count)
      }
      .store(in: &bag)
  }
  
  private func setDataSource() {
    todoDataSource = makeDataSource(todoView.todoCollectionView)
    doingDataSource = makeDataSource(doingView.todoCollectionView)
    doneDataSource = makeDataSource(doneView.todoCollectionView)
  }
  
  private func applySnapShot(_ items: [Todo], dataSource: DataSource) {
    var snapshot = SnapShot()
    snapshot.appendSections([0])
    snapshot.appendItems(items)
    dataSource.apply(snapshot)
  }
  
  private func makeDataSource(_ collectionView: UICollectionView) -> DataSource {
    return DataSource(
      collectionView: collectionView) { collectionView, indexPath, item in
        let cell = collectionView.dequeueReusableCell(
          withReuseIdentifier: TodoCollectionViewCell.identifier,
          for: indexPath) as? TodoCollectionViewCell
        cell?.updatePropertiesValue(item)
        cell?.delegate = self
        cell?.longPress.addTarget(self, action: #selector(self.showMovingTodoSheet))
        return cell
      }
  }
  
  private func setUpDelegate() {
    [todoView, doingView, doneView].forEach { $0.todoCollectionView.delegate = self }
  }
  
  private func moveWriteTodo() {
    let writeViewController = WriteTodoViewController(viewModel: WriteViewModel())
    let writeNavigationController = UINavigationController(rootViewController: writeViewController)
    writeNavigationController.modalPresentationStyle = .pageSheet
    
    present(writeNavigationController, animated: true)
  }
  
  private func setNavigationBar() {
    navigationItem.rightBarButtonItem = UIBarButtonItem(
      systemItem: .add,
      primaryAction: UIAction(handler: { _ in
        self.moveWriteTodo()
      }))
  }
  
  private func configureUI() {
    setNavigationBar()
    
    view.backgroundColor = .systemGray5
    view.addSubview(mainStackView)
    mainStackView.addArrangedSubviews([todoView, doingView, doneView])
    
    NSLayoutConstraint.activate([
      mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
      mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
    ])
  }
}

// MARK: UICollectionViewDelegate

extension TodoListViewController: UICollectionViewDelegate {
  // MARK: Move EditViewController
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let todo = createTodoData(from: collectionView, indexPath: indexPath) else {
      return
    }
    
    let editViewController = createEditViewController(with: todo)
    present(editViewController, animated: true)
  }
  
  private func createEditViewController(with todo: Todo) -> UINavigationController {
    let editViewController = EditTodoViewController(viewModel: EditViewModel(item: todo))
    let editNavigationController = UINavigationController(rootViewController: editViewController)
    editNavigationController.modalPresentationStyle = .pageSheet
    
    return editNavigationController
  }
  
  private func createTodoData(from collectionView: UICollectionView, indexPath: IndexPath) -> Todo? {
    let dataSource = collectionView.dataSource as? DataSource
    let item = dataSource?.itemIdentifier(for: indexPath)
    
    return item
  }
}

// MARK: Delegate

// MARK: SwipeCollectionViewCellDelegate

extension TodoListViewController: SwipeCollectionViewCellDelegate {
  func collectionView(_ collectionView: UICollectionView, editActionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
    guard orientation == .right else { return nil }
    
    guard let item = findItem(from: collectionView, with: indexPath.row) else {
      return nil
    }
    
    let deleteAction = SwipeAction(style: .destructive, title: Const.delete) { [weak self] _, _ in
      self?.viewModel.deleActionDidTap(item)
    }
    
    deleteAction.image = UIImage(named: Const.deleteImage)
    
    return [deleteAction]
  }
  
  private func findItem(from collectionView: UICollectionView, with indexPathRow: Int) -> Todo? {
    guard let dataSource = collectionView.dataSource as? DataSource else {
      return nil
    }
    guard let item = dataSource.snapshot().itemIdentifiers[safe: indexPathRow] else {
      return nil
    }
    
    return item
  }
}

// MARK: UILongPressGestureDelagate & Move Todo Method
private extension TodoListViewController {
  @objc func showMovingTodoSheet(_ gesture: UILongPressGestureRecognizer) {
    let pressedPoint = gesture.location(ofTouch: 0, in: nil)
    
    let pressedState = filterState(from: pressedPoint.x, by: view.bounds.width)
    let collectionView = filterCollectionView(from: pressedState)
    
    let collectionViewPressedPoint = gesture.location(in: collectionView)
    
    guard let indexPath = collectionView.indexPathForItem(at: collectionViewPressedPoint) else {
      return
    }
    
    let dataSource = collectionView.dataSource as? DataSource
    guard let item = dataSource?.snapshot().itemIdentifiers[indexPath.row] else {
      return
    }
    
    let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    let alertActions = createAlertActions(from: pressedState, item: item)
    
    alertActions.forEach { alert.addAction($0) }
    
    let popover = alert.popoverPresentationController
    
    popover?.sourceView = view
    popover?.sourceRect = CGRect(x: pressedPoint.x, y: pressedPoint.y, width: 64, height: 64)
    
    present(alert, animated: true)
  }
  
  func filterState(from touchedLocationX: Double, by viewWidth: Double) -> State {
    let todoViewZone = viewWidth * 0.3
    let doingViewZone = (viewWidth * 0.3)...(viewWidth * 0.6)
    
    if touchedLocationX < todoViewZone {
      return .todo
    }
    
    if doingViewZone.contains(touchedLocationX) {
      return .doing
    }
    
    return .done
  }
  
  func filterAlertActions(exceptState: State, by actions: [UIAlertAction]) -> [UIAlertAction] {
    guard let moveTodo = actions[safe: 0] ,
          let moveDoing = actions[safe: 1],
          let moveDone = actions[safe: 2] else {
      return [UIAlertAction]()
    }
    
    var actionsStorage = [UIAlertAction]()
    
    switch exceptState {
    case .todo:
      actionsStorage.append(moveTodo)
      actionsStorage.append(moveDoing)
      
      return actionsStorage
    case .doing:
      actionsStorage.append(moveTodo)
      actionsStorage.append(moveDone)
      
      return actionsStorage
    case .done:
      actionsStorage.append(moveTodo)
      actionsStorage.append(moveDoing)
      
      return actionsStorage
    }
  }
  
  func createAlertActions(from state: State, item: Todo) -> [UIAlertAction] {
    let moveToTodoAction = UIAlertAction(title: State.todo.moveMessage, style: .default) { [weak self] _ in
      self?.viewModel.popoverButtonDidTap(item, to: .todo)
    }
    
    let moveToDoingAction = UIAlertAction(title: State.doing.moveMessage, style: .default) { [weak self] _ in
      self?.viewModel.popoverButtonDidTap(item, to: .doing)
    }
    
    let moveToDoneAction = UIAlertAction(title: State.done.moveMessage, style: .default) { [weak self] _ in
      self?.viewModel.popoverButtonDidTap(item, to: .done)
    }
    
    var actionsStorage = [UIAlertAction]()
    
    switch state {
    case .todo:
      actionsStorage.append(moveToDoingAction)
      actionsStorage.append(moveToDoneAction)
      
      return actionsStorage
    case .doing:
      actionsStorage.append(moveToTodoAction)
      actionsStorage.append(moveToDoneAction)
      
      return actionsStorage
    case .done:
      actionsStorage.append(moveToTodoAction)
      actionsStorage.append(moveToDoingAction)
      
      return actionsStorage
    }
  }
  
  func filterCollectionView(from state: State) -> UICollectionView {
    switch state {
    case .todo:
      return todoView.todoCollectionView
    case .doing:
      return doingView.todoCollectionView
    case .done:
      return doneView.todoCollectionView
    }
  }
}
