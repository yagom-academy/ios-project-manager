//
//  Container.swift
//  ProjectManager
//
//  Created by 두기 on 2022/07/13.
//

final class Container {
    private let storage: Storegeable
    
    func makeMainViewController() -> MainViewController {
        return MainViewController(viewModel: makeMainViewModel(), container: self)
    }
    
    private func makeMainViewModel() -> MainViewModelInOut {
        return MainViewModel(storage: storage)
    }
    
    func makeAddViewController() -> AddViewController {
        let addVC = AddViewController(viewModel: makeDetailViewModel())
        addVC.modalPresentationStyle = .formSheet
        return addVC
    }
    
    func makeEditViewController(_ list: ListItem) -> EditlViewController {
        let editVC = EditlViewController(viewModel: makeDetailViewModel(), listItem: list)
        editVC.modalPresentationStyle = .formSheet
        return editVC
    }
    
    private func makeDetailViewModel() -> DetailViewModel {
        return DetailViewModel(storage: storage)
    }
    
    init(storage: Storegeable) {
        self.storage = storage
    }
}
