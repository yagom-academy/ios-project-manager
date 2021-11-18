//
//  NewTaskView.swift
//  ProjectManager
//
//  Created by 김준건 on 2021/11/05.
//

import SwiftUI

struct ManageTaskView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var viewModel: TaskListViewModel
    @State var title = ""
    @State var date = Date()
    @State var message: String = ""
    var task: TLTask?
    
    var body: some View {
        NavigationView {
            List {
                TextField("제목을 입력하세요", text: $title)
                    .textFieldStyle(.roundedBorder)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 2))
                    .allowsTightening(true)
                DatePicker("날짜를 선택하세요", selection: $date, displayedComponents: .date)
                    .datePickerStyle(.wheel).labelsHidden()
                TextEditor(text: $message)
                    .padding()
                    .frame(height: 300,alignment: .leading)
                
            }
            .listStyle(.grouped)
            .navigationTitle("Project Manager")
            .navigationBarTitleDisplayMode(.inline)
            
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Edit") {
                        viewModel.updateTaskList(task: task, status: task?.status ?? .DONE, title: title, message: message, date: date)
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        if !title.isEmpty {
                            viewModel.addNewTask(title: title, message: message,date: date, status: .TODO)
                            presentationMode.wrappedValue.dismiss()
                        }
                    } label: {
                        Text("Done")
                    }

                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.automatic)
    }
}
