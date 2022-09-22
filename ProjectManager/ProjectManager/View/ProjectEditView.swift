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

    var body: some View {
        VStack {
            ProjectEditTitleView(viewModel: viewModel, projects: $projects)
            ProjectEditTitleTextView(viewModel: viewModel)
            ProjectEditDatePickerView(viewModel: viewModel)
            ProjectEditDetailTextView(viewModel: viewModel)
        }
    }

    struct ProjectEditTitleView: View {
        @Environment(\.dismiss) var dismiss
        @ObservedObject var viewModel: ProjectModalViewModel
        @Binding var projects: [Project]

        var body: some View {
            ZStack {
                Rectangle()
                    .frame(width: 710, height: 80, alignment: .center)
                    .foregroundColor(Color("ZEZEColor"))
                HStack {
                    Button(action: {
                        viewModel.isTappedEditButton()
                    }, label: {
                        Text(NameSpace.editButton)
                            .font(.title3.monospacedDigit().bold())
                            .foregroundColor(Color.white)
                    })
                    .padding(15)
                    Spacer()
                    Text(NameSpace.projectTitle)
                        .font(.title.monospacedDigit().bold())
                        .foregroundColor(Color.white)
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
                        dismiss()
                    }, label: {
                        Text(NameSpace.doneButton)
                            .font(.title3.monospacedDigit().bold())
                            .foregroundColor(Color.white)
                            .padding(15)
                    })
                }
            }
        }
    }

    struct ProjectEditTitleTextView: View {
        @ObservedObject var viewModel: ProjectModalViewModel

        var body: some View {
            ZStack {
                Rectangle()
                    .frame(width: 655, height: 55, alignment: .center)
                    .foregroundColor(Color("BorderColor"))
                TextField(NameSpace.titleSpaceHolder, text: $viewModel.title)
                    .padding()
                    .frame(width: 650, height: 50, alignment: .center)
                    .cornerRadius(30)
                    .background(Color(.systemBackground))
                    .padding(12)
                    .disableAutocorrection(true)
            }
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
            ZStack {
                Rectangle()
                    .fill(Color("BorderColor"))
                    .frame(width: 685, height: 535, alignment: .center)
                TextEditor(text: $viewModel.detail)
                    .font(.body)
                    .frame(width: 680, height: 530, alignment: .center)
                    .padding(12)
                    .disableAutocorrection(true)
                    .disabled(viewModel.isDisable)
            }
        }
    }
}

extension ProjectEditView {
    enum NameSpace {
        static let projectTitle = "PROJECT MANAGER"
        static let editButton = "EDIT"
        static let doneButton = "DONE"
        static let titleSpaceHolder = "Title"
    }
}
