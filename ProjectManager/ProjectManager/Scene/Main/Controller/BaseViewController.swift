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
