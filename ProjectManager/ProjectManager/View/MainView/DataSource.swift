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
    
    func applyInitialSnapShot(_ data: [Project]) {
        snapShot.appendSections([.main])
        snapShot.appendItems(data, toSection: .main)
        self.apply(snapShot)
    }
    
    func applySnapshot(_ datas: [Project]) {
        snapShot.appendItems(datas)
        self.apply(snapShot)
    }
}

enum Section {
    case main
}
