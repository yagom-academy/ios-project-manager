//
//  Container.swift
//  ProjectManager
//
//  Created by 두기 on 2022/07/13.
//

final class Container {
    private let storage: Storegeable
    
    func makeMainViewController() -> MainViewController {
        return MainViewController(viewModel: makeMainViewModel())
    }
    
    private func makeMainViewModel() -> MainViewModelInOut {
        return MainViewModel(storage: storage)
    }
    
    init(storage: Storegeable) {
        self.storage = storage
    }
}
