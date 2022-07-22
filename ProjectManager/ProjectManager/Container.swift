//
//  Container.swift
//  ProjectManager
//
//  Created by 두기 on 2022/07/13.
//

final class Container {
    private let storage: AppStoregeable
    
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
    
    func makeEditViewController(_ listItem: ListItem) -> EditViewController {
        let editVC = EditViewController(viewModel: makeEditViewModel(listItem))
        editVC.modalPresentationStyle = .formSheet
        return editVC
    }

    private func makeEditViewModel(_ listItem: ListItem) -> EditViewModelable {
        return EditViewModel(storage: storage, item: listItem)
    }
    
    init(storage: AppStoregeable) {
        self.storage = storage
    }
}
