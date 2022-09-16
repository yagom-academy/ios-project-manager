//
//  TodoListEditView.swift
//  ProjectManager
//
//  Created by 재재, 언체인 on 2022/09/12.
//

import SwiftUI

struct TodoListEditView: View {
    @StateObject var viewModel = ProjectModalViewModel()

    var body: some View {
        VStack {
            TodoListEditTitleView()
            TodoListEditTitleTextView(viewModel: viewModel)
            TodoListEditDatePickerView(viewModel: viewModel)
            TodoListEditDetailTextView(viewModel: viewModel)
        }
    }
}

struct TodoListEditTitleView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        HStack {
            Button(action: {
                dismiss()
            }, label: {
                Text("Edit")
                    .font(.title3)
            })
            //            .onDisappear {
            //                project = [Project(id: viewModel.id,
            //                                   status: viewModel.status,
            //                                   title: viewModel.title,
            //                                   detail: viewModel.detail,
            //                                   date: viewModel.date)]
            //            }
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
        }
    }
}

struct TodoListEditTitleTextView: View {
    @ObservedObject var viewModel: ProjectModalViewModel

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
    }
}

struct TodoListEditDatePickerView: View {
    @ObservedObject var viewModel: ProjectModalViewModel

    var body: some View {
        DatePicker("",
                   selection: $viewModel.date,
                   displayedComponents: .date)
        .datePickerStyle(WheelDatePickerStyle())
        .labelsHidden()
    }
}

struct TodoListEditDetailTextView: View {
    @ObservedObject var viewModel: ProjectModalViewModel

    var body: some View {
        TextEditor(text: $viewModel.detail)
            .font(.body)
            .frame(width: 680, height: 530, alignment: .center)
            .shadow(color: .gray, radius: 8, x: 0, y: 0)
            .padding(12)
            .disableAutocorrection(true)
    }
}
