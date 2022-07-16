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
        let addVC = AddViewController(viewModel: makeAddViewModel(nil))
        addVC.modalPresentationStyle = .formSheet
        return addVC
    }
    
    private func makeAddViewModel(_ list: ListItem?) -> AddViewModel {
        return AddViewModel(storage: storage, list: list)
    }
    
    func makeEditViewController(_ list: ListItem) -> EditlViewController {
        let editVC = EditlViewController(viewModel: makeEditViewModel(list))
        editVC.modalPresentationStyle = .formSheet
        return editVC
    }

    private func makeEditViewModel(_ list: ListItem?) -> EditViewModel {
        return EditViewModel(storage: storage, list: list)
    }
    
    init(storage: Storegeable) {
        self.storage = storage
    }
}
