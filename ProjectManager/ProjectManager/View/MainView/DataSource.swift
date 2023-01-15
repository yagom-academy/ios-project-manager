//
//  DataSource.swift
//  ProjectManager
//
//  Created by 맹선아 on 2023/01/14.
//

import UIKit

class DataSource: UITableViewDiffableDataSource<Section, Project> {
    
    typealias SnapShot = NSDiffableDataSourceSnapshot<Section, Project>

    var snapShot = SnapShot()
    
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

enum Section {
    case main
}
