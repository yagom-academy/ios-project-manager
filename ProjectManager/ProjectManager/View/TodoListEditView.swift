//
//  TodoListEditView.swift
//  ProjectManager
//
//  Created by 재재, 언체인 on 2022/09/12.
//

import SwiftUI

struct TodoListEditView: View {
    @ObservedObject var viewModel: ProjectModalViewModel
    @State var isDisabled = true
    @Binding var projects: [Project]

    var body: some View {
        VStack {
            TodoListEditTitleView(viewModel: viewModel, isDisabled: $isDisabled, projects: $projects)
            TodoListEditTitleTextView(viewModel: viewModel, isDisabled: $isDisabled)
            TodoListEditDatePickerView(viewModel: viewModel, isDisabled: $isDisabled)
            TodoListEditDetailTextView(viewModel: viewModel, isDisabled: $isDisabled)
        }
    }
}

struct TodoListEditTitleView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: ProjectModalViewModel
    @Binding var isDisabled: Bool
    @Binding var projects: [Project]

    var body: some View {
        HStack {
            Button(action: {
                isDisabled = false
            }, label: {
                Text("Edit")
                    .font(.title3)
            })
            .padding(10)
            Spacer()
            Text("Project Manager")
                .font(.title)
            Spacer()
            Button(action: {
                projects = [Project(id: viewModel.id,
                                        status: viewModel.status,
                                        title: viewModel.title,
                                        detail: viewModel.detail,
                                        date: viewModel.date)]
                dismiss()
            }, label: {
                Text("Done")
                    .font(.title3)
                    .padding(10)
            })
        }
    }
}

struct TodoListEditTitleTextView: View {
    @ObservedObject var viewModel: ProjectModalViewModel
    @Binding var isDisabled: Bool

    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color(.systemBackground))
                .frame(width: 680, height: 60, alignment: .center)
                .shadow(color: .gray, radius: 8, x: 0, y: 0)
            TextField("Title", text: $viewModel.title)
                .padding()
                .background(Color(.systemBackground))
                .padding(12)
        }
        .disabled(isDisabled)
    }
}

struct TodoListEditDatePickerView: View {
    @ObservedObject var viewModel: ProjectModalViewModel
    @Binding var isDisabled: Bool

    var body: some View {
        DatePicker("",
                   selection: $viewModel.date,
                   displayedComponents: .date)
        .datePickerStyle(WheelDatePickerStyle())
        .labelsHidden()
        .disabled(isDisabled)
    }
}

struct TodoListEditDetailTextView: View {
    @ObservedObject var viewModel: ProjectModalViewModel
    @Binding var isDisabled: Bool

    var body: some View {
        TextEditor(text: $viewModel.detail)
            .font(.body)
            .frame(width: 680, height: 530, alignment: .center)
            .shadow(color: .gray, radius: 8, x: 0, y: 0)
            .padding(12)
            .disableAutocorrection(true)
            .disabled(isDisabled)
    }
}
