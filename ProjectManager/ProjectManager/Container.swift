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
        let addVC = AddViewController(viewModel: makeAddViewModel())
        addVC.modalPresentationStyle = .formSheet
        return addVC
    }
    
    private func makeAddViewModel() -> AddViewModelable {
        return AddViewModel(storage: storage)
    }
    
    func makeEditViewController(index: Int, type: ListType) -> EditViewController {
        let editVC = EditViewController(viewModel: makeEditViewModel(index: index, type: type))
        editVC.modalPresentationStyle = .formSheet
        return editVC
    }

    private func makeEditViewModel(index: Int, type: ListType) -> EditViewModelable {
        return EditViewModel(storage: storage, index: index, type: type)
    }
    
    init(storage: Storegeable) {
        self.storage = storage
    }
}
