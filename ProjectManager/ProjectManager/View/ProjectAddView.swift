//
//  ProjectAddView.swift
//  ProjectManager
//
//  Created by 재재, 언체인  on 2022/09/12.
//

import SwiftUI

struct ProjectAddView: View {
    @ObservedObject var viewModel: ProjectModalViewModel
    @Binding var project: [Project]
    @Binding var showModal: Bool

    init(viewModel: ProjectModalViewModel, project: Binding<[Project]>, showModal: Binding<Bool>) {
        self.viewModel = viewModel
        self._project = project
        self._showModal = showModal
    }

    var body: some View {
        VStack {
            ProjectAddTitleView(viewModel: viewModel, projects: $project, showModal: $showModal)
            ProjectAddTitleTextView(viewModel: viewModel)
            ProjectAddDatePickerView(viewModel: viewModel)
            ProjectAddDetailTextView(viewModel: viewModel)
        }
    }

    struct ProjectAddTitleView: View {
        @ObservedObject var viewModel: ProjectModalViewModel
        @Binding var projects: [Project]
        @Binding var showModal: Bool

        var body: some View {
            HStack {
                Button(action: {
                    showModal = false
                }, label: {
                    Text(NameSpace.cancelButton)
                        .font(.title3.monospacedDigit().bold())
                })
                .padding(15)
                Spacer()
                Text(NameSpace.projectTitle)
                    .font(.title.monospacedDigit().bold())
                Spacer()
                Button(action: {
                    projects.append(Project(id: viewModel.id,
                                            status: .todo,
                                            title: viewModel.title,
                                            detail: viewModel.detail,
                                            date: viewModel.date))
                    showModal = false
                }, label: {
                    Text(NameSpace.doneButton)
                        .font(.title3.monospacedDigit().bold())
                        .padding(15)
                })
            }
            .foregroundColor(Color("ZEZEColor"))
        }
    }

    struct ProjectAddTitleTextView: View {
        @ObservedObject var viewModel: ProjectModalViewModel

        var body: some View {
            TextField(NameSpace.titleSpaceHolder, text: $viewModel.title)
                .padding()
                .background(Color(.systemBackground))
                .disableAutocorrection(true)
                .border(Color("BorderColor"), width: 3)
                .padding([.leading, .trailing], 10)
        }
    }

    struct ProjectAddDatePickerView: View {
        @ObservedObject var viewModel: ProjectModalViewModel

        var body: some View {
            DatePicker("",
                       selection: $viewModel.date,
                       displayedComponents: .date)
            .datePickerStyle(WheelDatePickerStyle())
            .labelsHidden()
        }
    }

    struct ProjectAddDetailTextView: View {
        @ObservedObject var viewModel: ProjectModalViewModel

        var body: some View {
            ZStack {
                if viewModel.detail.isEmpty {
                    TextEditor(text: $viewModel.placeholder)
                        .font(.body)
                        .border(Color("BorderColor"), width: 3)
                        .padding([.leading, .bottom, .trailing], 10)
                }
                TextEditor(text: $viewModel.detail)
                    .font(.body)
                    .background(Color(.systemBackground))
                    .opacity(viewModel.detail.isEmpty ? 0.15 : 1)
                    .disableAutocorrection(true)
                    .border(Color("BorderColor"), width: 3)
                    .padding([.leading, .bottom, .trailing], 10)
            }
        }
    }
}

extension ProjectAddView {
    enum NameSpace {
        static let projectTitle = "PROJECT MANAGER"
        static let cancelButton = "CANCEL"
        static let doneButton = "DONE"
        static let titleSpaceHolder = "TITLE"
    }
}
