//
//  TodoService.swift
//  ProjectManager
//
//  Created by Red and Taeangel on 2022/07/12.
//

import Foundation

class TodoService: ObservableObject {
  @Published var todoList: [Todo] = [
    Todo(title: "1Title", content: "blablabla", status: .todo),
    Todo(title: "2Title", content: "blablabla", status: .doing),
    Todo(title: "3Title", content: "blablabla", status: .doing),
    Todo(title: "4Title", content: "blablabla", status: .done),
    Todo(title: "5Title", content: "blablabla", status: .doing),
    Todo(title: "6Title", content: "blablabla", status: .todo),
    Todo(title: "7Title", content: "blablabla", status: .todo),
    Todo(title: "8Title", content: "blablabla", status: .doing),
    Todo(title: "9Title", content: "blablabla", status: .done),
    Todo(title: "10Title", content: "blablabla", status: .todo),
    Todo(title: "11Title", content: "blablabla", status: .done),
    Todo(title: "12Title", content: "blablabla", status: .todo),
    Todo(title: "13Title", content: "heydaybay", status: .done)
  ]
}
