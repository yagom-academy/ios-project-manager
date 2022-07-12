//
//  BaseViewController.swift
//  ProjectManager
//
//  Created by LIMGAUI on 2022/07/07
//

import UIKit

final class BaseViewController: UIViewController {
  // MARK: DiffableDataSource
  typealias DataSource = UICollectionViewDiffableDataSource<Int, Todo>
  typealias SnapShot = NSDiffableDataSourceSnapshot<Int, Todo>
  var todoDataSource: DataSource!
  var doingDataSource: DataSource!
  var doneDataSource: DataSource!
  
  func setDataSource() {
    todoDataSource = makeDataSource(todoView.todoCollectionView)
    doingDataSource = makeDataSource(doingView.todoCollectionView)
    doneDataSource = makeDataSource(doneView.todoCollectionView)
  }

  func applySnapShot(_ items: [Todo], dataSource: DataSource) {
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
  
  var todoList = Todo().readList {
    didSet {
      reloadDataSource()
      updateListCountlabel()
    }
  }
  
  // MARK: View Properties
  lazy var todoView = TodoView(headerName: "TODO", listCount: findListCount(.todo))
  lazy var doingView = TodoView(headerName: "DOING", listCount: findListCount(.doing))
  lazy var doneView = TodoView(headerName: "DONE", listCount: findListCount(.done))
  
  private let mainStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.backgroundColor = .systemGray
    stackView.axis = .horizontal
    stackView.distribution = .fillEqually
    stackView.spacing = 10
    return stackView
  }()
  
  private func updateListCountlabel() {
    todoView.listCountLabel.text = findListCount(.todo).description
    doingView.listCountLabel.text = findListCount(.doing).description
    doneView.listCountLabel.text = findListCount(.done).description
  }
  
  private func findListCount(_ todoState: State) -> Int {
    return todoList.filter { $0.state == todoState }.count
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpDelegate()
    configureUI()
    setDataSource()
    reloadDataSource()
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
    let writeVC = WriteViewController()
    writeVC.view.layer.cornerRadius = 20
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

extension BaseViewController: UICollectionViewDelegate {
  // MARK: Move EditViewController
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let todo = createTodoData(from: collectionView, indexPath: indexPath.row)
    let editVC = createEditViewController(with: todo)
    present(editVC, animated: true)
  }
  
  private func createEditViewController(with todo: Todo) -> UINavigationController {
    let editVC = EditViewController(todo: todo)
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

extension BaseViewController: TodoDelegate {
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

extension BaseViewController: SwipeCollectionViewCellDelegate {
  func collectionView(_ collectionView: UICollectionView, editActionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
    guard orientation == .right else { return nil }
    
    let deleteAction = SwipeAction(style: .destructive, title: "삭제") { _, _ in
      let collectionViewState = self.findState(about: collectionView)
      let todoItems = self.todoList.filter { $0.state == collectionViewState }
      let item = todoItems[indexPath.row]
      let index = self.todoList.firstIndex(of: item)
      self.todoList.remove(at: index!)
    }

    deleteAction.image = UIImage(named: "delete")
    
    return [deleteAction]
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
extension BaseViewController {
  @objc func showMovingTodoSheet(_ gesture: UILongPressGestureRecognizer) {
    var indexPathRow = Int()
    if gesture.state == UIGestureRecognizer.State.began {
      let touchPoint = gesture.location(in: todoView.todoCollectionView)
      if let index = todoView.todoCollectionView.indexPathForItem(at: touchPoint) {
        indexPathRow = index.row
      }
    }
    
    let pressedPoint: CGPoint = gesture.location(ofTouch: 0, in: nil)
    
    let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    
    let moveToDoingAction = UIAlertAction(title: "Move To DOING", style: .default) { _ in
      self.moveTodoTo(state: .doing, and: indexPathRow)
    }
    let moveToDoneAction = UIAlertAction(title: "Move To DONE", style: .default) { _ in
      self.moveTodoTo(state: .done, and: indexPathRow)
    }
    
    alert.addAction(moveToDoingAction)
    alert.addAction(moveToDoneAction)
    
    let popover = alert.popoverPresentationController
    popover?.sourceView = view
    popover?.sourceRect = CGRect(x: pressedPoint.x, y: pressedPoint.y, width: 64, height: 64)
    
    present(alert, animated: true)
  }
  
  private func moveTodoTo(state: State, and indexPathRow: Int) {
    let todoItems = self.todoList.filter { $0.state == .todo }
    let item = todoItems[indexPathRow]
    guard let index = self.todoList.firstIndex(of: item) else { return }
    self.todoList[index].state = state
  }
}
