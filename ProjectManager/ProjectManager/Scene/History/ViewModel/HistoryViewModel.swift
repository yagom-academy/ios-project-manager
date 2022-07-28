//
//  HistoryViewModel.swift
//  ProjectManager
//
//  Created by LIMGAUI on 2022/07/28.
//

import UIKit
import Combine

final class HistoryViewModel {
  typealias DataSource = UICollectionViewDiffableDataSource<Int, Memento>
  typealias SnapShot = NSDiffableDataSourceSnapshot<Int, Memento>
  
  var historyDataSource: DataSource?
  let originator: Originatable
  
  init(originator: Originatable = Originator.shared) {
    self.originator = originator
  }
  
  func applySnapShot(_ items: [Memento], dataSource: DataSource) {
    var snapshot = SnapShot()
    snapshot.appendSections([0])
    snapshot.appendItems(items)
    dataSource.apply(snapshot)
  }
  
  var historyList: AnyPublisher<[Memento], Never> {
    return originator.careTaker.stateList.eraseToAnyPublisher()
  }
}
