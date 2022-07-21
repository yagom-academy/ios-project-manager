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
    
    var cellIndex: Int
    
    var body: some View {
        NavigationView {
            EditElementView(editViewModel: editViewModel,
                            cellIndex: cellIndex)
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
                        editViewModel.editTask(task: editViewModel.service.tasks[cellIndex])
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
        EditView(editViewModel: EditViewModel(withService: TaskManagementService()), cellIndex: 0)
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
