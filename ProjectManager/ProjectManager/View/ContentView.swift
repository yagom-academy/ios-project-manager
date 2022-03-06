//
//  ContentView.swift
//  ProjectManager
//
//  Created by 예거 on 2022/02/28.
//

import SwiftUI

struct ContentView: View {
    
    let taskManager = TaskManager(tasks: [
        Task(title: "긴 제목 긴 제목 긴 제목 긴 제목 긴 제목 긴 제목 긴 제목 긴 제목", body: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.", dueDate: Date()),
        Task(title: "1번 할일", body: "1줄\n2줄\n3줄", dueDate: Date(timeIntervalSinceNow: -86400 * 30)),
        Task(title: "2번 할일", body: "1줄\n2줄", dueDate: Date(timeIntervalSinceNow: -86400 * 10)),
        Task(title: "3번 할일", body: "1줄", dueDate: Date(timeIntervalSinceNow: 86400 * 10)),
        Task(title: "4번 할일", body: "1줄\n2줄\n3줄\n4줄", dueDate: Date(timeIntervalSinceNow: 86400 * 30))
    ])
    
    var body: some View {
        HStack {
            TaskListView(tasks: taskManager.todoTasks)
            TaskListView(tasks: taskManager.todoTasks)
            TaskListView(tasks: taskManager.todoTasks)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 15.0, *) {
            ContentView()
                .previewInterfaceOrientation(.landscapeRight)
        } else {
            ContentView()
        }
    }
}
