//
//  ModalView.swift
//  ProjectManager
//
//  Created by 박태현 on 2021/11/01.
//

import SwiftUI

struct ModalView: View {
    enum ModalType {
        case add
        case edit
    }

    @EnvironmentObject var projectListViewModel: ProjectListViewModel
//    @StateObject var viewModel: ProjectRowViewModel
    @Binding var isDone: Bool
    @State private var title: String = ""
    @State private var date: Date = Date()
    @State private var description: String = ""
    @State private var isEdit: Bool = false
    let modalViewType: ModalType
    let projectID: UUID?

    var body: some View {
            NavigationView {
                GeometryReader { geometry in
                VStack {
                    ScrollView {
                        TextField("Title", text: $title)
                            .textFieldStyle(.roundedBorder)
                        DatePicker("Title",
                                   selection: $date,
                                   displayedComponents: .date)
                            .datePickerStyle(.wheel)
                            .labelsHidden()
                        
                        TextEditor(text: $description)
                            .frame(width: geometry.size.width,
                                   height: geometry.size.height * 0.65,
                                   alignment: .center)
                    }
                    
                }
            }
            .shadow(radius: 5)
            .disabled(modalViewType == .add ? isEdit: !isEdit)
            .padding()
            .navigationTitle("TODO")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    customTrailingButton
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    customLeadingButton
                }
            }
        }
            .onAppear() {
                guard let id = projectID else { return }
                guard let viewModel = projectListViewModel.showProject(from: id) else { return }
                self.title = viewModel.title
                self.date = viewModel.date
                self.description = viewModel.description
            }
    }
}

extension ModalView {
    private var customLeadingButton: some View {
        switch modalViewType {
        case .edit:
            return Button {
                isEdit ? (isDone = false): (isEdit = true)
            } label: {
                isEdit ? Text("Cancel"): Text("Edit")
            }
        case .add:
            return Button {
                isDone = false
            } label: {
                Text("Cancel")
            }
        }
    }
    
    private var customTrailingButton: some View {
        Button {
            if modalViewType == .add {
                projectListViewModel.action(
                    .create(project: Project(title: title,
                                             description: description,
                                             date: date,
                                             type: .todo)))
            } else if isEdit && modalViewType == .edit {
                guard let id = projectID else { return }
                guard let viewModel = projectListViewModel.showProject(from: id) else { return }
                projectListViewModel.action(
                    .update(project: Project(id: id,
                                             title: title,
                                             description: description,
                                             date: date,
                                             type: viewModel.type)))
                print(title)
            }
            isDone = false
        } label: {
            Text("Done")
        }
    }
}

//
//struct NewTodoView_Previews: PreviewProvider {
//    static var previews: some View {
//        ModalView(isDone: .constant(false),
//                  modalViewType: .add,
//                  currentProject: )
//    }
//}
