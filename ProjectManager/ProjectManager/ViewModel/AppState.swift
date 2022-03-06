//
//  AppState.swift
//  ProjectManager
//
//  Created by 이호영 on 2022/03/07.
//

import Foundation

class AppState: ObservableObject {
    @Published var taskStorage = TaskStorage()
}
