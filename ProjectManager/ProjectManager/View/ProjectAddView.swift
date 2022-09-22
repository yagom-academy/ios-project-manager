//
//  ProjectEditView.swift
//  ProjectManager
//
//  Created by 재재, 언체인 on 2022/09/12.
//

import SwiftUI

struct ProjectEditView: View {
    @ObservedObject var viewModel: ProjectModalViewModel
    @Binding var projects: [Project]
    @Binding var selectedProject: Project?

    var body: some View {
        VStack {
            ProjectEditTitleView(viewModel: viewModel, projects: $projects, selectedProject: $selectedProject)
            ProjectEditTitleTextView(viewModel: viewModel)
            ProjectEditDatePickerView(viewModel: viewModel)
            ProjectEditDetailTextView(viewModel: viewModel)
        }
    }

    struct ProjectEditTitleView: View {
        @ObservedObject var viewModel: ProjectModalViewModel
        @Binding var projects: [Project]
        @Binding var selectedProject: Project?

        var body: some View {
            HStack {
                Button(action: {
                    viewModel.isTappedEditButton()
                }, label: {
                    Text(NameSpace.editButton)
                        .font(.title3.monospacedDigit().bold())
                })
                .padding(15)
                Spacer()
                Text(NameSpace.projectTitle)
                    .font(.title.monospacedDigit().bold())
                Spacer()
                Button(action: {
                    projects = projects.map { project in
                        guard project.id == viewModel.id else { return project }
                        let changedProject = Project(id: viewModel.id,
                                                     status: viewModel.status,
                                                     title: viewModel.title,
                                                     detail: viewModel.detail,
                                                     date: viewModel.date)
                        return changedProject
                    }
                    selectedProject = nil
                }, label: {
                    Text(NameSpace.doneButton)
                        .font(.title3.monospacedDigit().bold())
                        .padding(15)
                })
            }
            .foregroundColor(Color("ZEZEColor"))
        }
    }

    struct ProjectEditTitleTextView: View {
        @ObservedObject var viewModel: ProjectModalViewModel

        var body: some View {
            TextField(NameSpace.titleSpaceHolder, text: $viewModel.title)
                .padding()
                .background(Color(.systemBackground))
                .disableAutocorrection(true)
                .border(Color("BorderColor"), width: 3)
                .padding([.leading, .trailing], 10)
                .disabled(viewModel.isDisable)
        }
    }

    struct ProjectEditDatePickerView: View {
        @ObservedObject var viewModel: ProjectModalViewModel

        var body: some View {
            DatePicker("",
                       selection: $viewModel.date,
                       displayedComponents: .date)
            .datePickerStyle(WheelDatePickerStyle())
            .labelsHidden()
            .disabled(viewModel.isDisable)
        }
    }

    struct ProjectEditDetailTextView: View {
        @ObservedObject var viewModel: ProjectModalViewModel

        var body: some View {
            TextEditor(text: $viewModel.detail)
                .font(.body)
                .disableAutocorrection(true)
                .border(Color("BorderColor"), width: 3)
                .padding([.leading, .bottom, .trailing], 10)
                .disabled(viewModel.isDisable)
        }
    }
}

extension ProjectEditView {
    enum NameSpace {
        static let projectTitle = "PROJECT MANAGER"
        static let editButton = "EDIT"
        static let doneButton = "DONE"
        static let titleSpaceHolder = "TITLE"
    }
}
