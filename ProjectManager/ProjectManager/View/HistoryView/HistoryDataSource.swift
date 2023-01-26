//
//  HistoryDataSource.swift
//  ProjectManager
//
//  Created by 써니쿠키 on 2023/01/26.
//

import UIKit

final class HistoryDataSource: UICollectionViewDiffableDataSource<Section, ProjectHistory> {
    
    typealias SnapShot = NSDiffableDataSourceSnapshot<Section, ProjectHistory>
    
    private var snapShot = SnapShot()
    
    func applyInitialSnapShot(_ histories: [ProjectHistory]) {
        snapShot.appendSections([.main])
        snapShot.appendItems(histories, toSection: .main)
        self.apply(snapShot)
    }
    
    func reload(_ histories: [ProjectHistory]) {
        snapShot.deleteAllItems()
        snapShot.appendSections([.main])
        snapShot.appendItems(histories)
        self.apply(snapShot)
    }
}
