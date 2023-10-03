//
//  MainViewModel.swift
//  ProjectManager
//
//  Created by Erick on 2023/09/22.
//

import UIKit

struct MainViewModelActions {
    let showProjectDetail: (Project?) -> Void
}

protocol MainViewModelInput {
    func viewDidLoad()
    func tapAddButton()
}

protocol MainViewModelOutput {
    var navigationTitle: String { get }
}

typealias MainViewModel = MainViewModelInput & MainViewModelOutput

final class DefaultMainViewModel: MainViewModel {
    
    // MARK: - Private Property
    private let projectUseCase: ProjectUseCase
    private let actions: MainViewModelActions
    
    // MARK: - Life Cycle
    init(projectUseCase: ProjectUseCase,
         actions: MainViewModelActions
    ) {
        self.projectUseCase = projectUseCase
        self.actions = actions
    }
    
    // MARK: - OUTPUT
    var navigationTitle: String { "ProjectManager" }
}

// MARK: - INPUT View event methods
extension DefaultMainViewModel {
    func viewDidLoad() { }
    
    func tapAddButton() {
        actions.showProjectDetail(nil)
    }
}
