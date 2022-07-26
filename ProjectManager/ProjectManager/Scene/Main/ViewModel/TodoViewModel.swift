//
//  TodoViewModel.swift
//  ProjectManager
//  Created by LIMGAUI on 2022/07/12

import Foundation
import Combine
import UIKit

final class TodoViewModel {
  typealias DataSource = UICollectionViewDiffableDataSource<Int, Todo>
  typealias SnapShot = NSDiffableDataSourceSnapshot<Int, Todo>
  
  private let storage: StorageType
  private var originator: Originatable
  
  var todoDataSource: DataSource?
  var doingDataSource: DataSource?
  var doneDataSource: DataSource?
  
  init(
    storage: StorageType = FireBaseService.shared,
    originator: Originatable = Originator.shared
  ) {
    self.storage = storage
    self.originator = originator
  }
  // MARK: - Input
  
  func HistoryButtonDidTap() {
    
  }

  func deleteActionDidTap(_ todo: Todo) {
    storage.delete(todo)
    saveDeleteState(todo)
  }

  func popoverButtonDidTap(_ todo: Todo, to state: State) {
    let todo = Todo(
      id: todo.id,
      title: todo.title,
      content: todo.content,
      date: todo.date,
      state: state
    )
    
    storage.update(todo)
    saveMovedState(todo, to: state)
  }
  
  func applySnapShot(_ items: [Todo], dataSource: DataSource) {
    var snapshot = SnapShot()
    snapshot.appendSections([0])
    snapshot.appendItems(items)
    dataSource.apply(snapshot)
  }
  
  private func saveMovedState(_ todo: Todo, to state: State) {
    originator.createMemento(Memento(todo: todo, historyState: .moved, toState: state))
  }
  
  private func saveDeleteState(_ todo: Todo) {
    originator.createMemento(Memento(todo: todo, historyState: .removed))
  }
  // MARK: - Output

  var historyList: AnyPublisher<[Memento], Never> {
    return originator.careTaker.stateList
  }
  
  var toList: AnyPublisher<[Todo], Never> {
    return readData(by: .todo)
  }
  
  var doingList: AnyPublisher<[Todo], Never> {
    return readData(by: .doing)
  }
  
  var doneList: AnyPublisher<[Todo], Never> {
    return readData(by: .done)
  }
  
  private func readData(by state: State) -> AnyPublisher<[Todo], Never> {
    return storage.read().map { items in
      return items.filter { $0.state == state }
    }
    .eraseToAnyPublisher()
  }
}
