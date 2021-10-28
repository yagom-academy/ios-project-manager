//
//  TodoViewModel.swift
//  ProjectManager
//
//  Created by Yongwoo Marco on 2021/10/28.
//

import Foundation

final class TodoViewModel: ObservableObject {
    @Published var todos: [Todo] = []
}
