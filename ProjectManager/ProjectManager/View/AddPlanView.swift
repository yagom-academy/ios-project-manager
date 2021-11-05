//
//  AddPlanView.swift
//  ProjectManager
//
//  Created by 이윤주 on 2021/11/03.
//

import SwiftUI

struct AddPlanView: View {
    @Binding var showsAddView: Bool
    @ObservedObject var viewModel: ProjectPlanViewModel
    @State private var title = ""
    @State private var deadline = Date()
    @State private var description = """
    기분 좋은 하루 보내고 있나요?
    할 일을 입력해주세요.
    """
    private var newPlan: ProjectToDoList.Plan {
        return ProjectToDoList.Plan(state: .toDo, title: title, description: description, deadline: deadline)
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
            .navigationTitle("TODO")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        self.showsAddView = false
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        viewModel.add(newPlan)
                        self.showsAddView = false
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}
