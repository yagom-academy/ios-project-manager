//
//  ScenePresentable.swift
//  ProjectManager
//
//  Created by 고은 on 2022/03/10.
//

import UIKit

protocol ScenePresentable where Self: UIViewController {

    var editViewController: EditController { get }

    func presentDeleteAlert(indexPath: IndexPath, in tableView: MainTableView)
    func presentNavigationController()
}
