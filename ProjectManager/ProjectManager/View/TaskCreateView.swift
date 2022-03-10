//
//  TaskCreateView.swift
//  ProjectManager
//
//  Created by JeongTaek Han on 2022/03/09.
//

import SwiftUI

struct TaskCreateView: View {
    
    @EnvironmentObject private var viewModel: ProjectManagerViewModel
    @Binding var isShowSheet: Bool
    
    @State private var title = String()
    @State private var date = Date()
    @State private var description = String()
    
    var body: some View {
        let taskForm = TaskFormContainerView(title: $title, date: $date, description: $description)
        
        NavigationView {
            taskForm
                .padding()
                .navigationTitle("TODO")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            isShowSheet.toggle()
                        }) {
                            Text("Cancel")
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            viewModel.create(
                                title: taskForm.title,
                                description: taskForm.description,
                                dueDate: taskForm.date
                            )
                            isShowSheet.toggle()
                        }) {
                            Text("Done")
                        }
                    }
                }
        }
        
    }
    
}
