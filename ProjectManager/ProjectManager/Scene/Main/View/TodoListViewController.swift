//
//  BaseViewController.swift
//  ProjectManager
//
//  Created by LIMGAUI on 2022/07/07
//

import UIKit
import SwipeCellKit
import Combine
import Firebase

private enum Constant {
  static let delete = "삭제"
  static let deleteImage = "delete"
}

final class TodoListViewController: UIViewController {
  typealias DataSource = UICollectionViewDiffableDataSource<Int, Todo>
  typealias SnapShot = NSDiffableDataSourceSnapshot<Int, Todo>
  
  private var bag = Set<AnyCancellable>()
  
  private let viewModel = TodoViewModel()
  
  private let todoView = TodoListView(headerName: HeaderName.todo)
  private let doingView = TodoListView(headerName: HeaderName.doing)
  private let doneView = TodoListView(headerName: HeaderName.done)
  
  private let mainStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.backgroundColor = .systemGray
    stackView.axis = .vertical
    return stackView
  }()
  
  private let todoListStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.backgroundColor = .systemGray
    stackView.axis = .horizontal
    stackView.distribution = .fillEqually
    stackView.spacing = 10
    return stackView
  }()
  
  private let bottomView: UIView = {
    let stackView = UIView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.backgroundColor = .systemBackground
    return stackView
  }()
  
  private lazy var undoButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("Undo", for: .normal)
    button.setTitleColor(UIColor.systemGray, for: UIControl.State.normal)
    button.addTarget(
      self,
      action: #selector(undo),
      for: .touchUpInside
    )
    return button
  }()
  
  private lazy var redoButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("Redo", for: .normal)
    button.setTitleColor(UIColor.systemGray, for: UIControl.State.normal)
    button.addTarget(
      self,
      action: #selector(redo),
      for: .touchUpInside
    )
    return button
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpDelegate()
    configureUI()
    setDataSource()
    bind()
    setUpNotification()
  }
  
  @objc private func undo() { print("\(#function)") }
  @objc private func redo() { print("\(#function)") }
  
  private func bind() {
    viewModel.toList
      .sink { [weak self] items in
        guard let self = self,
              let todoDataSource = self.viewModel.todoDataSource else { return }
        self.viewModel.applySnapShot(items, dataSource: todoDataSource)
        self.todoView.updateListCount(items.count)
      }
      .store(in: &bag)
    
    viewModel.doingList
      .sink { [weak self] items in
        guard let self = self,
              let doingDataSource = self.viewModel.doingDataSource else { return }
        self.viewModel.applySnapShot(items, dataSource: doingDataSource)
        self.doingView.updateListCount(items.count)
      }
      .store(in: &bag)
    
    viewModel.doneList
      .sink { [weak self] items in
        guard let self = self,
              let doneDataSource = self.viewModel.doneDataSource else { return }
        self.viewModel.applySnapShot(items, dataSource: doneDataSource)
        self.doneView.updateListCount(items.count)
      }
      .store(in: &bag)
  }
  
  private func setDataSource() {
    viewModel.todoDataSource = makeDataSource(todoView.todoCollectionView)
    viewModel.doingDataSource = makeDataSource(doingView.todoCollectionView)
    viewModel.doneDataSource = makeDataSource(doneView.todoCollectionView)
  }
  
  private func makeDataSource(_ collectionView: UICollectionView) -> DataSource {
    return DataSource(
      collectionView: collectionView) { collectionView, indexPath, item in
        let cell = collectionView.dequeueReusableCell(
          withReuseIdentifier: TodoCollectionViewCell.identifier,
          for: indexPath) as? TodoCollectionViewCell
        cell?.updatePropertiesValue(item)
        cell?.delegate = self
        cell?.longPress.addTarget(self, action: #selector(self.showPopover))
        return cell
      }
  }
  
  private func setUpDelegate() {
    [todoView, doingView, doneView].forEach { $0.todoCollectionView.delegate = self }
  }
  
  private func moveWriteViewControllerDidTap() {
    let writeViewController = WriteTodoViewController(viewModel: WriteViewModel())
    let writeNavigationController = UINavigationController(rootViewController: writeViewController)
    writeNavigationController.modalPresentationStyle = .pageSheet
    
    present(writeNavigationController, animated: true)
  }
  
  private func setNavigationBar() {
    navigationItem.rightBarButtonItem = UIBarButtonItem(
      systemItem: .add,
      primaryAction: UIAction(handler: { _ in
        self.moveWriteViewControllerDidTap()
      })
    )
    
    navigationItem.leftBarButtonItem = UIBarButtonItem(
      title: "History",
      primaryAction: UIAction(handler: { _ in
        self.showPopoverHistoryViewController()
      })
    )
    navigationItem.title = "Project Manager"
  }
  
  private func showPopoverHistoryViewController() {
    let historyVC = HistoryViewController()
    historyVC.modalPresentationStyle = .popover
    
    let popover = historyVC.popoverPresentationController
    
    popover?.barButtonItem = navigationItem.leftBarButtonItem

    present(historyVC, animated: true)
  }
  
  private func configureUI() {
    setNavigationBar()
    
    view.backgroundColor = .systemGray5
    view.addSubview(mainStackView)
    mainStackView.addArrangedSubviews([todoListStackView, bottomView])
    todoListStackView.addArrangedSubviews([todoView, doingView, doneView])
    bottomView.addSubview(redoButton)
    bottomView.addSubview(undoButton)
    
    NSLayoutConstraint.activate([
      mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
      mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
      
      bottomView.heightAnchor.constraint(equalToConstant: view.frame.height * 0.05),
      
      redoButton.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -10),
      redoButton.topAnchor.constraint(equalTo: bottomView.topAnchor),
      redoButton.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor),
      
      undoButton.trailingAnchor.constraint(equalTo: redoButton.leadingAnchor, constant: -10),
      undoButton.topAnchor.constraint(equalTo: bottomView.topAnchor),
      undoButton.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor)
    ])
  }
  
  deinit {
    RealmError.removeObserver(vc: self)
  }
}

// MARK: Move To EditViewController

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

// MARK: Swipe Delete

extension TodoListViewController: SwipeCollectionViewCellDelegate {
  func collectionView(_ collectionView: UICollectionView, editActionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
    guard orientation == .right else { return nil }
    
    guard let item = findItem(from: collectionView, with: indexPath.row) else {
      return nil
    }
    
    let deleteAction = SwipeAction(style: .destructive, title: Constant.delete) { [weak self] _, _ in
      self?.viewModel.deleteActionDidTap(item)
    }
    
    deleteAction.image = UIImage(named: Constant.deleteImage)
    
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

// MARK: Popover
private extension TodoListViewController {
  @objc func showPopover(longPressed gesture: UILongPressGestureRecognizer) {
    let pressedPoint = gesture.location(ofTouch: 0, in: nil)
    let pressedState = filterState(from: pressedPoint.x, by: view.bounds.width)
    let collectionView = filterCollectionView(from: pressedState)
    
    let collectionViewPressedPoint = gesture.location(in: collectionView)
    
    guard let indexPath = collectionView.indexPathForItem(at: collectionViewPressedPoint) else {
      return
    }
    
    guard let item = findItem(from: collectionView, with: indexPath.row) else {
      return
    }
    
    let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    let alertActions = createPopoverAlertActions(from: pressedState, item: item)
    
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
  
  func createPopoverAlertActions(from state: State, item: Todo) -> [UIAlertAction] {
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

private extension TodoListViewController {
  func setUpNotification() {
    RealmError.addObserver(selector: #selector(showErrorAlert), vc: self)
  }
  
  @objc func showErrorAlert(_ notification: Notification) {
    guard let error = notification.object as? Error else {
      return
    }
    
    let alertViewController = UIAlertController(
      title: "RealmError",
      message: "\(error) \nTodo를 등록하세요. \n(우측상단에 + 버튼을 클릭)",
      preferredStyle: .alert
    )
    
    let checkAction = UIAlertAction(title: "확인", style: .default)
    
    alertViewController.addAction(checkAction)
    
    present(alertViewController, animated: true)
  }
}
