//
//  TaskFormViewModel.swift
//  ProjectManager
//
//  Created by Minsup & Whales on 2023/09/22.
//

import SwiftUI

final class TaskFormViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var content: String = ""
    @Published var date: Date = Date()
    
    let formTitle: String
    private let formSize: CGSize
    
    init(formTitle: String, formSize: CGSize) {
        self.formTitle = formTitle
        self.formSize = formSize
    }
    
    var formWidth: CGFloat {
        formSize.width * 0.45
    }
    
    var formHeight: CGFloat {
        return formSize.width * 0.6
    }
    
    var task: Task {
        Task(title: title, content: content, date: date)
    }
}
