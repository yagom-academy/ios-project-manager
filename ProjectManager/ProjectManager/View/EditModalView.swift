//
//  EditModalView.swift
//  ProjectManager
//
//  Created by 이윤주 on 2021/11/03.
//

import SwiftUI

struct EditModalView: View {
    enum EditType {
        case add
        case edit
    }
    
    let plan: ProjectToDoList.Plan
    let editType: EditType
    @Binding var showsAddView: Bool
    @ObservedObject var viewModel: ProjectPlanViewModel
    @State private var isEditable = false
    @State private var title = ""
    @State private var deadline = Date()
    @State private var description = """
    기분 좋은 하루 보내고 있나요?
    할 일을 입력해주세요.
    """
    
    init(plan: ProjectToDoList.Plan?, editType: EditType, showsAddView: Binding<Bool>, viewModel: ProjectPlanViewModel) {
        if let plan = plan {
            self.plan = plan
            _title = State(initialValue: plan.title)
            _deadline = State(initialValue: plan.deadline)
            _description = State(initialValue: plan.description)
        } else {
            self.plan = ProjectToDoList.Plan(state: .toDo, title: "", description: "", deadline: Date())
        }
        self.editType = editType
        _showsAddView = showsAddView
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Title", text: $title)
                    .padding()
                    .textFieldStyle(.roundedBorder)
                DatePicker("", selection: $deadline)
                    .datePickerStyle(.wheel)
                    .fixedSize()
                TextEditor(text: $description)
                    .padding(.horizontal)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color(.systemGray5), lineWidth: 1.0)
                            .padding(.horizontal)
                    )
                Spacer()
            }
            .disabled(!isEditable)
            .navigationTitle("TODO")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        self.showsAddView = false
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    switch editType {
                    case .add:
                        Button("Done") {
                            viewModel.add(title: title, description: description, deadline: deadline)
                            self.showsAddView = false
                        }
                    case .edit:
                        Button {
                            if isEditable {
                                viewModel.edit(plan.id, title: title, description: description, deadline: deadline)
                                self.showsAddView = false
                            } else {
                                self.isEditable.toggle()
                            }
                        } label: {
                            if isEditable {
                                Text("Done")
                            } else {
                                Text("Edit")
                            }
                        }
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}

struct AddPlanView_Previews: PreviewProvider {
    static var previews: some View {
        EditModalView(plan: ProjectToDoList.Plan(state: .toDo,
                                               title: "마라탕 먹기",
                                               description: "마라탕 먹으러가야지",
                                               deadline: Date()),
                    editType: .add,
                    showsAddView: .constant(true),
                    viewModel: ProjectPlanViewModel()
        )
    }
}
