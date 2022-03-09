//
//  DetailScene.swift
//  ProjectManager
//
//  Created by 이호영 on 2022/03/08.
//

import SwiftUI

struct DetailScene: View {
    @EnvironmentObject var viewModel: ProjectManagerViewModel

    @State private var title: String
    @State private var content: String
    @State private var limitDate: Date
    
    @Binding var showDetailScene: Bool
    @State var isEditingMode: Bool = false
    
    var task: Task
    
    init(task: Task, showDetailScene: Binding<Bool>) {
        _showDetailScene = showDetailScene
        _title = State(initialValue: task.title)
        _content = State(initialValue: task.content)
        _limitDate = State(initialValue: task.limitDate)
        self.task = task
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
                            self.viewModel.updateTask(
                                task: task,
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
