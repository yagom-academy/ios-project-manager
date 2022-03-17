//
//  DetailScene.swift
//  ProjectManager
//
//  Created by 이호영 on 2022/03/08.
//

import SwiftUI

struct DetailScene: View {
    @ObservedObject var taskViewModel: TaskViewModel

    @State private var title: String
    @State private var content: String
    @State private var limitDate: Date
    
    @State private var isEditingMode: Bool = false
    
    @Binding var showDetailScene: Bool
    
    private var task: Task
    
    init(taskViewModel: TaskViewModel, task: Task, showDetailScene: Binding<Bool>) {
        self.taskViewModel = taskViewModel
        self.task = task
        _showDetailScene = showDetailScene
        _title = State(initialValue: task.title)
        _content = State(initialValue: task.content)
        _limitDate = State(initialValue: task.limitDate)
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                TaskEditView(
                    title: $title,
                    content: $content,
                    limitDate: $limitDate
                ).disabled(!isEditingMode)
            }
            .padding()
            .navigationBarTitle("TODO", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        if isEditingMode {
                            title = task.title
                            content = task.content
                            limitDate = task.limitDate
                        }
                        isEditingMode.toggle()
                    } label: {
                        if isEditingMode {
                            Text("Cancel")
                        } else {
                            Text("Edit")
                        }
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        if isEditingMode {
                            self.taskViewModel.updateTask(
                                taskID: task.id,
                                title: $title.wrappedValue,
                                content: $content.wrappedValue,
                                limitDate: $limitDate.wrappedValue
                            )
                        }
                        showDetailScene = false
                    } label: {
                        Text("Done")
                    }
                }
            }
        }
    }
}
