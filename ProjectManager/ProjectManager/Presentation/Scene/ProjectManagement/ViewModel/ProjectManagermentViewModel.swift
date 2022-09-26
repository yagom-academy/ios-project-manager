//
//  ProjectManagermentViewModel.swift
//  ProjectManager
//
//  Created by Groot on 2022/09/22.
//

import Foundation

private enum Design {
    static let defaultText = ""
}

final class ProjectManagermentViewModel {
// MARK: - Output to View
    
    func makeProjectViewModel(id: String,
                              state: ProjectState,
                              newItem: (textArray: [String],
                                        date: Date)) -> ProjectViewModel {
        let data = ProjectViewModel(id: id,
                                    title: newItem.textArray.first ?? Design.defaultText,
                                    body: newItem.textArray.last ?? Design.defaultText,
                                    date: newItem.date.convertLocalization(),
                                    workState: state)
        
        return data
    }
}
