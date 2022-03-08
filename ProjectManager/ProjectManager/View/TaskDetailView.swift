//
//  TaskDetailView.swift
//  ProjectManager
//
//  Created by JeongTaek Han on 2022/03/08.
//

import SwiftUI

struct TaskDetailView: View {
    
    @ObservedObject var viewModel: ProjectManagerViewModel
    @Binding var isShowingAddSheet: Bool
    
    let task: Task? = nil
    
    @State private var title = ""
    @State private var date = Date()
    @State private var description = ""
    
    var body: some View {
        
        NavigationView {
            VStack(alignment: .center, spacing: 20.0) {
                TextField("Text", text: $title)
                    .background(Rectangle()
                            .shadow(radius: 5)
                            .foregroundColor(.white))
                DatePicker(
                    "",
                    selection: $date,
                    displayedComponents: [.date]
                )
                .datePickerStyle(.wheel)
                .labelsHidden()
                TextEditor(text: $description)
                    .shadow(radius: 5)
            }
            .padding()
            .navigationTitle("TODO")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        viewModel.create(title: title, description: description, dueDate: date)
                        isShowingAddSheet.toggle()
                    }) {
                        Text("Done")
                    }
                }
            }
        }
        
    }
    
}
