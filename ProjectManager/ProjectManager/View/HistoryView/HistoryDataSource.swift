//
//  HistoryDataSource.swift
//  ProjectManager
//
//  Created by 써니쿠키 on 2023/01/26.
//

import UIKit

final class HistoryDataSource: UICollectionViewDiffableDataSource<Section, Int> {
    
    typealias SnapShot = NSDiffableDataSourceSnapshot<Section, Int>
    
    private var snapShot = SnapShot()
    
    func applyInitialSnapShot(_ numbers: [Int]) {
        snapShot.appendSections([.main])
        snapShot.appendItems(numbers, toSection: .main)
        self.apply(snapShot)
    }
    
    func reload(_ numbers: [Int]) {
        snapShot.deleteAllItems()
        snapShot.appendSections([.main])
        snapShot.appendItems(numbers)
        self.apply(snapShot)
    }
}
