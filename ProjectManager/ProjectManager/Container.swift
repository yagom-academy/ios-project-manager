//
//  Container.swift
//  ProjectManager
//
//  Created by 두기 on 2022/07/13.
//

final class Container {
    static let shared = Container(storage: MockStorage())
    private let storage: Storegeable
    
    func makeMainViewController() -> MainViewController {
        return MainViewController(viewModel: makeMainViewModel())
    }
    
    private func makeMainViewModel() -> MainViewModelInOut {
        return MainViewModel(storage: storage)
    }
    
    private init(storage: Storegeable) {
        self.storage = storage
    }
}
