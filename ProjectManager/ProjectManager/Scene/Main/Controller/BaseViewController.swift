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
