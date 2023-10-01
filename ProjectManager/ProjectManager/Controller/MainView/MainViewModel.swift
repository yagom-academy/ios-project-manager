//
//  MainViewModel.swift
//  ProjectManager
//
//  Created by Hemg on 2023/10/01.
//

import UIKit

final class MainViewModel {
    private let useCase: MainViewControllerUseCase
    
    init(useCase: MainViewControllerUseCase) {
        self.useCase = useCase
    }
    
    func configureTableView(_ tableView: UITableView, dataSourceAndDelegate: UITableViewDataSource & UITableViewDelegate) {
        tableView.dataSource = dataSourceAndDelegate
        tableView.delegate = dataSourceAndDelegate
        tableView.register(ListTitleCell.self, forCellReuseIdentifier: ReuseIdentifier.listTitleCell)
        tableView.register(DescriptionCell.self, forCellReuseIdentifier: ReuseIdentifier.descriptionCell)
    }
    
    func performMoveToState(_ item: ProjectManager, state: TitleItem) {
        switch state {
        case .todo:
            useCase.moveToTodo(item)
        case .doing:
            useCase.moveToDoing(item)
        case .done:
            useCase.moveToDone(item)
        }
    }
}
