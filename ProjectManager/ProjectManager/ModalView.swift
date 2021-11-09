//
//  ModalView.swift
//  ProjectManager
//
//  Created by Dasoll Park on 2021/11/02.
//

import SwiftUI

enum ModalState {
    case add
    case edit
    case inquire
}

struct ModalView: View {

    @EnvironmentObject var taskViewModel: TaskViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var task: Task
    var taskIndex: Int {
        taskViewModel.tasks.firstIndex(where: { $0.id == task.id }) ?? 0
    }
    @State var modalState: ModalState
    
    var body: some View {
        NavigationView {
            VStack {
                TextField(
                    "Title",
                    text: $taskViewModel.tasks[taskIndex].title
                )
                .frame(height: 44)
                .background(Color.white)
                .shadow(color: .gray, radius: 3, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 2.0)
                .padding(.horizontal)
                
                DatePicker(
                    "",
                    selection: $taskViewModel.tasks[taskIndex].date,
                    displayedComponents: [.date]
                )
                .datePickerStyle(WheelDatePickerStyle())
                .labelsHidden()
                
                TextField(
                    "Description",
                    text: $taskViewModel.tasks[taskIndex].description
                )
                .frame(height: 300, alignment: .top)
                .background(Color.white)
                .shadow(color: .gray, radius: 3, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 2.0)
                .padding(.horizontal)
            }
            .navigationTitle("TODO")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button("Cancel") {
                    self.presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Done"){
                    self.presentationMode.wrappedValue.dismiss()
                })
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ModalView_Previews: PreviewProvider {
    static let viewModel = TaskViewModel()
    static var previews: some View {
        ModalView(task: viewModel.tasks[0], modalState: .inquire)
            .environmentObject(viewModel)
    }
}
