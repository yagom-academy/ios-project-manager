//
//  BaseViewController.swift
//  ProjectManager
//
//  Created by LIMGAUI on 2022/07/07
//

import UIKit
import SwipeCellKit
import RealmSwift

final class TodoListViewController: UIViewController {
  // MARK: DiffableDataSource
  typealias DataSource = UICollectionViewDiffableDataSource<Int, Todo>
  typealias SnapShot = NSDiffableDataSourceSnapshot<Int, Todo>
  var todoDataSource: DataSource!
  var doingDataSource: DataSource!
  var doneDataSource: DataSource!
  
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
  
  func makeDataSource(_ collectionView: UICollectionView) -> DataSource {
    return DataSource(
      collectionView: collectionView) { collectionView, indexPath, item in
        let cell = collectionView.dequeueReusableCell(
          withReuseIdentifier: "TodoCollectionViewCell",
          for: indexPath) as? TodoCollectionViewCell
        cell?.updatePropertiesValue(item)
        cell?.delegate = self
        cell?.longPress.addTarget(self, action: #selector(self.showMovingTodoSheet))
        return cell
      }
  }
  private let todoManager = TodoManager.shared
  private let viewModel = TodoViewModel()
  
  lazy var todoList = viewModel.readList {
    didSet {
      reloadDataSource()
      updateListCountlabel()
    }
  }
  
  // MARK: View Properties
  lazy var todoView = TodoListView(headerName: "TODO", listCount: viewModel.findListCount(.todo))
  lazy var doingView = TodoListView(headerName: "DOING", listCount: viewModel.findListCount(.doing))
  lazy var doneView = TodoListView(headerName: "DONE", listCount: viewModel.findListCount(.done))
  
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
    reloadDataSource()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    let todoModels = todoManager.readAll()
    viewModel.mappingTodo(from: todoModels)
  }
  
  func updateListCountlabel() {
    todoView.listCountLabel.text = viewModel.findListCount(.todo).description
    doingView.listCountLabel.text = viewModel.findListCount(.doing).description
    doneView.listCountLabel.text = viewModel.findListCount(.done).description
  }
  
  private func reloadDataSource() {
    applySnapShot(todoList.filter { $0.state == .todo }, dataSource: todoDataSource)
    applySnapShot(todoList.filter { $0.state == .doing }, dataSource: doingDataSource)
    applySnapShot(todoList.filter { $0.state == .done }, dataSource: doneDataSource)
  }
  
  private func setUpDelegate() {
    todoView.todoCollectionView.delegate = self
    doingView.todoCollectionView.delegate = self
    doneView.todoCollectionView.delegate = self
  }
  
  private func moveWriteTodo() {
    let writeVC = WriteTodoViewController()
    let writeNC = UINavigationController(rootViewController: writeVC)
    writeNC.modalPresentationStyle = .pageSheet
    writeVC.todoDelegate = self
    present(writeNC, animated: true)
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
    let todo = createTodoData(from: collectionView, indexPath: indexPath.row)
    let editVC = createEditViewController(with: todo)
    present(editVC, animated: true)
  }
  
  private func createEditViewController(with todo: Todo) -> UINavigationController {
    let editVC = EditTodoViewController(todo: todo)
    editVC.delegate = self
    let editNC = UINavigationController(rootViewController: editVC)
    editNC.modalPresentationStyle = .pageSheet
    
    return editNC
  }
  
  private func createTodoData(from collectionView: UICollectionView, indexPath row: Int) -> Todo {
    let collectionViewState = self.findState(about: collectionView)
    let todoItems = self.todoList.filter { $0.state == collectionViewState }
    let todo = todoItems[row]
    
    return todo
  }
}

// MARK: Delegate

extension TodoListViewController: TodoDelegate {
  func createData(_ todo: Todo) {
    todoList.append(todo)
  }
  
  func updateData(_ todo: Todo) {
    guard let index = todoList.firstIndex(where: { $0.identifier == todo.identifier }) else {
      return
    }
    
    todoList[index] = todo
  }
}

// MARK: SwipeCollectionViewCellDelegate

extension TodoListViewController: SwipeCollectionViewCellDelegate {
  func collectionView(_ collectionView: UICollectionView, editActionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
    guard orientation == .right else { return nil }
    
    let deleteAction = SwipeAction(style: .destructive, title: "삭제") { _, _ in
      let collectionViewState = self.findState(about: collectionView)
      self.removeTodoDidTapDelete(collectionViewState, at: indexPath.row)
    }

    deleteAction.image = UIImage(named: "delete")
    
    return [deleteAction]
  }
  
  private func removeTodoDidTapDelete(_ state: State, at index: Int) {
    let todoItems = self.todoList.filter { $0.state == state }
    let item = todoItems[index]
    
    guard let index = self.todoList.firstIndex(of: item) else {
      return
    }
    
    self.todoList.remove(at: index)
  }

  private func findState(about collectionView: UICollectionView) -> State {
    switch collectionView {
    case todoView.todoCollectionView:
      return .todo
    case doingView.todoCollectionView:
      return .doing
    case doneView.todoCollectionView:
      return .done
    default:
      break
    }
    
    return .done
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
    
    let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    let alertActions = createAlertActions(from: pressedState, indexPathRow: indexPath.row)
    
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
    var actionsStorage = [UIAlertAction]()
    
    if exceptState == .todo {
      actionsStorage.append(actions[1])
      actionsStorage.append(actions[2])
      
      return actionsStorage
    }
    
    if exceptState == .doing {
      actionsStorage.append(actions[0])
      actionsStorage.append(actions[2])
      
      return actionsStorage
    }
    
    actionsStorage.append(actions[0])
    actionsStorage.append(actions[1])
    
    return actionsStorage
  }
  
  func createAlertActions(from state: State, indexPathRow: Int) -> [UIAlertAction] {
    let moveToTodoAction = UIAlertAction(title: State.todo.moveMessage, style: .default) { _ in
      self.changeState(from: state, to: .todo, and: indexPathRow)
    }
    
    let moveToDoingAction = UIAlertAction(title: State.doing.moveMessage, style: .default) { _ in
      self.changeState(from: state, to: .doing, and: indexPathRow)
    }
    
    let moveToDoneAction = UIAlertAction(title: State.done.moveMessage, style: .default) { _ in
      self.changeState(from: state, to: .done, and: indexPathRow)
    }
    
    var actionsStorage = [UIAlertAction]()
    
    if state == .todo {
      actionsStorage.append(moveToDoingAction)
      actionsStorage.append(moveToDoneAction)
      
      return actionsStorage
    }
    
    if state == .doing {
      actionsStorage.append(moveToTodoAction)
      actionsStorage.append(moveToDoneAction)
      
      return actionsStorage
    }
    
    actionsStorage.append(moveToTodoAction)
    actionsStorage.append(moveToDoingAction)
    
    return actionsStorage
  }
  
  func changeState(from pressdState: State, to state: State, and index: Int) {
    let todoItems = todoList.filter { $0.state == pressdState }
    let item = todoItems[index]
    guard let index = todoList.firstIndex(of: item) else { return }
    todoList[index].state = state
  }
  
  func filterCollectionView(from state: State) -> UICollectionView {
    if state == .todo {
      return todoView.todoCollectionView
    }
    
    if state == .doing {
      return doingView.todoCollectionView
    }
    
    return doneView.todoCollectionView
  }
}
