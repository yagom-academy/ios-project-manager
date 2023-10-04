//
//  TaskFormProtocol.swift
//  ProjectManager
//
//  Created by Minsup & Whales on 2023/09/29.
//

import SwiftUI

protocol TaskFormProtocol: ObservableObject {
    var task: Task { get }
    
    var title: String { get set }
    var content: String { get set }
    var date: Date { get set }
    
    var formTitle: String { get }
    var formSize: CGSize { get }
    var formWidth: CGFloat { get }
    var formHeight: CGFloat { get }
    
    var formMode: FormMode { get }
    var isEditable: Bool { get set }    
}

enum FormMode {
    case create, edit
}

extension TaskFormProtocol {
    var formWidth: CGFloat {
        formSize.width * 0.45
    }
    
    var formHeight: CGFloat {
        formSize.width * 0.6
    }
}
