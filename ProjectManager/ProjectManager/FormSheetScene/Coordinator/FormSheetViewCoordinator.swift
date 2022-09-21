//
//  EditTodoListCoordinator.swift
//  ProjectManager
//
//  Created by 이원빈 on 2022/09/15.
//

import UIKit

final class FormSheetViewCoordinator: Coordinator {
    var mode: PageMode
    var category: String?
    var index: Int?
    
    init(mode: PageMode, category: String? = nil, index: Int? = nil) {
        self.mode = mode
        self.category = category
        self.index = index
    }
    
    func start() -> UIViewController {
        let formSheetVM = FormSheetViewModel(mode: mode,
                                        category: category,
                                        index: index)
        let formSheetVC = FormSheetViewController(viewModel: formSheetVM)
        let navCon = UINavigationController(
            rootViewController: formSheetVC
        )
        navCon.modalPresentationStyle = .formSheet
        return navCon
    }
}
