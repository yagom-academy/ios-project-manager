//
//  EditView.swift
//  ProjectManager
//
//  Created by OneTool, marisol on 2022/07/06.
//

import SwiftUI

struct EditView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var editViewModel: EditViewModel
    let task: Task
    
    var body: some View {
        NavigationView {
            EditElementView(task: task)
                .navigationTitle(TaskType.todo.title)
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarColor(.systemGray5)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("Cancel")
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            editViewModel.doneButtonTapped(task: task)
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("Done")
                        }
                    }
                }
        }
        .navigationViewStyle(.stack)
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(editViewModel: EditViewModel(withService: TaskManagementService()),
                 task: Task(title: "Title", date: Date(), body: "body", type: .todo))
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
