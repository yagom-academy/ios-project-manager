//
//  CoordinatorProtocol.swift
//  ProjectManager
//
//  Created by Derrick kim on 9/7/22.
//

import UIKit

protocol CoordinatorProtocol: AnyObject {
    var navigationController: UINavigationController? { get set }
    var children: [CoordinatorProtocol] { get set }
    
    func start()
    func presentEnrollmentViewController()
    func presentDetailViewController(_ model: TodoListModel)
}

enum Event {
    case plusButtonTapped
    case tableViewCellTapped
}

protocol Coordinating {
    var coordinator: CoordinatorProtocol? { get set }
}
