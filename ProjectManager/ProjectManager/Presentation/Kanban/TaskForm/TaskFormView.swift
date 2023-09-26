//
//  TaskAddView.swift
//  ProjectManager
//
//  Created by Minsup & Whales on 2023/09/20.
//

import SwiftUI

struct TaskFormView: View {
    @EnvironmentObject var kanbanViewModel: KanbanViewModel
    @ObservedObject var taskFormViewModel = TaskFormViewModel()
    
    var body: some View {
        VStack {
            TextField("제목을 입력하세요", text: $taskFormViewModel.title)
                .padding(8)
                .background {
                    Rectangle()
                        .fill(.background)
                        .shadow(color: .secondary, radius: 3, x: 2, y: 2)
                }
            
            DatePicker(
                "날짜를 입력하세요",
                selection: $taskFormViewModel.date,
                displayedComponents: .date
            )
            .datePickerStyle(.wheel)
            .labelsHidden()
            
            TextEditor(text: $taskFormViewModel.content)
                .padding(8)
                .background {
                    Rectangle()
                        .fill(.background)
                        .shadow(color: .secondary, radius: 3, x: 2, y: 2)
                }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Cancel") {
                    kanbanViewModel.setFormVisible(false)
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Done") {
                    let task = taskFormViewModel.returnTask()
                    kanbanViewModel.create(task)
                    kanbanViewModel.setFormVisible(false)
                }
                .disabled(taskFormViewModel.title.isEmpty)
            }
        }
        .padding()
    }
}

struct TaskAddView_Previews: PreviewProvider {
    static var previews: some View {
        TaskFormView()
    }
}
