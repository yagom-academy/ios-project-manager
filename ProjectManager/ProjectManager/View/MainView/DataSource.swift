//
//  DataSource.swift
//  ProjectManager
//
//  Created by 써니쿠키 on 2023/01/14.
//

import UIKit

enum Section {
    case main
}

final class DataSource: UITableViewDiffableDataSource<Section, Project> {
    
    typealias SnapShot = NSDiffableDataSourceSnapshot<Section, Project>
    
    private var snapShot = SnapShot()
    
    func applyInitialSnapShot(_ datas: [Project]) {
        snapShot.appendSections([.main])
        snapShot.appendItems(datas, toSection: .main)
        self.apply(snapShot)
    }
    
    func reload(_ datas: [Project]) {
        snapShot.deleteAllItems()
        snapShot.appendSections([.main])
        snapShot.appendItems(datas)
        self.apply(snapShot)
    }
}
