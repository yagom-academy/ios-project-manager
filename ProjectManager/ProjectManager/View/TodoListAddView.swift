//
//  TodoListAddView.swift
//  ProjectManager
//
//  Created by 재재, 언체인  on 2022/09/12.
//

import SwiftUI

struct TodoListAddView: View {
    @StateObject var viewModel = ProjectAddViewModel()
    @Binding var project: [Project]
    var body: some View {
        VStack {
            TodoListAddTitleView(project: $project, viewModel: viewModel)
            TodoListAddTitleTextView(viewModel: viewModel)
            TodoListAddDatePickerView(viewModel: viewModel)
            TodoListAddDetailTextView(viewModel: viewModel)
        }
    }
}

struct TodoListAddTitleView: View {
    @Binding var project: [Project]
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: ProjectAddViewModel
    var body: some View {
        HStack {
            Button(action: {
                dismiss()
            }, label: {
                Text("Cancel")
                    .font(.title3)
            })
            .padding(10)
            Spacer()
            Text("Project Manager")
                .font(.title)
            Spacer()
            Button(action: {
                dismiss()
            }, label: {
                Text("Done")
                    .font(.title3)
                    .padding(10)
            })
        }.onDisappear {
            project.append(Project(id: viewModel.id, status: .todo, title: viewModel.title, detail: viewModel.detail, date: viewModel.date))
        }
    }
}

struct TodoListAddDatePickerView: View {
    @ObservedObject var viewModel: ProjectAddViewModel

    var body: some View {
        DatePicker("",
                   selection: $viewModel.date,
                   displayedComponents: .date)
        .datePickerStyle(WheelDatePickerStyle())
        .labelsHidden()
    }
}

struct TodoListAddDetailTextView: View {
    @ObservedObject var viewModel: ProjectAddViewModel

    var body: some View {

        ZStack {
            if viewModel.detail.isEmpty {
                TextEditor(text: $viewModel.placeholder)
                    .font(.body)
                    .disabled(true)
                    .padding()
            }
            TextEditor(text: $viewModel.detail)
                .font(.body)
                .opacity(viewModel.detail.isEmpty ? 0.25 : 1)
                .padding()
                .disableAutocorrection(true)
        }
    }
}

struct TodoListAddTitleTextView: View {
    @ObservedObject var viewModel: ProjectAddViewModel

    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color(.systemBackground))
                .frame(width: 670, height: 60, alignment: .center)
                .shadow(color: .gray, radius: 5, x: 10, y: 10)
            TextField("Title", text: $viewModel.title)
                .padding()
                .frame(width: 670, height: 60, alignment: .center)
                .background(Color(.systemBackground))
                .padding(12)
        }
    }
}
